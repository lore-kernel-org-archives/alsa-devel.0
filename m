From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/24] ALSA: ctl: refactoring compat layer
Date: Wed, 29 Nov 2017 11:18:57 +0900
Message-ID: <2d4d3cad-381e-519a-ff18-c93ad2923fe6@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
 <s5h1skjmp4w.wl-tiwai@suse.de>
 <41eb40d0-8e12-e6d0-abf5-d37915eb503b@sakamocchi.jp>
 <s5hk1yaqzsp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 8E7ED267387
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 03:19:00 +0100 (CET)
In-Reply-To: <s5hk1yaqzsp.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 28 2017 22:48, Takashi Iwai wrote:
> Well, both the code size and the code performance are rather the basic
> question.  Usually a code refactoring is done because of performance,
> not because of the code itself.  IOW, the refactoring is based on the
> implicit rule -- a better code performs better.  If it's not true, the
> only exception is about the portability.  But I don't think that your
> patchset would improve that dramatically.  It's the point making me
> hesitating to apply the patches.
> 
> In short, the patch result doesn't look convincing enough.  At least,
> I'd like to see an improvement in the resultant binary.

Hm. For these concerns, I can propose additional improvements to this
patchset.
  * Use kernel stack for buffers to convert layout of structure
   - (pros) This is for your concern about an overhead to use additional
     kernel heap. Additionally, this can reduce one member from handler
     structure because no need to calculate original buffer size.
   - (cons) two buffers for purse consumes the kernel stack by around
     2000 bytes.
  * Change some functions in 'control.c' to get 'void *' as an argument.
   - (pros) these functions can get callback from 'control_compat.c'
     directly. As a result, .text section can be decreased.
   - (cons) these functions lose type information for the argument. This
     also can fake static code analyzer, perhaps.

In the end of this message, I attach a diff for this idea, on the last
patch of this set. When applying, the binary is shrunk.

$ size snd.ko.master
snd.ko.master  :
section                      size   addr
.note.gnu.build-id             36      0
.text                       26244      0 <-
.init.text                    470      0
.exit.text                     45      0
.altinstr_replacement          20      0
__ksymtab                     832      0
__ksymtab_gpl                  96      0
.rodata                      1784      0 <-
.rodata.str1.1                733      0
.rodata.str1.8                559      0
__ksymtab_strings            1133      0
.modinfo                      423      0
__param                       120      0
.orc_unwind_ip               5224      0
.orc_unwind                  7836      0
.smp_locks                     24      0
.altinstructions               52      0
.data                         480      0
__bug_table                    12      0
.gnu.linkonce.this_module     832      0
.bss                         2240      0
.comment                      324      0
.note.GNU-stack                 0      0
Total                       49519

$ size snd.ko.compat
sound/core/snd.ko  :
section                      size   addr
.note.gnu.build-id             36      0
.text                       26020      0 <-
.init.text                    470      0
.exit.text                     45      0
__ksymtab                     832      0
__ksymtab_gpl                  96      0
.rodata                      1976      0 <-
.rodata.str1.1                763      0
.rodata.str1.8                551      0
__ksymtab_strings            1133      0
.modinfo                      424      0
__param                       120      0
.orc_unwind_ip               5004      0
.orc_unwind                  7506      0
.smp_locks                     24      0
.data                         480      0
__bug_table                    24      0
.gnu.linkonce.this_module     832      0
.bss                         2240      0
.comment                      324      0
.note.GNU-stack                 0      0
Total                       48900

             v4.15-rc1   compat
.text:      26244       26020
.rodata:    1784        1976
total:      49519       48900

If we can accept the negative points, I'll post the revised version.

