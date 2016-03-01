From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9081: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:19:46 +0900
Message-ID: <E1aaaqg-0007zU-0X@finisterre>
References: <1456765278-5435-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D2AF26149E
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:20:08 +0100 (CET)
In-Reply-To: <1456765278-5435-9-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9081: Fix enum ctl accesses in a wrong type

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

>From 39a79fe10482572ce76fd724b7915b3ee4cbd81e Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:01:17 +0100
Subject: [PATCH] ASoC: wm9081: Fix enum ctl accesses in a wrong type

"Speaker Mode "ctl in wm9081 codec driver is enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9081.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index ccb3b15139ad..363b3b667616 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -344,9 +344,9 @@ static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 
 	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 	if (reg & WM9081_SPK_MODE)
-		ucontrol->value.integer.value[0] = 1;
+		ucontrol->value.enumerated.item[0] = 1;
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.enumerated.item[0] = 0;
 
 	return 0;
 }
@@ -365,7 +365,7 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 
 	/* Are we changing anything? */
-	if (ucontrol->value.integer.value[0] ==
+	if (ucontrol->value.enumerated.item[0] ==
 	    ((reg2 & WM9081_SPK_MODE) != 0))
 		return 0;
 
@@ -373,7 +373,7 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 	if (reg_pwr & WM9081_SPK_ENA)
 		return -EINVAL;
 
-	if (ucontrol->value.integer.value[0]) {
+	if (ucontrol->value.enumerated.item[0]) {
 		/* Class AB */
 		reg2 &= ~(WM9081_SPK_INV_MUTE | WM9081_OUT_SPK_CTRL);
 		reg2 |= WM9081_SPK_MODE;
-- 
2.7.0
