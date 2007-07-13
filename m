From: stan <stanl@cox.net>
Subject: Re: Some functionality of ice1724 broken between
 1.0.14.RC1 and 1.0.14.RC3
Date: Fri, 13 Jul 2007 08:07:50 -0700
Message-ID: <20070713080750.5ae2d2cb@localhost.localdomain>
References: <20070713062326.22e05830@localhost.localdomain>
	<s5hejjczavr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_s3z0fG0Ff69xZSKwX7VZx9M
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id E5B6C103828
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 17:07:52 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao102.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070713150752.KHAP1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2007 11:07:52 -0400
In-Reply-To: <s5hejjczavr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_s3z0fG0Ff69xZSKwX7VZx9M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 13 Jul 2007 15:33:28 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 13 Jul 2007 06:23:26 -0700,
> stan wrote:
> > 
[snip]
> 
> Could you check whether the same problem still exists on 1.0.14 final?
> There are tons of changes since rc3, so debugging rc3 is just a waste
> of time.

Darn!  I was hoping you would just look at it and know the problem. :-)

How would I go about that?  Is there a document somewhere that
describes the process?  I've downloaded the lib, drivers, utils, and
tools for 1.0.14.final.  I'll compile all of them.
If I install to /usr/local/, will it work?  I'm concerned about
breaking the packaging system / the system.
Do I modprobe the new kernel module from my own
build? It's been a while since I messed with such things.  I usually 
install applications outside the package management system, not base 
components like alsa.  Hand holding would be nice but if you just point
me towards some documentation that would be enough, or even describe
the outline of the process and I can use search to find documentation.

[snip]
>  
> No, consts shouldn't matter.  (BTW, please use diff -up option at the
> next time.  That'll make it way easier to read a patch.)

Done and attached below.

I am working on the rest of your requests and will send it along
later.
> 
> > 2.
> > 
> > I ran a frequency loudness test that is part of the app.  It drops
> > the frequency at 5 seconds intervals from 20 KHz to 5 Hz
> > alternating.  On Fedora 6 with 1.0.14.RC1 it works as expected.
> > When above my hearing range I hear silence.  When it gets to
> > frequencies I can hear the sound is pure.  On Fedora 7, this same
> > app produces noise at frequencies I can't hear.  This behavior is
> > the same as the behavior I noticed with my emu10k1, ca0106 and CK8S
> > sound cards on 1.0.14.RC1 as well as 1.0.14.RC3.  I previously had
> > ascribed this to bad/low quality sound chips; now I'm not so sure.
> > In terms of sound quality the Rev 5.1 ranks well.  See the link
> > 
> > http://compreviews.about.com/od/multimedia/tp/SoundCards.htm
> > 
> > Exact same hardware produces different sound.  Can't explain it.
> > Can you?  Can you fix it?
> 
> Might be alsa-lib dmix issue now used as default PCM?  Which PCM
> configuration are you using?  Does the problem exist even if you use
> "hw" (or "plughw") PCM explicitly?

I am using default, if I understand what you are asking.  I will set it
to use plughw:0,0 and try.
> 
> 
> > 3.
> > 
> > While looking at the ice1724.c code I noticed that the maximum
> > buffer size is 2**18.  This seems small for an application today.
> > I'm producing sound at 192000 frames per second (admittedly overkill
> > though I like very smooth sound) using stereo doubles (16 bytes per
> > frame). The maximum buffer size is only a fraction of my per second
> > byte rate.
> > 
> > Could you increase this?
> 
> Ditto.
> 
That seems to have done the trick for both issues.  You did answer it
off the top of your head.  :-)

