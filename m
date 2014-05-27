From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: Fix Left/Rigth PGA
	mixer widgets/kcontrols
Date: Tue, 27 May 2014 13:53:06 +0300
Message-ID: <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 789CF261AD8
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 12:53:16 +0200 (CEST)
In-Reply-To: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
control" changed the way how the 'value' has been stored for a widget.
Since the driver is not updated following the mentioned commit it is mostly
broken when we try to change mixers for Left/Right PGA since the value is
not going to be updated correctly.
This can be seen when trying to switch of one of the routes for the first
time (the second try will succeed):
amixer sset 'Left PGA Mixer Line1L' off
amixer: Invalid command!

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d7349bc89ad3..167c95bdf289 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -156,21 +156,21 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	int connect, change;
 
 	val = (ucontrol->value.integer.value[0] & mask);
+	connect = !!val;
+
+	if (invert)
+		val = max - val;
+
+	change = dapm_kcontrol_set_value(kcontrol, val);
 
 	mask = 0xf;
 	if (val)
 		val = mask;
 
-	connect = !!val;
-
-	if (invert)
-		val = mask - val;
-
 	mask <<= shift;
 	val <<= shift;
 
-	change = snd_soc_test_bits(codec, val, mask, reg);
-	if (change) {
+	if (change && snd_soc_test_bits(codec, val, mask, reg)) {
 		update.kcontrol = kcontrol;
 		update.reg = reg;
 		update.mask = mask;
-- 
1.9.3
