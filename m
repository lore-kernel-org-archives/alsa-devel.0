From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Fix the spelling of 'exceed'"
	to the asoc tree
Date: Mon, 23 Apr 2018 19:04:42 +0100
Message-ID: <E1fAfpS-000498-DM@debutante>
References: <1524440474-12360-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 99EF0267662
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 20:04:44 +0200 (CEST)
In-Reply-To: <1524440474-12360-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Fix the spelling of 'exceed'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 51e786947fc575f519f10cf500b470d505a40b15 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 22 Apr 2018 21:02:10 -0300
Subject: [PATCH] ASoC: sgtl5000: Fix the spelling of 'exceed'

Fix the spelling of 'exceed' in two comments.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 7c1d65830c05..ce0d0d7df5f5 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -457,7 +457,7 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
  * avc_put_threshold function: register_value = 10^(dB/20) * 0.636 * 2^15 ==>
  * dB = ( fls(register_value) - 14.347 ) * 6.02
  *
- * As this calculation is expensive and the threshold dB values may not exeed
+ * As this calculation is expensive and the threshold dB values may not exceed
  * 0 to 96 we use pre-calculated values.
  */
 static int avc_get_threshold(struct snd_kcontrol *kcontrol,
@@ -490,7 +490,7 @@ static int avc_get_threshold(struct snd_kcontrol *kcontrol,
  *
  * The register value is calculated by following formula:
  *                                    register_value = 10^(dB/20) * 0.636 * 2^15
- * As this calculation is expensive and the threshold dB values may not exeed
+ * As this calculation is expensive and the threshold dB values may not exceed
  * 0 to 96 we use pre-calculated values.
  */
 static int avc_put_threshold(struct snd_kcontrol *kcontrol,
-- 
2.17.0