Minimum channels (1)
Maximum channels (10000)
Minimum rate (4000)  Direction = 0
Maximum rate (4294967295)  Direction = -1
Rate (48000)  Direction = -1 Result = 0
Rate (96000)  Direction = -1 Result = 0
Rate (192000)  Direction = -1 Result = 0
Rate (384000)  Direction = -1 Result = 0
Minimum period_time (10)  Direction = 1
Maximum period_time (2048000)  Direction = 0
Minimum period_size (0)  Direction = 1
Maximum period_size (4294967295)  Direction = -1
Minimum periods (0)  Direction = 1
Maximum periods (4294967295)  Direction = 0
Minimum buffer_time (1)  Direction = 0
Maximum buffer_time (4294967295)  Direction = 0
Minimum buffer_size (1)
Maximum buffer_size (4294967294)
Minimum tick_time (1000)  Direction = 0
Maximum tick_time (1000)  Direction = 0
Actual rate (192000)  Direction = 0
Actual channels (2)
Actual buffer_time (170666)  Direction = 1
Actual buffer_size (32768)
Actual buffer_size (32768)
Actual period_time (85333)  Direction = 1
Actual period_size (16384)  Direction = 0
Actual periods (2)  Direction = 0
Actual rate (192000)  Direction = 0
Actual channels (2)
Actual periods (2)  Direction = 0
Actual period_size (16384)  Direction = 0
Actual buffer_size (32768)

What would be the effect of using plughw:0,0 instead of default on an
average system?  Would a user have any control over which sound card
plays the sound?  Or, to rephrase, with default if a user changes the
default then the sound card playing changes, with plughw:0,0 the user
is locked into the first card, true?

Let me know if you still want me to test 14 final, though it seems
redundant now.

 Thanks for your help.
--MP_s3z0fG0Ff69xZSKwX7VZx9M
Content-Type: text/x-patch; name=ice1724_rc1_to_rc3.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ice1724_rc1_to_rc3.diff

--- ice1724.rc1.c	2006-12-07 07:07:31.000000000 -0700
+++ ice1724.rc3.c	2007-03-06 05:26:32.000000000 -0700
@@ -50,7 +50,7 @@
 #include "prodigy192.h"
 #include "juli.h"
 #include "phase.h"
