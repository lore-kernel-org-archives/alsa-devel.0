From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: dapm: Make sure register value is in
	sync with DAPM kcontrol state
Date: Mon,  9 Jun 2014 14:20:29 +0300
Message-ID: <1402312829-1163-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB0F2625D7
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 13:20:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit c9e065c27fe9 ("ASoC: dapm: Make sure to always update the DAPM graph
in _put_volsw()") stopped updating register values in those cases where
initial after boot state of kcontrol appears to not change but where
register value still needs update because it is not in sync with the
kcontrol state.

Fix this by doing snd_soc_test_bits() unconditionally as it was before but
by using separate flags for kcontrol and register state changes. This allow
both DAPM graph to be updated when disabling auto-muted control and update
register if it is out-of-sync in respect of kcontrol state.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For 3.16-rc. I noticed this with RT5640 where alsa-utils wasn't able to
unmute some mixers controls during boot. For instance "HPO MIX DAC1 Switch"
which is inverted in hw thus muted when bit is 1 and reset default is also 1.

Reason for this was that dapm_kcontrol_set_value() returns false when
unmuting inverted control because data->value == value == 0 after boot. Only
way to unmute was to do mute-unmute cycle.

I don't see there's reason to update initial data->value states from
hw/regmap but just do snd_soc_test_bits() unconditionally in
snd_soc_dapm_put_volsw() as it was before.
---
 sound/soc/soc-dapm.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a74b9bf23d9f..cdc837ed144d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2755,7 +2755,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val;
-	int connect, change;
+	int connect, change, reg_change = 0;
 	struct snd_soc_dapm_update update;
 	int ret = 0;
 
@@ -2773,20 +2773,23 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = dapm_kcontrol_set_value(kcontrol, val);
-	if (change) {
-		if (reg != SND_SOC_NOPM) {
-			mask = mask << shift;
-			val = val << shift;
-
-			if (snd_soc_test_bits(codec, reg, mask, val)) {
-				update.kcontrol = kcontrol;
-				update.reg = reg;
-				update.mask = mask;
-				update.val = val;
-				card->update = &update;
-			}
 
+	if (reg != SND_SOC_NOPM) {
+		mask = mask << shift;
+		val = val << shift;
+
+		reg_change = snd_soc_test_bits(codec, reg, mask, val);
+	}
+
+	if (change || reg_change) {
+		if (reg_change) {
+			update.kcontrol = kcontrol;
+			update.reg = reg;
+			update.mask = mask;
+			update.val = val;
+			card->update = &update;
 		}
+		change |= reg_change;
 
 		ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
 
-- 
2.0.0