>>> Also, did you actually test with all possible architectures, not only
>>> trusting the written spec?  It should be relatively easy to set up the
>>> cross-compilation just only for checking this stuff.  You don't need
>>> to build the whole kernel.
>>
>> I've already done it. To check size of structure and offsets of members
>> on it, I've generate assembly list, like:
>>
>> $ cat test.c
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <stddef.h>
>> #include <sound/asound.h>
>> struct snd_ctl_elem_value_32 {
>>      ...
>> } __attribute__((packed));
>> int main(void)
>> {
>>      printf("%zd\n", offsetof(struct snd_ctl_elem_value, value));
>>      return EXIT_SUCCESS;
>> }
>> $ x86_64-linux-gnu-gcc-7 -S -o - /tmp/test.c | grep -B 4 printf
>>      .cfi_def_cfa_register 6
>>      movl    $72, %esi
>>      leaq    .LC0(%rip), %rdi
>>      movl    $0, %eax
>>      call    printf@PLT
>> $ aarch64-linux-gnu-gcc-7 -S -o - /tmp/test.c | grep -B1 printf
>>      mov x1, 72
>>      bl  printf
> 
> There are lots of other architectures supporting 64/32 compatibility,
> e.g. s390, powerpc, sparc, etc.  That's my concern.  At least these
> major active architectures have to be checked (maybe MIPS, too).

If you'd like me to check more architectures, I'll do it. Please send a 
list of architectures to investigate. But in practical points, I'll omit 
s390, sparc and sparc64 because nowadays we have no products based on 
these architectures for consumer use. At least, in data center, sound 
devices are needless.

========== 8< ----------
diff --git a/sound/core/control.c b/sound/core/control.c
index 0aa1f22dcac2..0228d4c3a51d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -744,9 +744,9 @@ static int snd_ctl_card_info(struct snd_card *card, 
struct snd_ctl_file * ctl,
  	return 0;
  }

-static int snd_ctl_elem_list(struct snd_ctl_file *ctl_file,
-			     struct snd_ctl_elem_list *list)
+static int snd_ctl_elem_list(struct snd_ctl_file *ctl_file, void *buf)
  {
+	struct snd_ctl_elem_list *list = buf;
  	struct snd_kcontrol *kctl;
  	struct snd_ctl_elem_id id;
  	unsigned int offset, space, jidx;
@@ -833,9 +833,9 @@ static bool validate_element_member_dimension(struct 
snd_ctl_elem_info *info)
  	return members == info->count;
  }

-static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
-			     struct snd_ctl_elem_info *info)
+static int snd_ctl_elem_info(struct snd_ctl_file *ctl, void *buf)
  {
+	struct snd_ctl_elem_info *info = buf;
  	struct snd_card *card = ctl->card;
  	struct snd_kcontrol *kctl;
  	struct snd_kcontrol_volatile *vd;
@@ -894,9 +894,9 @@ static int snd_ctl_elem_info_user(struct 
snd_ctl_file *ctl, void __user *arg)
  	return err;
  }

