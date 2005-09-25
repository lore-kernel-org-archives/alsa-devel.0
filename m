From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] Removing obsolete now AC97_SHARED_TYPES
Date: Sun, 25 Sep 2005 19:42:40 +0300
Message-ID: <20050925164240.GB16020@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
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
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Today the AC97 codec initialization procedures are effectively separated
for audio and modem codecs (by using AC97_SCAP_SKIP_MODEM,
AC97_SCAP_SKIP_AUDIO), this makes obsolete the AC97_SHARED_TYPES "locking"
mechanism. On the other hand this (AC97_SHARED_TYPES) prevents from AMC
codecs to work properly, for example this bug #0001435
( https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1435 ).

This patch cleans last (and useless) access to registers < 0x3c in MC97
initialization and removes AC97_SHARED_TYPES mechanism from ac97 core
and related chipset drivers. Please apply.

Sasha.


This patch cleans last ac97 audio/modem codec interception in
initialization procedures (ac97_mixer_new()) and removes obsolete
SHARED_TYPE "locking" which prevents from AMC codecs to function
correctly.

Signed-off-by: Sasha Khapyorsky

Index: alsa-kernel/include/ac97_codec.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/ac97_codec.h,v
retrieving revision 1.70
diff -u -p -r1.70 ac97_codec.h
--- alsa-kernel/include/ac97_codec.h	16 Sep 2005 17:49:22 -0000	1.70
+++ alsa-kernel/include/ac97_codec.h	22 Sep 2005 17:53:34 -0000
@@ -387,15 +387,6 @@
 #define AC97_RATES_MIC_ADC	4
 #define AC97_RATES_SPDIF	5
 
-/* shared controllers */
-enum {
-	AC97_SHARED_TYPE_NONE,
-	AC97_SHARED_TYPE_ICH,
-	AC97_SHARED_TYPE_ATIIXP,
-	AC97_SHARED_TYPE_VIA,
-	AC97_SHARED_TYPES
-};
-
 /*
  *
  */
@@ -468,7 +459,6 @@ struct _snd_ac97_bus {
 	unsigned short used_slots[2][4]; /* actually used PCM slots */
 	unsigned short pcms_count; /* count of PCMs */
 	struct ac97_pcm *pcms;
-	unsigned int shared_type;	/* type of shared controller betwen audio and modem */
 	ac97_t *codec[4];
 	snd_info_entry_t *proc;
 };
Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.199
diff -u -p -r1.199 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	16 Sep 2005 17:49:22 -0000	1.199
+++ alsa-kernel/pci/ac97/ac97_codec.c	22 Sep 2005 17:53:34 -0000
@@ -220,12 +220,6 @@ const char *snd_ac97_stereo_enhancements
   /*  31 */ "Reserved 31"
 };
 
-/*
- * Shared AC97 controllers (ICH, ATIIXP...)
- */
-static DECLARE_MUTEX(shared_codec_mutex);
-static ac97_t *shared_codec[AC97_SHARED_TYPES][4];
-
 
 /*
  *  I/O routines
@@ -996,14 +990,8 @@ static int snd_ac97_free(ac97_t *ac97)
 {
 	if (ac97) {
 		snd_ac97_proc_done(ac97);
-		if (ac97->bus) {
+		if (ac97->bus)
 			ac97->bus->codec[ac97->num] = NULL;
-			if (ac97->bus->shared_type) {
-				down(&shared_codec_mutex);
-				shared_codec[ac97->bus->shared_type-1][ac97->num] = NULL;
-				up(&shared_codec_mutex);
-			}
-		}
 		if (ac97->private_free)
 			ac97->private_free(ac97);
 		kfree(ac97);
@@ -1889,21 +1877,6 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 	snd_assert(bus != NULL && template != NULL, return -EINVAL);
 	snd_assert(template->num < 4 && bus->codec[template->num] == NULL, return -EINVAL);
 
-	snd_assert(bus->shared_type <= AC97_SHARED_TYPES, return -EINVAL);
-	if (bus->shared_type) {
-		/* already shared? */
-		down(&shared_codec_mutex);
-		ac97 = shared_codec[bus->shared_type-1][template->num];
-		if (ac97) {
-			if ((ac97_is_audio(ac97) && (template->scaps & AC97_SCAP_SKIP_AUDIO)) ||
-			    (ac97_is_modem(ac97) && (template->scaps & AC97_SCAP_SKIP_MODEM))) {
-				up(&shared_codec_mutex);
-				return -EACCES; /* skip this */
-			}
-		}
-		up(&shared_codec_mutex);
-	}
-
 	card = bus->card;
 	ac97 = kzalloc(sizeof(*ac97), GFP_KERNEL);
 	if (ac97 == NULL)
@@ -2153,7 +2126,7 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 		}
 	}
 	/* make sure the proper powerdown bits are cleared */
-	if (ac97->scaps) {
+	if (ac97->scaps && ac97_is_audio(ac97)) {
 		reg = snd_ac97_read(ac97, AC97_EXTENDED_STATUS);
 		if (ac97->scaps & AC97_SCAP_SURROUND_DAC) 
 			reg &= ~AC97_EA_PRJ;
@@ -2167,13 +2140,6 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 		return err;
 	}
 	*rac97 = ac97;
-
-	if (bus->shared_type) {
-		down(&shared_codec_mutex);
-		shared_codec[bus->shared_type-1][ac97->num] = ac97;
-		up(&shared_codec_mutex);
-	}
-
 	return 0;
 }
 
