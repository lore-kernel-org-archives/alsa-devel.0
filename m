From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: ca0106 Digital Output at 44.1kHz
Date: Thu, 13 Mar 2008 23:15:24 +1100
Message-ID: <1205410524.8486.274.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-K3YQbAZAZwOuwwuWZyMr"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id A2B81103917
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 13:15:29 +0100 (CET)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1JZmLF-0003Dj-LO
	for alsa-devel@alsa-project.org; Thu, 13 Mar 2008 23:15:26 +1100
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


--=-K3YQbAZAZwOuwwuWZyMr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dear List,

Hello. I'm new here. This is my first attempt to hack an alsa driver.

I recently purchased a "Sound Blaster Audigy Value!" card for use in a
MythTV box. As I have a digital receiver, I was mainly concerned with
getting a working S/PDIF output (coax or optical) and not too much more.

Summary: I can make 44.1kHz digital output work, but I think that the
driver model of the card having 3 or 4 digital output channels is
incorrect. I believe the card only has 1 digital output channel.

Details:

The card I have is characterised by the following:
http://www.soundblaster.com/products/product.asp?category=1&subcategory=205&product=14189
Model: SB0570
serial: 100a1102
Also known as: Sound Blaster Audigy SE

During initial testing, I noticed that 44.1kHz playback was not
implemented. Subsequent testing shows that speaker-test works fine with
48kHz, 96kHz and 192kHz. (I only tested 16bit output so far.)

I noticed in the source code that 44.1k was explicitly disabled. I added
code in snd_ca0106_pcm_prepare_playback to set up this rate for S/PDIF
output as per the comments in ca0106.h . Initial tests using hw:0,0 at
44.1kHz produced recognisable signals with some noisy corruption. Later
I accidentally discovered that serially opening hw:0,2 , hw:0,1 and
hw:0,0  at 44.1kHz then produces perfectly good 44.1kHz sampled digital
audio output. Removing hw:0,1 or hw:0,2 from this sequence causes noisy
corruption. It seems that channels 0-2 in reg40 must all be set to the
same sampling frequency for S/PDIF to work where 44.1kHz is concerned.
Conversely, to sucessfully output 48kHz again, I have to open hw:0,2 ,
hw:0,1 and hw:0,0 at 48kHz to restore proper output. I do not have such
troubles with 96kHz and 192kHz, for which it suffices to just open
hw:0,0 at the relevant sampling rate.

Using these tricks, I can successfully output 44.1kHz encoded Dolby
Digital and DTS signals (found at
http://www.sr.se/cgi-bin/mall/index.asp?programid=2445 , as mentioned at
http://alsa.opensrc.org/DigitalOut . )

Later, I examined the product manual (from a Windows compressed helpfile
on the CD), and noticed that Creative instruct you to connect to the
blue socket in only two ways:
1) with a mono 3.5mm jack plug to RCA plug -> S/PDIF input to external
device, and
2) a proprietary digital I/O module (see
http://www.soundblaster.com/products/product.asp?category=1&subcategory=16&product=1780 )
The digital I/O module only has one input and one output (the
optical/coaxial pairs are duplicates of each other). 

The manual does not say how to connect a S/PDIF input signal other than
through the digital I/O module.

This suggests to me that the following comment near the top of
ca0106_main.c is incorrect for the SB0570:

 *    ( In theory one could output 3 different AC3 streams at once, to 3
different SPDIF outputs. )

I think you can only output one AC3 stream, and that there is only one
S/PDIF output.

Given this knowledge of the digital I/O module, I suggest that the
pinout *may* possibly be:
1 (tip): S/PDIF output
2      : S/PDIF input
3      : power to digital I/O module
4      : gnd
I have not been able to get any S/PDIF signal out of pin 2 (I only have
a stereo cable to test with at the moment). I will attempt to test pin 2
as an input at some point.

I think that this card can only output one S/PDIF channel, given the
discovery of the required clock settings above, and that Creative's own
hardware only gives you access to one output.

Anyway, I don't have access to documentation. From reading around, I
believe James has the docs under NDA from Creative Labs. Perhaps James
could confirm these suspicions?

Anyway, this is speculation. I'd love to have the docs. I haven't tried
to get them. Is it likely/unlikely that I would get them?

I'm currently working on kernel 2.6.22 from Ubuntu. They don't seem to
have changed the ca0106 driver, and not much has happened there (for
output) in the newer kernels.

Please find attached my current patch, which is only suitable for the
purposes of discussion. I need to clarify some things about channel
arrangements with those who have the documentation before I begin to try
to fix things up. This patch was written with a faulty understanding of
the interaction between the channel model and the spdif_enable. I don't
know how any of this affects other models in the ca0106 range.

So, I think that before I go any further here, I need some feedback, and
access to some documentation would be useful.

Ben Stanley.


--=-K3YQbAZAZwOuwwuWZyMr
Content-Disposition: attachment; filename=ca0106_44.1kHz_v0.1.patch
Content-Type: text/x-patch; name=ca0106_44.1kHz_v0.1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -u -r linux-source-2.6.22-2.6.22/sound/pci/ca0106/ca0106_main.c linux-source-2.6.22-2.6.22-ben/sound/pci/ca0106/ca0106_main.c
--- linux-source-2.6.22-2.6.22/sound/pci/ca0106/ca0106_main.c	2007-07-09 09:32:17.000000000 +1000
+++ linux-source-2.6.22-2.6.22-ben/sound/pci/ca0106/ca0106_main.c	2008-03-10 23:37:05.000000000 +1100
@@ -247,9 +247,9 @@
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000),
-	.rate_min =		48000,
+	.rates =		(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
+	.rate_min =		44100,
 	.rate_max =		192000,
 	.channels_min =		2,  //1,
 	.channels_max =		2,  //6,
@@ -610,12 +610,20 @@
 	u32 reg40_set = 0;
 	u32 reg40;
 	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
-	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+	/*u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+	u32 reg71_mask;
+	u32 reg71_shift;
 	u32 reg71_set = 0;
 	u32 reg71;
 	int i;
+	if (emu->spdif_enable) {
+		reg71_shift = 24; /* SPDIF Output Rate */
+	} else {
+		reg71_shift = 16; /* I2S Output Rate */
+	}
+	reg71_mask = 0x3 << reg71_shift;
 	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
         //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
 	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
 	/* Rate can be set per channel. */
