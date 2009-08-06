From: John Bonesio <bones@secretlab.ca>
Subject: Re: MPC5200/WM9712 mute problem
Date: Thu, 06 Aug 2009 10:28:41 -0700
Message-ID: <1249579721.5844.88.camel@riker>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker> <20090802114950.GA1778@sirena.org.uk>
	<1249489853.4582.58.camel@riker> <20090805170305.GC16844@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-x3raHgVf5+WiubkAQDMn"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175])
	by alsa0.perex.cz (Postfix) with ESMTP id ED99B10380A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 19:28:48 +0200 (CEST)
Received: by pzk5 with SMTP id 5so1028408pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 06 Aug 2009 10:28:47 -0700 (PDT)
In-Reply-To: <20090805170305.GC16844@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org


--=-x3raHgVf5+WiubkAQDMn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2009-08-05 at 18:03 +0100, Mark Brown wrote:
> On Wed, Aug 05, 2009 at 09:30:53AM -0700, John Bonesio wrote:
> 
> > I've retitled the email to better reflect the real patch. I believe
> > there has been some general confusion because I originally sent the
> > wrong patch.
> 
> Retitling again; I don't think we've diagnosed what is causing issues
> here.  Doing a quick test here I wasn't able to reproduce this behaviour
> so I suspect either the AC97 controller by itself or some interaction
> between it and the WM9712.  Like I say, the WM9712 is not a new part and
> the drivers aren't new either so it'd be surprising to find an issue
> like this now.

Ok. At this point I'm not trying to get the patch approved so much as
I'd like to see if we can get to the root cause of the problem.

> 
> > > Like I said before, exactly which control are you adjusting here?
> 
> > My description of this got lost in all the confusion. Let me try again.
> > We are adjusting the mixer bits for mute/unmute on two of the mixer
> > settings. The first one is general headphone mute setting on register
> > 0x4 (bit 15). The second one is the PCM mute setting on register 0x18
> > (bit 15).
> 
> Hrm, so the same bit in both registers.  Suspicious...
> 
> > What we are seeing is that if we first unmute the general headphone (reg
> > 0x4 bit15), then unmute the PCM (reg 0x18 bit 15) [HPL PCM in the
> > alsamixer application], the general headphone gets muted again, even
> > though software didn't write to that register.
> 
> Are any other bits in register 4 affected or is it only bit 15?

So far, I've only seen this one bit affected. There are lots of
combinations that could be tested, and I've not done comprehensive test
of every bit. It's possible that other bits are affected in ways that
don't show up in my testing.

Below I describe in more detail how I've tested.

> 
> > > My money would be on the AC97 controller having problems; the quality of
> > > SoC AC97 controllers is variable.  It certainly doesn't sound like a
> > > WM9712 issue; as I say I'd be very surprised if such an issue hadn't
> > > come up before given how widely deployed the part is.
> 
> > We don't have access to an AC97 analyzer. Do you have any suggestions on
> > other ways we can pinpoint the error?
> 
> Any scope that can capture would be useful to see what's going on;
> obviously decode would have to be by hand.  Coding out the register
> cache may also be useful - it'd allow you to see the current hardware
> register values.

In case anyone else sees this problem, and would like to jump in, here
is what I've done to investigate this problem.

First I added a debugfs file that displays nearly all of the mixer
registers and decodes their bits for convenience. I've attached a patch
for this change. I believe this patch is just for debugging. I don't
expect that this patch needs to go into the main source.

The debugfs file bypasses the register cache in the codec. It also reads
the value in the cache and compares them. If the register value is
different than that of the cache, text is added to the debugfs file to
alert the viewer of this.

When the error occurs, the cache no longer reflects the value of the
hardware register.

As mentioned before, I've also hooked the out_be32() routine, and had it
print a message whenever register 0x4 of the codec (The headphone mixer
register) is modified by software.

The register is written indirectly, so to be clear, the hook in
out_be32() checked for writes to the ac97_cmd register and the register
number field of the value written had 0x4 in it. (e.g. (value >> 24) &
0x7f) == 0x4)

