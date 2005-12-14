From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Re: snd-es1968 (+ snd-cs4236) trouble
Date: Wed, 14 Dec 2005 05:55:13 +0100
Message-ID: <439FA5B1.8000601@keyaccess.nl>
References: <439B36E0.3090709@keyaccess.nl>	<s5hzmn6y1b1.wl%tiwai@suse.de>	<439DFF60.1020105@keyaccess.nl>	<439E7391.60408@keyaccess.nl> <s5h3bkxxnpv.wl%tiwai@suse.de> <439F2E13.7070405@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070903080106050104000202"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl [213.51.130.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B1CD61C8
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 05:51:14 +0100 (MET)
In-Reply-To: <439F2E13.7070405@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070903080106050104000202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

> I'll poke around some more to confirm the documentation was right about 
> the Legacy Audio bit. I see the SB-EMU can be set to 0x240 and that's 
> free here, so I'll try and see for which setting of the bit something 
> appears there.

Managed to already. Yes, confirmed, the documentation was right. snd-sb8 
actually loads for this emulation:

ALSA sound/isa/sb/sb_common.c:130: SB [0x240]: DSP chip found, version = 3.2

So anyways, the submitted patch, re-attached for convenience, was right.

Rene.



--------------070903080106050104000202
Content-Type: text/plain;
 name="linux-2.6.14.3_es1968_tdma_la_iem.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.14.3_es1968_tdma_la_iem.diff"

--- linux-2.6.14.3-local-wc/sound/pci/es1968.c.orig	2005-12-13 07:25:47.000000000 +0100
+++ linux-2.6.14.3-local-wc/sound/pci/es1968.c	2005-12-13 07:26:04.000000000 +0100
@@ -176,7 +176,7 @@ MODULE_PARM_DESC(joystick, "Enable joyst
 
 /* Values for the ESM_LEGACY_AUDIO_CONTROL */
 
-#define ESS_ENABLE_AUDIO	0x8000
+#define ESS_DISABLE_AUDIO	0x8000
 #define ESS_ENABLE_SERIAL_IRQ	0x4000
 #define IO_ADRESS_ALIAS		0x0020
 #define MPU401_IRQ_ENABLE	0x0010
@@ -195,7 +195,7 @@ MODULE_PARM_DESC(joystick, "Enable joyst
 #define DMA_TDMA		0x0100
 #define DMA_PCPCI		0x0200
 #define POST_WRITE		0x0080
-#define ISA_TIMING		0x0040
+#define PCI_TIMING		0x0040
 #define SWAP_LR			0x0020
 #define SUBTR_DECODE		0x0002
 
@@ -2197,14 +2197,11 @@ static void snd_es1968_chip_init(es1968_
 	/* Config Reg A */
 	pci_read_config_word(pci, ESM_CONFIG_A, &w);
 
-	/*      Use TDMA for now. TDMA works on all boards, so while its
-	 *      not the most efficient its the simplest. */
 	w &= ~DMA_CLEAR;	/* Clear DMA bits */
-	w |= DMA_TDMA;		/* TDMA on */
 	w &= ~(PIC_SNOOP1 | PIC_SNOOP2);	/* Clear Pic Snoop Mode Bits */
 	w &= ~SAFEGUARD;	/* Safeguard off */
 	w |= POST_WRITE;	/* Posted write */
-	w |= ISA_TIMING;	/* ISA timing on */
+	w |= PCI_TIMING;	/* PCI timing on */
 	/* XXX huh?  claims to be reserved.. */
 	w &= ~SWAP_LR;		/* swap left/right 
 				   seems to only have effect on SB
@@ -2245,7 +2242,7 @@ static void snd_es1968_chip_init(es1968_
 
 	pci_read_config_word(pci, ESM_LEGACY_AUDIO_CONTROL, &w);
 
-	w &= ~ESS_ENABLE_AUDIO;	/* Disable Legacy Audio */
+	w |= ESS_DISABLE_AUDIO;	/* Disable Legacy Audio */
 	w &= ~ESS_ENABLE_SERIAL_IRQ;	/* Disable SIRQ */
 	w &= ~(0x1f);		/* disable mpu irq/io, game port, fm, SB */
 

--------------070903080106050104000202--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