@@ -623,24 +631,27 @@
 	/* reg71 controls DAC rate. */
 	switch (runtime->rate) {
 	case 44100:
-		reg40_set = 0x10000 << (channel<<1);
-		reg71_set = 0x01010000; 
-		break;
+		/* We only support 44100 to spdif, not to DAC. (FIXME WHY?)*/
+		if (emu->spdif_enable) {
+			reg40_set = 0x10000 << (channel<<1);
+			reg71_set = 0x1 << reg71_shift;
+			break;
+		}
         case 48000:
 		reg40_set = 0;
-		reg71_set = 0; 
+		reg71_set = 0;
 		break;
 	case 96000:
 		reg40_set = 0x20000 << (channel<<1);
-		reg71_set = 0x02020000; 
+		reg71_set = 0x2 << reg71_shift;
 		break;
 	case 192000:
 		reg40_set = 0x30000 << (channel<<1);
-		reg71_set = 0x03030000; 
+		reg71_set = 0x3 << reg71_shift;
 		break;
 	default:
 		reg40_set = 0;
-		reg71_set = 0; 
+		reg71_set = 0;
 		break;
 	}
 	/* Format is a global setting */
@@ -660,11 +671,15 @@
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
 	reg40 = snd_ca0106_ptr_read(emu, 0x40, 0);
+        snd_printk("ca0106: old reg40=%x\n", reg40);
 	reg40 = (reg40 & ~reg40_mask) | reg40_set;
 	snd_ca0106_ptr_write(emu, 0x40, 0, reg40);
+        snd_printk("ca0106: new reg40=%x\n", reg40);
 	reg71 = snd_ca0106_ptr_read(emu, 0x71, 0);
+        snd_printk("ca0106: old reg71=%x\n", reg71);
 	reg71 = (reg71 & ~reg71_mask) | reg71_set;
 	snd_ca0106_ptr_write(emu, 0x71, 0, reg71);
+        snd_printk("ca0106: new reg71=%x\n", reg71);
 
 	/* FIXME: Check emu->buffer.size before actually writing to it. */
         for(i=0; i < runtime->periods; i++) {
@@ -1300,6 +1315,7 @@
 #if 1
 	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
 	       chip->revision, chip->serial);
+	printk(KERN_INFO "snd-ca0106: 44100Hz capable Ben Stanley " __DATE__ ".\n" );
 #endif
 	strcpy(card->driver, "CA0106");
 	strcpy(card->shortname, "CA0106");

--=-K3YQbAZAZwOuwwuWZyMr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-K3YQbAZAZwOuwwuWZyMr--
