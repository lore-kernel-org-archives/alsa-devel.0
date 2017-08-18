From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH] sound: fix some checkpatch errors and warnings.
Date: Fri, 18 Aug 2017 22:20:54 +0800
Message-ID: <1503066054-26512-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C1F73267819
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 16:21:03 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id y129so15296849pgy.3
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 07:21:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

ERROR: trailing whitespace
WARNING: please, no spaces at the start of a line
ERROR: open brace '{' following struct go on the same line
ERROR: do not initialise statics to 0
ERROR: "foo * bar" should be "foo *bar"
ERROR: spaces required around that '='
ERROR: switch and case should be at the same indent
WARNING: Statements should start on a tabstop
WARNING: Block comments use * on subsequent lines

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/last.c       |   2 +-
 sound/sound_core.c | 163 ++++++++++++++++++++++++-----------------------------
 2 files changed, 76 insertions(+), 89 deletions(-)

diff --git a/sound/last.c b/sound/last.c
index 43f2228..a47bbe0 100644
--- a/sound/last.c
+++ b/sound/last.c
@@ -25,7 +25,7 @@
 static int __init alsa_sound_last_init(void)
 {
 	int idx, ok = 0;
-	
+
 	printk(KERN_INFO "ALSA device list:\n");
 	for (idx = 0; idx < SNDRV_CARDS; idx++)
 		if (snd_cards[idx] != NULL) {
diff --git a/sound/sound_core.c b/sound/sound_core.c
index 99b73c6..f99bb7a 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -68,7 +68,7 @@ static void __exit cleanup_soundcore(void)
 #ifdef CONFIG_SOUND_OSS_CORE
 /*
  *	OSS sound core handling. Breaks out sound functions to submodules
- *	
+ *
  *	Author:		Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  *	Fixes:
@@ -80,9 +80,9 @@ static void __exit cleanup_soundcore(void)
  *	2 of the License, or (at your option) any later version.
  *
  *                         --------------------
- * 
+ *
  *	Top level handler for the sound subsystem. Various devices can
- *	plug into this. The fact they don't all go via OSS doesn't mean 
+ *	plug into this. The fact they don't all go via OSS doesn't mean
  *	they don't have to implement the OSS API. There is a lot of logic
  *	to keeping much of the OSS weight out of the code in a compatibility
  *	module, but it's up to the driver to rember to load it...
@@ -111,8 +111,7 @@ static void __exit cleanup_soundcore(void)
 
 #define SOUND_STEP 16
 
-struct sound_unit
-{
+struct sound_unit {
 	int unit_minor;
 	const struct file_operations *unit_fops;
 	struct sound_unit *next;
@@ -151,15 +150,14 @@ struct sound_unit
 #ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
 static int preclaim_oss = 1;
 #else
-static int preclaim_oss = 0;
+static int preclaim_oss;
 #endif
 
 module_param(preclaim_oss, int, 0444);
 
 static int soundcore_open(struct inode *, struct file *);
 
-static const struct file_operations soundcore_fops =
-{
+static const struct file_operations soundcore_fops = {
 	/* We must have an owner or the module locking fails */
 	.owner	= THIS_MODULE,
 	.open	= soundcore_open,
@@ -171,70 +169,68 @@ struct sound_unit
  *	join into it. Called with the lock asserted
  */
 
-static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list, const struct file_operations *fops, int index, int low, int top)
+static int __sound_insert_unit(struct sound_unit *s, struct sound_unit **list,
+			       const struct file_operations *fops, int index,
+			       int low, int top)
 {
-	int n=low;
+	int n = low;
 
 	if (index < 0) {	/* first free */
 
-		while (*list && (*list)->unit_minor<n)
-			list=&((*list)->next);
+		while (*list && (*list)->unit_minor < n)
+			list = &((*list)->next);
 
-		while(n<top)
-		{
+		while (n < top) {
 			/* Found a hole ? */
-			if(*list==NULL || (*list)->unit_minor>n)
+			if (*list == NULL || (*list)->unit_minor > n)
 				break;
-			list=&((*list)->next);
-			n+=SOUND_STEP;
+			list = &((*list)->next);
+			n += SOUND_STEP;
 		}
 
-		if(n>=top)
+		if (n >= top)
 			return -ENOENT;
 	} else {
 		n = low+(index*16);
 		while (*list) {
-			if ((*list)->unit_minor==n)
+			if ((*list)->unit_minor == n)
 				return -EBUSY;
-			if ((*list)->unit_minor>n)
+			if ((*list)->unit_minor > n)
 				break;
-			list=&((*list)->next);
+			list = &((*list)->next);
 		}
-	}	
-		
+	}
+
 	/*
 	 *	Fill it in
 	 */
-	 
-	s->unit_minor=n;
-	s->unit_fops=fops;
-	
+
+	s->unit_minor = n;
+	s->unit_fops = fops;
+
 	/*
 	 *	Link it
 	 */
-	 
-	s->next=*list;
-	*list=s;
-	
-	
+
+	s->next = *list;
+	*list = s;
+
 	return n;
 }
 
 /*
  *	Remove a node from the chain. Called with the lock asserted
  */
- 
+
 static struct sound_unit *__sound_remove_unit(struct sound_unit **list, int unit)
 {
-	while(*list)
-	{
-		struct sound_unit *p=*list;
-		if(p->unit_minor==unit)
-		{
-			*list=p->next;
+	while (*list) {
+		struct sound_unit *p = *list;
+		if (p->unit_minor == unit) {
+			*list = p->next;
 			return p;
 		}
-		list=&(p->next);
+		list = &(p->next);
 	}
 	printk(KERN_ERR "Sound device %d went missing!\n", unit);
 	return NULL;
@@ -251,7 +247,9 @@ static struct sound_unit *__sound_remove_unit(struct sound_unit **list, int unit
  *	list. Acquires locks as needed
  */
 
-static int sound_insert_unit(struct sound_unit **list, const struct file_operations *fops, int index, int low, int top, const char *name, umode_t mode, struct device *dev)
+static int sound_insert_unit(struct sound_unit **list, const struct file_operations *fops,
+			     int index, int low, int top, const char *name,
+			     umode_t mode, struct device *dev)
 {
 	struct sound_unit *s = kmalloc(sizeof(*s), GFP_KERNEL);
 	int r;
@@ -263,7 +261,7 @@ static int sound_insert_unit(struct sound_unit **list, const struct file_operati
 retry:
 	r = __sound_insert_unit(s, list, fops, index, low, top);
 	spin_unlock(&sound_loader_lock);
-	
+
 	if (r < 0)
 		goto fail;
 	else if (r < SOUND_STEP)
@@ -305,7 +303,7 @@ static int sound_insert_unit(struct sound_unit **list, const struct file_operati
  *	completed the removal before their file operations become
  *	invalid.
  */
- 	
+
 static void sound_remove_unit(struct sound_unit **list, int unit)
 {
 	struct sound_unit *p;
@@ -357,7 +355,7 @@ static void sound_remove_unit(struct sound_unit **list, int unit)
  *	Return: The allocated number is returned on success. On failure,
  *	a negative error code is returned.
  */
- 
+
 int register_sound_special_device(const struct file_operations *fops, int unit,
 				  struct device *dev)
 {
@@ -367,69 +365,67 @@ int register_sound_special_device(const struct file_operations *fops, int unit,
 	char _name[16];
 
 	switch (chain) {
-	    case 0:
+	case 0:
 		name = "mixer";
 		break;
-	    case 1:
+	case 1:
 		name = "sequencer";
 		if (unit >= SOUND_STEP)
 			goto __unknown;
 		max_unit = unit + 1;
 		break;
-	    case 2:
+	case 2:
 		name = "midi";
 		break;
-	    case 3:
+	case 3:
 		name = "dsp";
 		break;
-	    case 4:
+	case 4:
 		name = "audio";
 		break;
-	    case 5:
+	case 5:
 		name = "dspW";
 		break;
-	    case 8:
+	case 8:
 		name = "sequencer2";
 		if (unit >= SOUND_STEP)
 			goto __unknown;
 		max_unit = unit + 1;
 		break;
-	    case 9:
+	case 9:
 		name = "dmmidi";
 		break;
-	    case 10:
+	case 10:
 		name = "dmfm";
 		break;
-	    case 12:
+	case 12:
 		name = "adsp";
 		break;
-	    case 13:
+	case 13:
 		name = "amidi";
 		break;
-	    case 14:
+	case 14:
 		name = "admmidi";
 		break;
-	    default:
-	    	{
-		    __unknown:
+	default:
+		{
+		__unknown:
 			sprintf(_name, "unknown%d", chain);
-		    	if (unit >= SOUND_STEP)
-		    		strcat(_name, "-");
-		    	name = _name;
+			if (unit >= SOUND_STEP)
+				strcat(_name, "-");
+			name = _name;
 		}
 		break;
 	}
 	return sound_insert_unit(&chains[chain], fops, -1, unit, max_unit,
 				 name, S_IRUSR | S_IWUSR, dev);
 }
- 
 EXPORT_SYMBOL(register_sound_special_device);
 
 int register_sound_special(const struct file_operations *fops, int unit)
 {
 	return register_sound_special_device(fops, unit, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_special);
 
 /**
@@ -449,7 +445,6 @@ int register_sound_mixer(const struct file_operations *fops, int dev)
 	return sound_insert_unit(&chains[0], fops, dev, 0, 128,
 				 "mixer", S_IRUSR | S_IWUSR, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_mixer);
 
 /**
@@ -469,14 +464,13 @@ int register_sound_midi(const struct file_operations *fops, int dev)
 	return sound_insert_unit(&chains[2], fops, dev, 2, 130,
 				 "midi", S_IRUSR | S_IWUSR, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_midi);
 
 /*
  *	DSP's are registered as a triple. Register only one and cheat
  *	in open - see below.
  */
- 
+
 /**
  *	register_sound_dsp - register a DSP device
  *	@fops: File operations for the driver
@@ -497,7 +491,6 @@ int register_sound_dsp(const struct file_operations *fops, int dev)
 	return sound_insert_unit(&chains[3], fops, dev, 3, 131,
 				 "dsp", S_IWUSR | S_IRUSR, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_dsp);
 
 /**
@@ -514,7 +507,6 @@ void unregister_sound_special(int unit)
 {
 	sound_remove_unit(&chains[unit % SOUND_STEP], unit);
 }
- 
 EXPORT_SYMBOL(unregister_sound_special);
 
 /**
@@ -529,7 +521,6 @@ void unregister_sound_mixer(int unit)
 {
 	sound_remove_unit(&chains[0], unit);
 }
-
 EXPORT_SYMBOL(unregister_sound_mixer);
 
 /**
@@ -544,7 +535,6 @@ void unregister_sound_midi(int unit)
 {
 	sound_remove_unit(&chains[2], unit);
 }
-
 EXPORT_SYMBOL(unregister_sound_midi);
 
 /**
@@ -561,20 +551,17 @@ void unregister_sound_dsp(int unit)
 {
 	sound_remove_unit(&chains[3], unit);
 }
-
-
 EXPORT_SYMBOL(unregister_sound_dsp);
 
 static struct sound_unit *__look_for_unit(int chain, int unit)
 {
 	struct sound_unit *s;
-	
-	s=chains[chain];
-	while(s && s->unit_minor <= unit)
-	{
-		if(s->unit_minor==unit)
+
+	s = chains[chain];
+	while (s && s->unit_minor <= unit) {
+		if (s->unit_minor == unit)
 			return s;
-		s=s->next;
+		s = s->next;
 	}
 	return NULL;
 }
@@ -586,14 +573,13 @@ static int soundcore_open(struct inode *inode, struct file *file)
 	struct sound_unit *s;
 	const struct file_operations *new_fops = NULL;
 
-	chain=unit&0x0F;
-	if(chain==4 || chain==5)	/* dsp/audio/dsp16 */
-	{
-		unit&=0xF0;
-		unit|=3;
-		chain=3;
+	chain = unit&0x0F;
+	if (chain == 4 || chain == 5) { /* dsp/audio/dsp16 */
+		unit &= 0xF0;
+		unit |= 3;
+		chain = 3;
 	}
-	
+
 	spin_lock(&sound_loader_lock);
 	s = __look_for_unit(chain, unit);
 	if (s)
@@ -636,7 +622,7 @@ static int soundcore_open(struct inode *inode, struct file *file)
 		replace_fops(file, new_fops);
 
 		if (file->f_op->open)
-			err = file->f_op->open(inode,file);
+			err = file->f_op->open(inode, file);
 
 		return err;
 	}
@@ -648,7 +634,8 @@ static int soundcore_open(struct inode *inode, struct file *file)
 static void cleanup_oss_soundcore(void)
 {
 	/* We have nothing to really do here - we know the lists must be
-	   empty */
+	 * empty
+	 */
 	unregister_chrdev(SOUND_MAJOR, "sound");
 }
 
-- 
1.9.1
