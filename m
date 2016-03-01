From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l51: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:23:30 +0900
Message-ID: <E1aaauI-00087B-JK@finisterre>
References: <1456765379-5527-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B57E265B55
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:23:56 +0100 (CET)
In-Reply-To: <1456765379-5527-1-git-send-email-tiwai@suse.de>
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

   ASoC: cs42l51: Fix enum ctl accesses in a wrong type

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

>From 89300b4e5a5b5b5c145318f3b257291239522da6 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:02:59 +0100
Subject: [PATCH] ASoC: cs42l51: Fix enum ctl accesses in a wrong type

"PCM channel mixer" ctl in cs42l51 codec driver is enum, while the
current driver accesses wrongly via value.integer.value[].  They have
to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index b3951524339f..35488f14e237 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -60,15 +60,15 @@ static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
 	switch (value) {
 	default:
 	case 0:
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.enumerated.item[0] = 0;
 		break;
 	/* same value : (L+R)/2 and (R+L)/2 */
 	case 1:
 	case 2:
-		ucontrol->value.integer.value[0] = 1;
+		ucontrol->value.enumerated.item[0] = 1;
 		break;
 	case 3:
-		ucontrol->value.integer.value[0] = 2;
+		ucontrol->value.enumerated.item[0] = 2;
 		break;
 	}
 
@@ -85,7 +85,7 @@ static int cs42l51_set_chan_mix(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned char val;
 
-	switch (ucontrol->value.integer.value[0]) {
+	switch (ucontrol->value.enumerated.item[0]) {
 	default:
 	case 0:
 		val = CHAN_MIX_NORMAL;
-- 
2.7.0
