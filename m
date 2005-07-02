From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [stable] Fix emu10k1 breakages in kernel 2.6.12
Date: Sat, 02 Jul 2005 01:45:05 -0400
Message-ID: <1120283105.6975.21.camel@mindpipe>
References: <1120273701.12256.30.camel@mindpipe>
	 <20050702045614.GB5303@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050702045614.GB5303@kroah.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <greg@kroah.com>
Cc: stable@kernel.org, Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, Peter Zubaj <pzad@pobox.sk>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel <alsa-devel@lists.sourceforge.net>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-07-01 at 21:56 -0700, Greg KH wrote:
> On Fri, Jul 01, 2005 at 11:08:21PM -0400, Lee Revell wrote:
> > This set of critical fixes did not make it into the 2.6.12 kernel.
> 
> Is this patch in mainline already?
> 

Yes, these fixes have been in ALSA CVS for 2-6 weeks.

> A few minor complaints that make me worried about it for the -stable
> kernel:
> 	- it's bigger than expected for the -stable tree to take in just
> 	  one patch.  Can you split it up into smaller pieces (one with
> 	  the new table values, the other with the logic changes?)

The logic does have to change somewhat, because we were not handling
unknown devices in a backward compatible way.

Here's the updated patch.

This is all only compile tested, as a "real" test would require access
to a *lot* of hardware...

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
From: James Courtier-Dutton <James@superbug.co.uk>
From: Arnaud Patard <arnaud.patard@rtp-net.org>
From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
From: Peter Zubaj <pzad@pobox.sk>
From: Lee Revell <rlrevell@joe-job.com>
From: Takashi Iwai <tiwai@suse.de>

--- linux-2.6.12/include/sound/emu10k1.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-c3/include/sound/emu10k1.h	2005-07-02 01:25:49.000000000 -0400
@@ -1039,17 +1039,20 @@
 	u32 vendor;
 	u32 device;
 	u32 subsystem;
+	unsigned char revision;
 	unsigned char emu10k1_chip; /* Original SB Live. Not SB Live 24bit. */
 	unsigned char emu10k2_chip; /* Audigy 1 or Audigy 2. */
 	unsigned char ca0102_chip;  /* Audigy 1 or Audigy 2. Not SB Audigy 2 Value. */
 	unsigned char ca0108_chip;  /* Audigy 2 Value */
 	unsigned char ca0151_chip;  /* P16V */
+	unsigned char sblive51;	    /* SBLive! 5.1 - extout 0x11 -> center, 0x12 -> lfe */
 	unsigned char spk71;        /* Has 7.1 speakers */
 	unsigned char spdif_bug;    /* Has Spdif phasing bug */
 	unsigned char ac97_chip;    /* Has an AC97 chip */
 	unsigned char ecard;        /* APS EEPROM */
-	char * driver;
-	char * name;
+	const char *driver;
+	const char *name;
+	const char *id;		/* for backward compatibility - can be NULL if not needed */
 } emu_chip_details_t;
 
 struct _snd_emu10k1 {
--- linux-2.6.12/sound/pci/emu10k1/emu10k1_main.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-c3/sound/pci/emu10k1/emu10k1_main.c	2005-07-02 01:19:40.000000000 -0400
@@ -612,21 +612,24 @@
 	return snd_emu10k1_free(emu);
 }
 
-/* vendor, device, subsystem, emu10k1_chip, emu10k2_chip, ca0102_chip, ca0108_chip, ca0151_chip, spk71, spdif_bug, ac97_chip, ecard, driver, name */
-
 static emu_chip_details_t emu_chip_details[] = {
 	/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn off interpolators.*/
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10011102,
 	 .driver = "Audigy2", .name = "Audigy 2 Value [SB0400]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
-	 .spk71 = 1} ,
+	 .spk71 = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0008, 
 	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
-	 .ca0108_chip = 1} ,
+	 .ca0108_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20071102,
 	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -635,6 +638,7 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20021102,
 	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -643,6 +647,7 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20011102,
 	 .driver = "Audigy2", .name = "Audigy 2 ZS [2001]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -651,6 +656,7 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10071102,
 	 .driver = "Audigy2", .name = "Audigy 2 [SB0240]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -659,35 +665,165 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10051102,
 	 .driver = "Audigy2", .name = "Audigy 2 EX [1005]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
 	 .spdif_bug = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
 	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
 	 .spk71 = 1,
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .revision = 0x04,
+	 .driver = "Audigy2", .name = "Audigy 2 [Unknown]",
+	 .id = "Audigy2",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10020052,
+	 .driver = "Audigy", .name = "Audigy 1 ES [SB0160]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00531102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00511102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
-	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]", 
+	 .driver = "Audigy", .name = "Audigy 1 [Unknown]", 
+	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
-	 .spdif_bug = 1} ,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
 	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
+	 .id = "APS",
 	 .emu10k1_chip = 1,
 	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
+	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80401102,
+	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
+	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00211102,
+	 .driver = "EMU10K1", .name = "SBLive! [CT4620]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00201102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80221102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4780]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80231102,
+	 .driver = "EMU10K1", .name = "SB PCI512 [CT4790]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80261102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4830]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80311102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4831]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80281102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4870]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80321102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4871]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0060]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80691102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0101]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806A1102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0103]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806B1102,
+	 .driver = "EMU10K1", .name = "SBLive! [SB0105]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002,
 	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
+	 .id = "Live",
 	 .emu10k1_chip = 1,
-	 .ac97_chip = 1} ,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{ } /* terminator */
 };
 
@@ -738,13 +874,15 @@
 	emu->revision = revision;
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
-	emu->card_type = EMU10K1_CARD_CREATIVE;
 	snd_printdd("vendor=0x%x, device=0x%x, subsystem_vendor_id=0x%x, subsystem_id=0x%x\n",pci->vendor, pci->device, emu->serial, emu->model);
 
 	for (c = emu_chip_details; c->vendor; c++) {
 		if (c->vendor == pci->vendor && c->device == pci->device) {
-			if (c->subsystem == emu->serial) break;
-			if (c->subsystem == 0) break;
+			if (c->subsystem && c->subsystem != emu->serial)
+				continue;
+			if (c->revision && c->revision != emu->revision)
+				continue;
+			break;
 		}
 	}
 	if (c->vendor == 0) {
@@ -759,6 +897,23 @@
 	else
 		snd_printdd("Sound card name=%s, vendor=0x%x, device=0x%x, subsystem=0x%x\n", c->name, pci->vendor, pci->device, emu->serial);
 	
+	if (!*card->id && c->id) {
+		int i, n = 0;
+		strlcpy(card->id, c->id, sizeof(card->id));
+		for (;;) {
+			for (i = 0; i < snd_ecards_limit; i++) {
+				if (snd_cards[i] && !strcmp(snd_cards[i]->id, card->id))
+					break;
+			}
+			if (i >= snd_ecards_limit)
+				break;
+			n++;
+			if (n >= SNDRV_CARDS)
+				break;
+			snprintf(card->id, sizeof(card->id), "%s_%d", c->id, n);
+		}
+	}
+
 	is_audigy = emu->audigy = c->emu10k2_chip;
 
 	/* set the DMA transfer mask */




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