-static int snd_ctl_elem_read(struct snd_ctl_file *ctl_file,
-			     struct snd_ctl_elem_value *control)
+static int snd_ctl_elem_read(struct snd_ctl_file *ctl_file, void *buf)
  {
+	struct snd_ctl_elem_value *control = buf;
  	struct snd_kcontrol *kctl;
  	struct snd_kcontrol_volatile *vd;
  	unsigned int index_offset;
@@ -949,9 +949,9 @@ static int snd_ctl_elem_read_user(struct 
snd_ctl_file *ctl_file,
  	return result;
  }

-static int snd_ctl_elem_write(struct snd_ctl_file *ctl_file,
-			      struct snd_ctl_elem_value *control)
+static int snd_ctl_elem_write(struct snd_ctl_file *ctl_file, void *buf)
  {
+	struct snd_ctl_elem_value *control = buf;
  	struct snd_kcontrol *kctl;
  	struct snd_kcontrol_volatile *vd;
  	unsigned int index_offset;
@@ -1255,9 +1255,9 @@ static void snd_ctl_elem_user_free(struct 
snd_kcontrol *kcontrol)
  	kfree(ue);
  }

-static int snd_ctl_elem_add(struct snd_ctl_file *file,
-			    struct snd_ctl_elem_info *info)
+static int snd_ctl_elem_add(struct snd_ctl_file *file, void *buf)
  {
+	struct snd_ctl_elem_info *info = buf;
  	/* The capacity of struct snd_ctl_elem_value.value.*/
  	static const unsigned int value_sizes[] = {
  		[SNDRV_CTL_ELEM_TYPE_BOOLEAN]	= sizeof(long),
@@ -1419,9 +1419,9 @@ static int snd_ctl_elem_add_user(struct 
snd_ctl_file *ctl_file,
  	return err;
  }

-static int snd_ctl_elem_replace(struct snd_ctl_file *ctl_file,
-				struct snd_ctl_elem_info *info)
+static int snd_ctl_elem_replace(struct snd_ctl_file *ctl_file, void *buf)
  {
+	struct snd_ctl_elem_info *info = buf;
  	int err;

  	if (!*info->id.name)
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index ab2ba7994a60..c4ef8aa25131 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -398,54 +398,6 @@ static int __maybe_unused serialize_to_elem_value_i386(
  	return 0;
  }

-static int ctl_compat_ioctl_elem_list_32(struct snd_ctl_file *ctl_file,
-					 void *buf)
-{
-	struct snd_ctl_elem_list *list = buf;
-
-	return snd_ctl_elem_list(ctl_file, list);
-}
-
-static int ctl_compat_ioctl_elem_info_32(struct snd_ctl_file *ctl_file,
-					 void *buf)
-{
-	struct snd_ctl_elem_info *info = buf;
-
-	return snd_ctl_elem_info(ctl_file, info);
-}
-
-static int ctl_compat_ioctl_elem_add_32(struct snd_ctl_file *ctl_file,
-					void *buf)
-{
-	struct snd_ctl_elem_info *info = buf;
-
-	return snd_ctl_elem_add(ctl_file, info);
-}
-
-static int ctl_compat_ioctl_elem_replace_32(struct snd_ctl_file *ctl_file,
-					    void *buf)
-{
-	struct snd_ctl_elem_info *info = buf;
-
-	return snd_ctl_elem_replace(ctl_file, info);
-}
-
-static int ctl_compat_ioctl_elem_read_32(struct snd_ctl_file *ctl_file,
-					 void *buf)
-{
-	struct snd_ctl_elem_value *value = buf;
-
-	return snd_ctl_elem_read(ctl_file, value);
-}
-
-static int ctl_compat_ioctl_elem_write_32(struct snd_ctl_file *ctl_file,
-					  void *buf)
-{
-	struct snd_ctl_elem_value *value = buf;
-
-	return snd_ctl_elem_write(ctl_file, value);
-}
-
  enum {
  	SNDRV_CTL_IOCTL_ELEM_LIST_32 =
  				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
@@ -475,71 +427,72 @@ static long snd_ctl_ioctl_compat(struct file 
*file, unsigned int cmd,
  		int (*func)(struct snd_ctl_file *ctl_file, void *buf);
  		int (*serialize)(struct snd_ctl_file *ctl_file, void *dst,
  				 void *src);
-		unsigned int orig_cmd;
  	} handlers[] = {
  		{
  			SNDRV_CTL_IOCTL_ELEM_LIST_32,
  			deserialize_from_elem_list_32,
-			ctl_compat_ioctl_elem_list_32,
+			snd_ctl_elem_list,
  			serialize_to_elem_list_32,
-			SNDRV_CTL_IOCTL_ELEM_LIST,
  		},
  		{
  			SNDRV_CTL_IOCTL_ELEM_INFO_32,
  			deserialize_from_elem_info_32,
-			ctl_compat_ioctl_elem_info_32,
+			snd_ctl_elem_info,
  			serialize_to_elem_info_32,
-			SNDRV_CTL_IOCTL_ELEM_INFO,
  		},
  		{
  			SNDRV_CTL_IOCTL_ELEM_ADD_32,
  			deserialize_from_elem_info_32,
-			ctl_compat_ioctl_elem_add_32,
+			snd_ctl_elem_add,
  			serialize_to_elem_info_32,
-			SNDRV_CTL_IOCTL_ELEM_ADD,
  		},
  		{
  			SNDRV_CTL_IOCTL_ELEM_REPLACE_32,
  			deserialize_from_elem_info_32,
-			ctl_compat_ioctl_elem_replace_32,
+			snd_ctl_elem_replace,
  			serialize_to_elem_info_32,
-			SNDRV_CTL_IOCTL_ELEM_REPLACE,
  		},
  #if !defined(CONFIG_X86_64) || defined(CONFIG_X86_X32)
  		{
  			SNDRV_CTL_IOCTL_ELEM_READ_32,
  			deserialize_from_elem_value_32,
-			ctl_compat_ioctl_elem_read_32,
+			snd_ctl_elem_read,
  			serialize_to_elem_value_32,
-			SNDRV_CTL_IOCTL_ELEM_READ,
  		},
  		{
  			SNDRV_CTL_IOCTL_ELEM_WRITE_32,
  			deserialize_from_elem_value_32,
-			ctl_compat_ioctl_elem_write_32,
+			snd_ctl_elem_write,
  			serialize_to_elem_value_32,
-			SNDRV_CTL_IOCTL_ELEM_WRITE,
  		},
  #endif
  #ifdef CONFIG_X86_64
  		{
  			SNDRV_CTL_IOCTL_ELEM_READ_I386,
  			deserialize_from_elem_value_i386,
-			ctl_compat_ioctl_elem_read_32,
+			snd_ctl_elem_read,
  			serialize_to_elem_value_i386,
-			SNDRV_CTL_IOCTL_ELEM_READ,
  		},
  		{
  			SNDRV_CTL_IOCTL_ELEM_WRITE_I386,
  			deserialize_from_elem_value_i386,
-			ctl_compat_ioctl_elem_write_32,
+			snd_ctl_elem_write,
  			serialize_to_elem_value_i386,
-			SNDRV_CTL_IOCTL_ELEM_WRITE,
  		},
  #endif
  	};
+	union {
+		struct snd_ctl_elem_list_32 elem_list_32;
+		struct snd_ctl_elem_info_32 elem_info_32;
+		struct snd_ctl_elem_value_32 elem_value_32;
+		struct snd_ctl_elem_value_i386 elem_value_i386;
+	} data;
+	union {
+		struct snd_ctl_elem_list elem_list;
+		struct snd_ctl_elem_info elem_info;
+		struct snd_ctl_elem_value elem_value;
+	} buf;
  	struct snd_ctl_file *ctl_file;
-	void *buf, *data;
  	unsigned int size;
  	int i;
  	int err;
@@ -571,51 +524,35 @@ static long snd_ctl_ioctl_compat(struct file 
*file, unsigned int cmd,
  		return snd_ctl_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
  	}

-	/* Allocate a buffer to convert layout of structure for native ABI. */
-	buf = kzalloc(_IOC_SIZE(handlers[i].orig_cmd), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
  	/* Allocate an alternative buffer to copy from/to user space. */
  	size = _IOC_SIZE(handlers[i].cmd);
-	data = kzalloc(size, GFP_KERNEL);
-	if (!data) {
-		kfree(buf);
-		return -ENOMEM;
-	}

  	if (handlers[i].cmd & IOC_IN) {
-		if (copy_from_user(data, compat_ptr(arg), size)) {
-			err = -EFAULT;
-			goto end;
-		}
+		if (copy_from_user(&data, compat_ptr(arg), size))
+			return -EFAULT;
  	}

-	err = handlers[i].deserialize(ctl_file, buf, data);
+	err = handlers[i].deserialize(ctl_file, &buf, &data);
  	if (err < 0)
-		goto end;
+		return err;

-	err = handlers[i].func(ctl_file, buf);
+	err = handlers[i].func(ctl_file, &buf);
  	if (err < 0)
-		goto end;
+		return err;

-	err = handlers[i].serialize(ctl_file, data, buf);
+	err = handlers[i].serialize(ctl_file, &data, &buf);
  	if (err >= 0) {
  		if (handlers[i].cmd & IOC_OUT) {
-			if (copy_to_user(compat_ptr(arg), data, size))
+			if (copy_to_user(compat_ptr(arg), &data, size))
  				err = -EFAULT;
  		}
  	}

  	if (err < 0) {
  		if (cmd == SNDRV_CTL_IOCTL_ELEM_ADD_32 ||
-		    cmd == SNDRV_CTL_IOCTL_ELEM_REPLACE_32) {
-			struct snd_ctl_elem_info *info = buf;
-			snd_ctl_remove_user_ctl(ctl_file, &info->id);
-		}
+		    cmd == SNDRV_CTL_IOCTL_ELEM_REPLACE_32)
+			snd_ctl_remove_user_ctl(ctl_file, &buf.elem_info.id);
  	}
-end:
-	kfree(data);
-	kfree(buf);
+
  	return err;
  }
========== 8< ----------


Thanks

Takashi Sakamoto