Index: alsa-kernel/pci/atiixp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/atiixp.c,v
retrieving revision 1.41
diff -u -p -r1.41 atiixp.c
--- alsa-kernel/pci/atiixp.c	12 Sep 2005 07:20:54 -0000	1.41
+++ alsa-kernel/pci/atiixp.c	22 Sep 2005 17:53:34 -0000
@@ -1372,7 +1372,6 @@ static int __devinit snd_atiixp_mixer_ne
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus)) < 0)
 		return err;
 	pbus->clock = clock;
-	pbus->shared_type = AC97_SHARED_TYPE_ATIIXP;	/* shared with modem driver */
 	chip->ac97_bus = pbus;
 
 	codec_count = 0;
Index: alsa-kernel/pci/atiixp_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/atiixp_modem.c,v
retrieving revision 1.22
diff -u -p -r1.22 atiixp_modem.c
--- alsa-kernel/pci/atiixp_modem.c	12 Sep 2005 10:42:16 -0000	1.22
+++ alsa-kernel/pci/atiixp_modem.c	22 Sep 2005 17:53:34 -0000
@@ -1067,7 +1067,6 @@ static int __devinit snd_atiixp_mixer_ne
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus)) < 0)
 		return err;
 	pbus->clock = clock;
-	pbus->shared_type = AC97_SHARED_TYPE_ATIIXP;	/* shared with audio driver */
 	chip->ac97_bus = pbus;
 
 	codec_count = 0;
Index: alsa-kernel/pci/intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.213
diff -u -p -r1.213 intel8x0.c
--- alsa-kernel/pci/intel8x0.c	12 Sep 2005 07:20:55 -0000	1.213
+++ alsa-kernel/pci/intel8x0.c	22 Sep 2005 17:53:36 -0000
@@ -2022,7 +2022,6 @@ static int __devinit snd_intel8x0_mixer(
 	if ((err = snd_ac97_bus(chip->card, 0, ops, chip, &pbus)) < 0)
 		goto __err;
 	pbus->private_free = snd_intel8x0_mixer_free_ac97_bus;
-	pbus->shared_type = AC97_SHARED_TYPE_ICH;	/* shared with modem driver */
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
 		pbus->clock = ac97_clock;
 	/* FIXME: my test board doesn't work well with VRA... */
Index: alsa-kernel/pci/intel8x0m.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.36
diff -u -p -r1.36 intel8x0m.c
--- alsa-kernel/pci/intel8x0m.c	12 Sep 2005 07:20:55 -0000	1.36
+++ alsa-kernel/pci/intel8x0m.c	22 Sep 2005 17:53:39 -0000
@@ -854,7 +854,6 @@ static int __devinit snd_intel8x0_mixer(
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus)) < 0)
 		goto __err;
 	pbus->private_free = snd_intel8x0_mixer_free_ac97_bus;
-	pbus->shared_type = AC97_SHARED_TYPE_ICH;	/* shared with audio driver */
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
 		pbus->clock = ac97_clock;
 	chip->ac97_bus = pbus;
Index: alsa-kernel/pci/via82xx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx.c,v
retrieving revision 1.169
diff -u -p -r1.169 via82xx.c
--- alsa-kernel/pci/via82xx.c	16 Sep 2005 18:07:52 -0000	1.169
+++ alsa-kernel/pci/via82xx.c	22 Sep 2005 17:53:39 -0000
@@ -1616,12 +1616,12 @@ static int __devinit snd_via82xx_mixer_n
 		return err;
 	chip->ac97_bus->private_free = snd_via82xx_mixer_free_ac97_bus;
 	chip->ac97_bus->clock = chip->ac97_clock;
-	chip->ac97_bus->shared_type = AC97_SHARED_TYPE_VIA;
 
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
 	ac97.private_free = snd_via82xx_mixer_free_ac97;
 	ac97.pci = chip->pci;
+	ac97.scaps = AC97_SCAP_SKIP_MODEM;
 	if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97)) < 0)
 		return err;
 
Index: alsa-kernel/pci/via82xx_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx_modem.c,v
retrieving revision 1.14
diff -u -p -r1.14 via82xx_modem.c
--- alsa-kernel/pci/via82xx_modem.c	12 Sep 2005 07:20:55 -0000	1.14
+++ alsa-kernel/pci/via82xx_modem.c	22 Sep 2005 17:53:39 -0000
@@ -878,7 +878,6 @@ static int __devinit snd_via82xx_mixer_n
 		return err;
 	chip->ac97_bus->private_free = snd_via82xx_mixer_free_ac97_bus;
 	chip->ac97_bus->clock = chip->ac97_clock;
-	chip->ac97_bus->shared_type = AC97_SHARED_TYPE_VIA;
 
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
Index: alsa-driver/pci/riptide/riptide.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/riptide/riptide.c,v
retrieving revision 1.7
diff -u -p -r1.7 riptide.c
--- alsa-driver/pci/riptide/riptide.c	12 Sep 2005 07:20:54 -0000	1.7
+++ alsa-driver/pci/riptide/riptide.c	22 Sep 2005 17:53:39 -0000
@@ -1947,7 +1947,6 @@ static int __devinit snd_riptide_mixer(r
 
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus)) < 0)
 		return err;
-	pbus->shared_type = AC97_SHARED_TYPE_NONE;	/* shared with modem driver ? */
 
 	chip->ac97_bus = pbus;
 	ac97.pci = chip->pci;


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
