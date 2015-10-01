From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Prevent writing reserved
	registers on tlv320aic3104 CODECs" to the asoc tree
Date: Thu, 01 Oct 2015 11:23:56 +0100
Message-ID: <E1Zhb1o-0007Oc-Qd@finisterre>
References: <1443655493-5554-1-git-send-email-rmann@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A59BD26662F
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 12:24:05 +0200 (CEST)
In-Reply-To: <1443655493-5554-1-git-send-email-rmann@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Prevent writing reserved registers on tlv320aic3104 CODECs

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2d1180e36905bf92892e265c662e5e597be01505 Mon Sep 17 00:00:00 2001
From: Rick Mann <rmann@latencyzero.com>
Date: Wed, 30 Sep 2015 16:24:53 -0700
Subject: [PATCH] ASoC: tlv320aic3x: Prevent writing reserved registers on
 tlv320aic3104 CODECs

The current code writes a set of registers that are reserved on the
tlc320aic3104. The change skips those registers for that IC.

Signed-off-by: Rick Mann <rmann@latencyzero.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 1a82b19..8739126 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1509,14 +1509,17 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	snd_soc_write(codec, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
 	snd_soc_write(codec, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
 
-	/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
-	snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
-	/* Line2 Line Out default volume, disconnect from Output Mixer */
-	snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+	/* On tlv320aic3104, these registers are reserved and must not be written */
+	if (aic3x->model != AIC3X_MODEL_3104) {
+		/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
+		snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
+		/* Line2 Line Out default volume, disconnect from Output Mixer */
+		snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+	}
 
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
-- 
2.5.0
