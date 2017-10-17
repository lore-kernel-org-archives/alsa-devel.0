From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ASoC: tpa61xx: add back chip name to the
	controls
Date: Tue, 17 Oct 2017 11:57:29 +0200
Message-ID: <20171017095729.6032-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 90398266E26
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 11:57:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Commit cb7e62256e99( ASoC: tpa6130a2: Register component) removed the chip
name from the controls, which causes issues as the TPA61xx is not a
standalone codec, but a headphone amplifier, which may be connected to the
line out of a codec which already exposes a "Headphone Playback Volume"
control. In that case we end up with duplicate controls, causing the
the probe of the soundcard to be aborted.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 sound/soc/codecs/tpa6130a2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 2e014c80d113..abca7eedb6be 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -136,7 +136,7 @@ static const DECLARE_TLV_DB_RANGE(tpa6130_tlv,
 );
 
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
-	SOC_SINGLE_TLV("Headphone Playback Volume",
+	SOC_SINGLE_TLV("TPA6130A2 Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 0, 0x3f, 0,
 		       tpa6130_tlv),
 };
@@ -148,7 +148,7 @@ static const DECLARE_TLV_DB_RANGE(tpa6140_tlv,
 );
 
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
-	SOC_SINGLE_TLV("Headphone Playback Volume",
+	SOC_SINGLE_TLV("TPA6140A2 Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
 		       tpa6140_tlv),
 };
-- 
2.11.0
