From: Ian Campbell <icampbell@arcom.com>
Subject: correcting incorrect ac'97 codec clock
Date: Mon, 21 Feb 2005 14:38:02 +0000
Message-ID: <1108996683.3174.4.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am working on a piece of hardware where the AC'97 codec clock was
erroneously set at 24MHz instead of the correct 24.5764MHz, this causes
the sound to come out slightly wrong, a 1000Hz sine wave is ~977Hz or
so.

We'd prefer to have the kernel correct for this error rather than
expecting every application to do it. Under the OSS driver I used the
patch below (which is against an out of tree PXA2xx OSS driver, but you
get the idea). I have just switched to using the new ALSA driver for the
PXA2xx AC'97 controller which is currently in CVS.

Basically I'm just looking for some advice as to where it would be
cleanest to add the hack, I'm not expecting for it to be a mergeable
hack or anything, unless perhaps there is already some infrastructure
for 'quirks' of this type that I am missing?

I think I can add code to snd_ac97_set_rate() in
sound/pci/ac97/ac97_pcm.c easy enough, but I can't see
snd_ac97_get_rate() or similar anywhere, and I'm a little concerned that
ALSA won't like the fact that the rate reads back differently to what it
thinks it (logically) set. Alternatively I guess I could instead hack
read() and write() in the PXA part of the driver to look for the
registers relating to sample rates and modify them on the fly.

Or are there any other options?

Please cc me, I'm not on ALSA devel.

Cheers,
Ian.

--- 2.6.orig/sound/oss/pxa-ac97.c	2005-01-25 15:56:10.000000000 +0000
+++ 2.6/sound/oss/pxa-ac97.c	2005-01-25 15:56:11.000000000 +0000
@@ -41,6 +41,10 @@
 
 #include "pxa-audio.h"
 
+#ifdef CONFIG_ARCH_VIPER
+#include <asm/arch/viper.h>
+#endif
+
 static struct completion CAR_completion;
 static int waitingForMask;
 static DECLARE_MUTEX(CAR_mutex);
@@ -239,6 +243,38 @@
 	return 0;
 }
 
+static inline unsigned long correct_for_codec_clock(unsigned long rate)
+{
+#ifdef CONFIG_ARCH_VIPER
+	u8 hw = viper_hw_version();
+	if (hw==0) { /* v1i6 or earlier */
+		printk(KERN_INFO "AC'97: requested sample rate %ldHz ", rate);
+		rate = (rate*1024)/1000;
+		printk("programmed rate is %ldHz.\n", rate);
+		if(rate>48000)
+			printk(KERN_ERR "AC'97: corrected sample rate is out of codec range.\n");
+	}
+#endif
+	return rate;
+}
+
+static inline unsigned long correct_for_codec_clock_reverse(unsigned long rate)
+{
+#ifdef CONFIG_ARCH_VIPER
+	u8 hw = viper_hw_version();
+	if (hw==0) { /* v1i6 or earlier */
+		printk(KERN_INFO "AC'97: current sample rate is %ldHz ", rate);
+		rate = (rate*1000)/1024;
+		printk("actual rate is %ldHz.\n", rate);
+	}
+#endif
+	return rate;
+}
+
 static struct file_operations mixer_fops = {
 	ioctl:		mixer_ioctl,
 	llseek:		no_llseek,
@@ -270,6 +306,7 @@
 		ret = get_user(val, (long *) arg);
 		if (ret)
 			return ret;
+		val = correct_for_codec_clock(val);
 		if (file->f_mode & FMODE_READ)
 			codec_adc_rate = ac97_set_adc_rate(&pxa_ac97_codec, val);
 		if (file->f_mode & FMODE_WRITE)
@@ -280,6 +317,7 @@
 			val = codec_adc_rate;
 		if (file->f_mode & FMODE_WRITE)
 			val = codec_dac_rate;
+		val = correct_for_codec_clock_reverse(val);
 		return put_user(val, (long *) arg);
 
 	case SNDCTL_DSP_SETFMT:

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
