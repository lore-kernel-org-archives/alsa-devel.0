From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt6358: initialize setting
	when ramping volume" to the asoc tree
Date: Wed,  8 May 2019 10:01:32 +0100 (BST)
Message-ID: <20190508090132.61F98440040@finisterre.sirena.org.uk>
References: <20190507101220.182466-2-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05F95F8973C
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 11:01:50 +0200 (CEST)
In-Reply-To: <20190507101220.182466-2-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tiwai@suse.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt6358: initialize setting when ramping volume

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From bdb8fa6b09a801a6cbe3c2487f0228860f9c5aba Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 7 May 2019 18:12:18 +0800
Subject: [PATCH] ASoC: mediatek: mt6358: initialize setting when ramping
 volume

Mt6358 ramps up from the smallest volume (i.e. -10dB) to target dB when
opening and ramps down from target dB to mute (i.e. -40dB) when closing.
If target is equal to -10dB when opening, headset_volume_ramp() simply
leaves current setting (which may not be -10dB) unchanged.

Execute the loop at least once to initialize the setting to the
starting point (i.e. from).

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6358.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index d4c4fee6d3d9..96547ae50a5d 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -405,10 +405,9 @@ static bool is_valid_hp_pga_idx(int reg_idx)
 	       reg_idx == DL_GAIN_N_40DB;
 }
 
-static void headset_volume_ramp(struct mt6358_priv *priv,
-				int from, int to)
+static void headset_volume_ramp(struct mt6358_priv *priv, int from, int to)
 {
-	int offset = 0, count = 1, reg_idx;
+	int offset = 0, count = 0, reg_idx;
 
 	if (!is_valid_hp_pga_idx(from) || !is_valid_hp_pga_idx(to))
 		dev_warn(priv->dev, "%s(), volume index is not valid, from %d, to %d\n",
@@ -422,7 +421,7 @@ static void headset_volume_ramp(struct mt6358_priv *priv,
 	else
 		offset = from - to;
 
-	while (offset > 0) {
+	while (offset >= 0) {
 		if (to > from)
 			reg_idx = from + count;
 		else
-- 
2.20.1
