From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: snd_soc_dapm_put_volsw: Make sure to
	always update the DAPM graph
Date: Sun,  4 May 2014 19:17:05 +0200
Message-ID: <1399223826-28522-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id BF18B260864
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 19:17:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

When using auto-muted controls it may happen that the register value will not
change when changing a control from enabled to disabled (since the control might
be physically disabled due to the auto-muting). We have to make sure to still
update the DAPM graph and disconnect the mixer input.

Fixes: commit 5729507 ("ASoC: dapm: Implement mixer input auto-disable")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1871dfc..5d54dfc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2791,22 +2791,19 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = dapm_kcontrol_set_value(kcontrol, val);
-
-	if (reg != SND_SOC_NOPM) {
-		mask = mask << shift;
-		val = val << shift;
-
-		change = snd_soc_test_bits(codec, reg, mask, val);
-	}
-
 	if (change) {
 		if (reg != SND_SOC_NOPM) {
-			update.kcontrol = kcontrol;
-			update.reg = reg;
-			update.mask = mask;
-			update.val = val;
+			mask = mask << shift;
+			val = val << shift;
+
+			if (snd_soc_test_bits(codec, reg, mask, val)) {
+				update.kcontrol = kcontrol;
+				update.reg = reg;
+				update.mask = mask;
+				update.val = val;
+				card->update = &update;
+			}
 
-			card->update = &update;
 		}
 
 		ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
-- 
1.8.0