The hook didn't check for the "write" bit so it also ended up displaying
a message whenever register 0x4 was read as well as written.

In my tests register 0x4 is being modified outside the software path
that would deliberately modify this register using out_be32().

I didn't include a patch for this hook, as it was very hacky, and I
wasn't so sure about its usefulness.

This issue has been seen on MPC5200 based boards.

I've chatted with Grant a bit. We'll see what we can scrounge up to hook
up some test equipment. I'm not sure when we'll get to this.

I'm open to more suggestions or thoughts on the approach I've taken so
far.

- John

--=-x3raHgVf5+WiubkAQDMn
Content-Disposition: attachment; filename="asoc-wm9712-debugfs-for-mixer--0.patch"
Content-Type: text/x-patch; name="asoc-wm9712-debugfs-for-mixer--0.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

ASoC: WM9712: debugfs for mixer registers

From: John Bonesio <bones@secretlab.ca>

debugfs file added to display mixer registers.
---

 sound/soc/codecs/wm9712.c |  309 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 309 insertions(+), 0 deletions(-)


diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index b57c817..8d13ece 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -154,6 +155,50 @@ SOC_SINGLE("Mic 2 Volume", AC97_MIC, 0, 31, 1),
 SOC_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 7, 1, 0),
 };
 
+typedef struct reg_map_type {
+	unsigned int reg;
+	char *name;
+} reg_map_type;
+
+reg_map_type reg_map[] = {
+	{ 0x02, "spkr out (1/2)" },
+	{ 0x04, "hp out (l/r)" },
+	{ 0x06, "phone out (mono)" },
+	{ 0x0a, "pcbeep" },
+	{ 0x0c, "phone" },
+	{ 0x0e, "mic to phone" },
+	{ 0x10, "linein" },
+	{ 0x12, "AUXDAC" },
+	{ 0x14, "mic to hp (sidetone)" },
+	{ 0x16, "OUT3" },
+	{ 0x18, "DAC" },
+	{ 0x20, "ADC" },
+	{ 0x24, "PowMgmnt #1" },
+	{ 0x26, "PowMgmnt #2" },
+	{ HPL_MIXER, "HPL_MIXER" },
+	{ HPR_MIXER, "HPR_MIXER" },
+	{ 0x00, NULL }
+};
+
+char *reg_name(unsigned int reg) {
+	unsigned int idx;
+
+	for (idx=0; reg_map[idx].name != NULL; idx++) {
+		if (reg_map[idx].reg == reg)
+			break;
+	}
+
+	if (reg_map[idx].name == NULL) {
+		return "(unknown register)";
+	}
+	return reg_map[idx].name;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *debugfs_root;
+#endif
+
+
 /* We have to create a fake left and right HP mixers because
  * the codec only has a single control that is shared by both channels.
  * This makes it impossible to determine the audio path.
@@ -429,6 +474,254 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"ROUT2", NULL, "Speaker PGA"},
 };
 
+#ifdef CONFIG_DEBUG_FS
+static int wm9712_reg_open_file(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static char tmp_str[120];
+static char *decode_bits(unsigned int reg, unsigned int value) {
+	switch (reg) {
+		case 0x2:
+			/* lout2/rout2 */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"%smute; lout2 vol: %d; zc: %s inv: %s; rout2 vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value >> 8) & 0x3F,
+				(value & 0x80) ? "on" : "off", 
+				(value & 0x40) ? "on" : "off", 
+				value & 0x3F);
+			break;
+		case 0x4:
+			/* hpout l/r */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"%smute; hpout2 vol: %d; zc: %s hpout2 vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value >> 8) & 0x3F,
+				(value & 0x80) ? "on" : "off", 
+				value & 0x3F);
+			break;
+		case 0x6:
+			/* monoout */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"%smute; zc: %s monoout vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value & 0x80) ? "on" : "off", 
+				value & 0x3F);
+			break;
+		case 0xa:
+			/* pcbeep */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"b-hph %smute; b-hph vol: %d; b-spk %smute; b-spk vol: %d; b-ph %smute; b-ph vol: %d;",
+				(value & 0x8000) ? "" : "un",
+				(value >> 12) & 0x7,
+				(value & 0x800) ? "" : "un", 
+				(value >> 8) & 0x7,
+				(value & 0x80) ? "" : "un", 
+				(value >> 4) & 0x7);
+			break;
+		case 0xc:
+			/* phone */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"p-hph %smute; p-spk %smute; phone vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value & 0x4000) ? "" : "un", 
+				value & 0x1F);
+			break;
+		case 0xe:
+			/* mic1/mic2 */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"m1 %smute; m2 %smute; lmic(1) vol: %d; 20db: %s; ms: %x; mic(2) vol: %d",
+				(value & 0x4000) ? "" : "un", 
+				(value & 0x2000) ? "" : "un",
+				(value >> 8) & 0x1f,
+				(value & 0x80) ? "on" : "off",
+				((value >> 5) & 0x3),
+				value & 0x1F);
+			break;
+		case 0x10:
+			/* linein */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"l-hph %smute; l-spk %smute; l-ph %smute; lineinl vol: %d; linein2 vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value & 0x4000) ? "" : "un", 
+				(value & 0x2000) ? "" : "un", 
+				(value >> 8) & 0x1f,
+				value & 0x1F);
+			break;
+		case 0x12:
+			/* auxadc */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"a-hph %smute; a-hph vol: %d; a-spk %smute; a-spk vol: %d; a-ph %smute; a-ph vol: %d; axe: %s",
+				(value & 0x8000) ? "" : "un",
+				(value >> 12) & 0x7,
+				(value & 0x800) ? "" : "un", 
+				(value >> 8) & 0x7,
+				(value & 0x80) ? "" : "un", 
+				(value >> 4) & 0x7,
+				(value & 0x1) ? "on" : "off");
+			break;
+		case 0x14:
+			/* side tone */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"st %smute; st vol: %d; alc-hph mute: %d; alc vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value >> 12) & 0x7,
+				(value >> 10) & 0x3,
+				(value >> 7) & 0x7);
+			break;
+		case 0x16:
+			/* out3 */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"%smute; out3 src: %d; lout2/rout2 src: %s; zc: %s; alc vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value >> 9) & 0x3,
+				(value & 0x100) ? "spk" : "hph",
+				(value & 0x80) ? "on" : "off",
+				value & 0x3f);
+			break;
+		case 0x18:
+			/* dac */
+			snprintf(tmp_str, sizeof(tmp_str),
+				"d-hph %smute; d-spk %smute; d-ph %smute; ldac vol: %d; rdac vol: %d",
+				(value & 0x8000) ? "" : "un",
+				(value & 0x4000) ? "" : "un", 
+				(value & 0x2000) ? "" : "un", 
+				(value >> 8) & 0x1f,
+				value & 0x1F);
+			break;
+		default:
+			snprintf(tmp_str, sizeof(tmp_str), "(not decoded)");
+	};
+	return tmp_str;
+}
+
+extern unsigned *mixer_addr;
+static ssize_t wm9712_mixer_reg_show(struct snd_soc_codec *codec, char *buf)
+{
+	int idx, count = 0;
+	unsigned int value, cached_value;
+
+	if (!codec->reg_cache_size)
+		return 0;
+
+	count += sprintf(buf, "%s Mixer registers:\n", codec->name);
+	for (idx = 0; reg_map[idx].name != NULL; idx++) {
+		cached_value = ac97_read(codec, reg_map[idx].reg);
+		if ((reg_map[idx].reg != HPL_MIXER) && (reg_map[idx].reg != HPR_MIXER)) {
+			value = soc_ac97_ops.read(codec->ac97, reg_map[idx].reg);
+		} else {
+			value = cached_value;
+		}
+
+		count += snprintf(buf + count, PAGE_SIZE - count,
+			"%12s: 0x%0x: %s", reg_map[idx].name,
+			value, decode_bits(reg_map[idx].reg, value));
+		if (cached_value != value) {
+			count += snprintf(buf + count, PAGE_SIZE - count,
+				"(cached WRONG!!: 0x%0x)\n", cached_value);
+		} else {
+			count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+		}
+
+		if (count >= PAGE_SIZE - 1)
+			break;
+	}
+	count += snprintf(buf + count, PAGE_SIZE - count,
+		"global mixer_addr: %p\n", mixer_addr);
+
+	/* Truncate count; min() would cause a warning */
+	if (count >= PAGE_SIZE)
+		count = PAGE_SIZE - 1;
+
+	return count;
+}
+
+
+static ssize_t wm9712_reg_read_file(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+	struct snd_soc_codec *codec = file->private_data;
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = wm9712_mixer_reg_show(codec, buf);
+	if (ret >= 0)
+		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t wm9712_reg_write_file(struct file *file,
+		const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	char buf[32];
+	int buf_size;
+	char *start = buf;
+	unsigned long reg, value;
+	int step = 1;
+	struct snd_soc_codec *codec = file->private_data;
+
+return -EINVAL;
+
+	buf_size = min(count, (sizeof(buf)-1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = 0;
+
+	if (codec->reg_cache_step)
+		step = codec->reg_cache_step;
+
+	while (*start == ' ')
+		start++;
+	reg = simple_strtoul(start, &start, 16);
+	if ((reg >= codec->reg_cache_size) || (reg % step))
+		return -EINVAL;
+	while (*start == ' ')
+		start++;
+	if (strict_strtoul(start, 16, &value))
+		return -EINVAL;
+	codec->write(codec, reg, value);
+	return buf_size;
+}
+
+static const struct file_operations codec_reg_fops = {
+	.open = wm9712_reg_open_file,
+	.read = wm9712_reg_read_file,
+	.write = wm9712_reg_write_file,
+};
+
+static void wm9712_init_debugfs(struct snd_soc_codec *codec)
+{
+	codec->debugfs_reg = debugfs_create_file("mixer_reg", 0644,
+						 debugfs_root, codec,
+						 &codec_reg_fops);
+	if (!codec->debugfs_reg)
+		printk(KERN_WARNING
+		       "ASoC: Failed to create codec register debugfs file\n");
+}
+
+static void wm9712_cleanup_debugfs(struct snd_soc_codec *codec)
+{
+	debugfs_remove(codec->debugfs_pop_time);
+	debugfs_remove(codec->debugfs_reg);
+}
+
+#else
+
+static inline void wm9712_init_debugfs(struct snd_soc_codec *codec)
+{
+}
+
+static inline void wm9712_cleanup_debugfs(struct snd_soc_codec *codec)
+{
+}
+#endif
+
 static int wm9712_add_widgets(struct snd_soc_codec *codec)
 {
 	snd_soc_dapm_new_controls(codec, wm9712_dapm_widgets,
@@ -699,6 +992,8 @@ static int wm9712_soc_probe(struct platform_device *pdev)
 		goto reset_err;
 	}
 
+	wm9712_init_debugfs(codec);
+
 	return 0;
 
 reset_err:
@@ -724,6 +1019,8 @@ static int wm9712_soc_remove(struct platform_device *pdev)
 	if (codec == NULL)
 		return 0;
 
+	wm9712_cleanup_debugfs(codec);
+
 	snd_soc_dapm_free(socdev);
 	snd_soc_free_pcms(socdev);
 	snd_soc_free_ac97_codec(codec);
@@ -742,12 +1039,24 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
 
 static int __init wm9712_modinit(void)
 {
+#ifdef CONFIG_DEBUG_FS
+        debugfs_root = debugfs_create_dir("wm9712", NULL);
+        if (IS_ERR(debugfs_root) || !debugfs_root) {
+                printk(KERN_WARNING
+                       "WM9712: Failed to create debugfs directory\n");
+                debugfs_root = NULL;
+        }
+#endif
 	return snd_soc_register_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
 }
 module_init(wm9712_modinit);
 
 static void __exit wm9712_exit(void)
 {
+#ifdef CONFIG_DEBUG_FS
+        debugfs_remove_recursive(debugfs_root);
+#endif
+
 	snd_soc_unregister_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
 }
 module_exit(wm9712_exit);

--=-x3raHgVf5+WiubkAQDMn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-x3raHgVf5+WiubkAQDMn--
