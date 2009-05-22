From: Andreas Mohr <andi@lisas.de>
Subject: [PATCH] Kill truncate warning by shortening
	Sigmatel-specific AC97	control name
Date: Fri, 22 May 2009 17:48:58 +0200
Message-ID: <20090522154858.GA7406@rhlx01.hs-esslingen.de>
References: <20090521182553.GA31805@rhlx01.hs-esslingen.de>
	<s5h4ovdhd8x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C77D2415F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 17:49:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4ovdhd8x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Hi,

ChangeLog:

Avoid
ALSA sound/core/control.c:232: Control name 'Sigmatel Surround Phase Inversion Playback Switch' truncated
 to 'Sigmatel Surround Phase Inversion Playback '
bootup message by omitting weird Sigmatel prefix in this case; also fix
up the related ca0106 mixer control removal part by using identical naming
there.


Patch runtime-tested on -rc6, then diffed, run through checkpatch.pl
and readjusted accordingly.

I guess that this is more or less what one should have done after your
very fast reply...

BTW, the "3D Control Sigmatel - Depth" vs. "3D Control - Switch" is even
weirder naming, methinks.

Thanks!!

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -uprN linux-2.6.30-rc6.orig/sound/pci/ac97/ac97_patch.c linux-2.6.30-rc6.patched/sound/pci/ac97/ac97_patch.c
--- linux-2.6.30-rc6.orig/sound/pci/ac97/ac97_patch.c	2009-05-22 17:26:44.000000000 +0200
+++ linux-2.6.30-rc6.patched/sound/pci/ac97/ac97_patch.c	2009-05-22 17:35:20.000000000 +0200
@@ -958,10 +958,13 @@ static int patch_sigmatel_stac9708_3d(st
 }
 
 static const struct snd_kcontrol_new snd_ac97_sigmatel_4speaker =
-AC97_SINGLE("Sigmatel 4-Speaker Stereo Playback Switch", AC97_SIGMATEL_DAC2INVERT, 2, 1, 0);
+AC97_SINGLE("Sigmatel 4-Speaker Stereo Playback Switch",
+		AC97_SIGMATEL_DAC2INVERT, 2, 1, 0);
 
+/* "Sigmatel " removed due to excessive name length: */
 static const struct snd_kcontrol_new snd_ac97_sigmatel_phaseinvert =
-AC97_SINGLE("Sigmatel Surround Phase Inversion Playback Switch", AC97_SIGMATEL_DAC2INVERT, 3, 1, 0);
+AC97_SINGLE("Surround Phase Inversion Playback Switch",
+		AC97_SIGMATEL_DAC2INVERT, 3, 1, 0);
 
 static const struct snd_kcontrol_new snd_ac97_sigmatel_controls[] = {
 AC97_SINGLE("Sigmatel DAC 6dB Attenuate", AC97_SIGMATEL_ANALOG, 1, 1, 0),
diff -uprN linux-2.6.30-rc6.orig/sound/pci/ca0106/ca0106_mixer.c linux-2.6.30-rc6.patched/sound/pci/ca0106/ca0106_mixer.c
--- linux-2.6.30-rc6.orig/sound/pci/ca0106/ca0106_mixer.c	2009-05-22 17:26:59.000000000 +0200
+++ linux-2.6.30-rc6.patched/sound/pci/ca0106/ca0106_mixer.c	2009-05-22 17:11:57.000000000 +0200
@@ -800,7 +800,7 @@ int __devinit snd_ca0106_mixer(struct sn
 		"Capture Volume",
 		"External Amplifier",
 		"Sigmatel 4-Speaker Stereo Playback Switch",
-		"Sigmatel Surround Phase Inversion Playback ",
+		"Surround Phase Inversion Playback Switch",
 		NULL
 	};
 	static char *ca0106_rename_ctls[] = {