-
+#include "wtm.h"
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("VIA ICEnsemble ICE1724/1720 (Envy24HT/PT)");
@@ -64,6 +64,7 @@ MODULE_SUPPORTED_DEVICE("{"
 	       PRODIGY192_DEVICE_DESC
 	       JULI_DEVICE_DESC
 	       PHASE_DEVICE_DESC
+	       WTM_DEVICE_DESC
 		"{VIA,VT1720},"
 		"{VIA,VT1724},"
 		"{ICEnsemble,Generic ICE1724},"
@@ -86,7 +87,7 @@ MODULE_PARM_DESC(model, "Use the given b
 
 
 /* Both VT1720 and VT1724 have the same PCI IDs */
-static struct pci_device_id snd_vt1724_ids[] = {
+static const struct pci_device_id snd_vt1724_ids[] = {
 	{ PCI_VENDOR_ID_ICE, PCI_DEVICE_ID_VT1724, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
@@ -336,13 +337,11 @@ static int snd_vt1724_pcm_trigger(struct
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	unsigned char what;
 	unsigned char old;
-	struct list_head *pos;
 	struct snd_pcm_substream *s;
 
 	what = 0;
-	snd_pcm_group_for_each(pos, substream) {
-		struct vt1724_pcm_reg *reg;
-		s = snd_pcm_group_substream_entry(pos);
+	snd_pcm_group_for_each_entry(s, substream) {
+		const struct vt1724_pcm_reg *reg;
 		reg = s->runtime->private_data;
 		what |= reg->start;
 		snd_pcm_trigger_done(s, substream);
@@ -605,7 +604,7 @@ static snd_pcm_uframes_t snd_vt1724_play
 static int snd_vt1724_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
-	struct vt1724_pcm_reg *reg = substream->runtime->private_data;
+	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
 
 	spin_lock_irq(&ice->reg_lock);
 	outl(substream->runtime->dma_addr, ice->profi_port + reg->addr);
@@ -620,7 +619,7 @@ static int snd_vt1724_pcm_prepare(struct
 static snd_pcm_uframes_t snd_vt1724_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
-	struct vt1724_pcm_reg *reg = substream->runtime->private_data;
+	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
 	size_t ptr;
 
 	if (!(inl(ICEMT1724(ice, DMA_CONTROL)) & reg->start))
@@ -646,21 +645,21 @@ static snd_pcm_uframes_t snd_vt1724_pcm_
 #endif
 }
 
-static struct vt1724_pcm_reg vt1724_playback_pro_reg = {
+static const struct vt1724_pcm_reg vt1724_playback_pro_reg = {
 	.addr = VT1724_MT_PLAYBACK_ADDR,
 	.size = VT1724_MT_PLAYBACK_SIZE,
 	.count = VT1724_MT_PLAYBACK_COUNT,
 	.start = VT1724_PDMA0_START,
 };
 
-static struct vt1724_pcm_reg vt1724_capture_pro_reg = {
+static const struct vt1724_pcm_reg vt1724_capture_pro_reg = {
 	.addr = VT1724_MT_CAPTURE_ADDR,
 	.size = VT1724_MT_CAPTURE_SIZE,
 	.count = VT1724_MT_CAPTURE_COUNT,
 	.start = VT1724_RDMA0_START,
 };
 
-static struct snd_pcm_hardware snd_vt1724_playback_pro =
+static const struct snd_pcm_hardware snd_vt1724_playback_pro =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -679,7 +678,7 @@ static struct snd_pcm_hardware snd_vt172
 	.periods_max =		1024,
 };
 
-static struct snd_pcm_hardware snd_vt1724_spdif =
+static const struct snd_pcm_hardware snd_vt1724_spdif =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -701,7 +700,7 @@ static struct snd_pcm_hardware snd_vt172
 	.periods_max =		1024,
 };
 
-static struct snd_pcm_hardware snd_vt1724_2ch_stereo =
+static const struct snd_pcm_hardware snd_vt1724_2ch_stereo =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -773,7 +772,7 @@ static int snd_vt1724_playback_pro_open(
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	int chs;
 
-	runtime->private_data = &vt1724_playback_pro_reg;
+	runtime->private_data = (void *)&vt1724_playback_pro_reg;
 	ice->playback_pro_substream = substream;
 	runtime->hw = snd_vt1724_playback_pro;
 	snd_pcm_set_sync(substream);
@@ -802,7 +801,7 @@ static int snd_vt1724_capture_pro_open(s
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->private_data = &vt1724_capture_pro_reg;
+	runtime->private_data = (void *)&vt1724_capture_pro_reg;
 	ice->capture_pro_substream = substream;
 	runtime->hw = snd_vt1724_2ch_stereo;
 	snd_pcm_set_sync(substream);
@@ -888,14 +887,14 @@ static int __devinit snd_vt1724_pcm_prof
  * SPDIF PCM
  */
 
-static struct vt1724_pcm_reg vt1724_playback_spdif_reg = {
+static const struct vt1724_pcm_reg vt1724_playback_spdif_reg = {
 	.addr = VT1724_MT_PDMA4_ADDR,
 	.size = VT1724_MT_PDMA4_SIZE,
 	.count = VT1724_MT_PDMA4_COUNT,
 	.start = VT1724_PDMA4_START,
 };
 
-static struct vt1724_pcm_reg vt1724_capture_spdif_reg = {
+static const struct vt1724_pcm_reg vt1724_capture_spdif_reg = {
 	.addr = VT1724_MT_RDMA1_ADDR,
 	.size = VT1724_MT_RDMA1_SIZE,
 	.count = VT1724_MT_RDMA1_COUNT,
@@ -953,7 +952,7 @@ static int snd_vt1724_playback_spdif_ope
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->private_data = &vt1724_playback_spdif_reg;
+	runtime->private_data = (void *)&vt1724_playback_spdif_reg;
 	ice->playback_con_substream = substream;
 	if (ice->force_pdma4) {
 		runtime->hw = snd_vt1724_2ch_stereo;
@@ -985,7 +984,7 @@ static int snd_vt1724_capture_spdif_open
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->private_data = &vt1724_capture_spdif_reg;
+	runtime->private_data = (void *)&vt1724_capture_spdif_reg;
 	ice->capture_con_substream = substream;
 	if (ice->force_rdma1) {
 		runtime->hw = snd_vt1724_2ch_stereo;
@@ -1090,7 +1089,7 @@ static int __devinit snd_vt1724_pcm_spdi
  * independent surround PCMs
  */
 
-static struct vt1724_pcm_reg vt1724_playback_dma_regs[3] = {
+static const struct vt1724_pcm_reg vt1724_playback_dma_regs[3] = {
 	{
 		.addr = VT1724_MT_PDMA1_ADDR,
 		.size = VT1724_MT_PDMA1_SIZE,
@@ -1136,7 +1135,7 @@ static int snd_vt1724_playback_indep_ope
 		return -EBUSY; /* FIXME: should handle blocking mode properly */
 	}
 	mutex_unlock(&ice->open_mutex);
-	runtime->private_data = &vt1724_playback_dma_regs[substream->number];
+	runtime->private_data = (void *)&vt1724_playback_dma_regs[substream->number];
 	ice->playback_con_substream_ds[substream->number] = substream;
 	runtime->hw = snd_vt1724_2ch_stereo;
 	snd_pcm_set_sync(substream);
@@ -1317,7 +1316,7 @@ static int snd_vt1724_eeprom_get(struct 
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_eeprom __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_eeprom __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "ICE1724 EEPROM",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1430,7 +1429,7 @@ static int snd_vt1724_spdif_default_put(
 	return (val != old);
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_default __devinitdata =
+static const struct snd_kcontrol_new snd_vt1724_spdif_default __devinitdata =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -1462,7 +1461,7 @@ static int snd_vt1724_spdif_maskp_get(st
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
+static const struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1471,7 +1470,7 @@ static struct snd_kcontrol_new snd_vt172
 	.get =		snd_vt1724_spdif_maskc_get,
 };
 
-static struct snd_kcontrol_new snd_vt1724_spdif_maskp __devinitdata =
+static const struct snd_kcontrol_new snd_vt1724_spdif_maskp __devinitdata =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1516,7 +1515,7 @@ static int snd_vt1724_spdif_sw_put(struc
 	return old != val;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_switch __devinitdata =
+static const struct snd_kcontrol_new snd_vt1724_spdif_switch __devinitdata =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	/* FIXME: the following conflict with IEC958 Playback Route */
@@ -1584,7 +1583,7 @@ int snd_ice1712_gpio_put(struct snd_kcon
 static int snd_vt1724_pro_internal_clock_info(struct snd_kcontrol *kcontrol,
 					      struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts_1724[] = {
+	static const char * const texts_1724[] = {
 		"8000",		/* 0: 6 */
 		"9600",		/* 1: 3 */
 		"11025",	/* 2: 10 */
@@ -1602,7 +1601,7 @@ static int snd_vt1724_pro_internal_clock
 		"192000",	/* 14: 14 */
 		"IEC958 Input",	/* 15: -- */
 	};
-	static char *texts_1720[] = {
+	static const char * const texts_1720[] = {
 		"8000",		/* 0: 6 */
 		"9600",		/* 1: 3 */
 		"11025",	/* 2: 10 */
@@ -1635,7 +1634,7 @@ static int snd_vt1724_pro_internal_clock
 					     struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	static unsigned char xlate[16] = {
+	static const unsigned char xlate[16] = {
 		9, 6, 3, 1, 7, 4, 0, 12, 8, 5, 2, 11, 13, 255, 14, 10
 	};
 	unsigned char val;
@@ -1694,7 +1693,7 @@ static int snd_vt1724_pro_internal_clock
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_internal_clock __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_pro_internal_clock __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock",
 	.info = snd_vt1724_pro_internal_clock_info,
@@ -1733,7 +1732,7 @@ static int snd_vt1724_pro_rate_locking_p
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_rate_locking __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_pro_rate_locking __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Locking",
 	.info = snd_vt1724_pro_rate_locking_info,
@@ -1772,7 +1771,7 @@ static int snd_vt1724_pro_rate_reset_put
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_rate_reset __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_pro_rate_reset __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Reset",
 	.info = snd_vt1724_pro_rate_reset_info,
@@ -1816,7 +1815,7 @@ static int get_route_val(struct snd_ice1
 {
 	unsigned long val;
 	unsigned char eitem;
-	static unsigned char xlate[8] = {
+	static const unsigned char xlate[8] = {
 		0, 255, 1, 2, 255, 255, 3, 4,
 	};
 
@@ -1835,7 +1834,7 @@ static int put_route_val(struct snd_ice1
 {
 	unsigned int old_val, nval;
 	int change;
-	static unsigned char xroute[8] = {
+	static const unsigned char xroute[8] = {
 		0, /* PCM */
 		2, /* PSDIN0 Left */
 		3, /* PSDIN0 Right */
@@ -1891,7 +1890,7 @@ static int snd_vt1724_pro_route_spdif_pu
 			     digital_route_shift(idx));
 }
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Playback Route",
 	.info = snd_vt1724_pro_route_info,
@@ -1899,7 +1898,7 @@ static struct snd_kcontrol_new snd_vt172
 	.put = snd_vt1724_pro_route_analog_put,
 };
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Route",
 	.info = snd_vt1724_pro_route_info,
@@ -1935,7 +1934,7 @@ static int snd_vt1724_pro_peak_get(struc
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
+static const struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Peak",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
@@ -1947,9 +1946,9 @@ static struct snd_kcontrol_new snd_vt172
  *
  */
 
-static struct snd_ice1712_card_info no_matched __devinitdata;
+static const struct snd_ice1712_card_info no_matched __devinitdata;
 
-static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
+static const struct snd_ice1712_card_info *card_tables[] __devinitdata = {
 	snd_vt1724_revo_cards,
 	snd_vt1724_amp_cards, 
 	snd_vt1724_aureon_cards,
@@ -1958,6 +1957,7 @@ static struct snd_ice1712_card_info *car
 	snd_vt1724_prodigy192_cards,
 	snd_vt1724_juli_cards,
 	snd_vt1724_phase_cards,
+	snd_vt1724_wtm_cards,
 	NULL,
 };
 
@@ -2007,7 +2007,7 @@ static int __devinit snd_vt1724_read_eep
 {
 	const int dev = 0xa0;		/* EEPROM device address */
 	unsigned int i, size;
-	struct snd_ice1712_card_info **tbl, *c;
+	const struct snd_ice1712_card_info **tbl, *c;
 
 	if (! modelname || ! *modelname) {
 		ice->eeprom.subvendor = 0;
@@ -2306,7 +2306,7 @@ static int __devinit snd_vt1724_probe(st
 	struct snd_card *card;
 	struct snd_ice1712 *ice;
 	int pcm_dev = 0, err;
-	struct snd_ice1712_card_info **tbl, *c;
+	const struct snd_ice1712_card_info **tbl, *c;
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;

--MP_s3z0fG0Ff69xZSKwX7VZx9M
Content-Type: text/x-patch; name=ice1712_rc1_to_rc3_h.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ice1712_rc1_to_rc3_h.diff

--- ice1712.rc1.h	2006-12-07 07:07:31.000000000 -0700
+++ ice1712.rc3.h	2007-03-06 05:26:32.000000000 -0700
@@ -514,8 +514,8 @@ struct snd_ice1712_card_info {
 	unsigned int mpu401_2_info_flags;
 	const char *mpu401_1_name;
 	const char *mpu401_2_name;
-	unsigned int eeprom_size;
-	unsigned char *eeprom_data;
+	const unsigned int eeprom_size;
+	const unsigned char *eeprom_data;
 };
 
 

--MP_s3z0fG0Ff69xZSKwX7VZx9M
Content-Type: text/x-patch; name=pcm_rc1_to_rc3.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=pcm_rc1_to_rc3.diff

--- pcm.rc1.c	2006-12-07 07:10:23.000000000 -0700
+++ pcm.rc3.c	2007-02-26 02:02:40.000000000 -0700
@@ -7155,7 +7155,7 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 	/* set the count of channels */
 	err = snd_pcm_hw_params_set_channels(pcm, params, channels);
 	if (err < 0) {
-		SNDERR("Channels count (%i) not available for %s: %s", s, channels, snd_strerror(err));
+		SNDERR("Channels count (%i) not available for %s: %s", channels, s, snd_strerror(err));
 		return err;
 	}
 	/* set the stream rate */
@@ -7212,7 +7212,7 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
         	period_time = latency / 4;
         	err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm, params, &period_time, NULL);
         	if (err < 0) {
-        		SNDERR("Unable to set period time %i for %s: %s", s, period_time, snd_strerror(err));
+        		SNDERR("Unable to set period time %i for %s: %s", period_time, s, snd_strerror(err));
         		return err;
         	}
                 err = INTERNAL(snd_pcm_hw_params_get_period_size)(params, &period_size, NULL);

--MP_s3z0fG0Ff69xZSKwX7VZx9M
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_s3z0fG0Ff69xZSKwX7VZx9M--
