From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 09/13] ASoC: tlv320aic32x4: Fix clock
	activation on bias level change
Date: Mon, 18 Mar 2019 20:37:52 -0700
Message-ID: <20190319033756.20616-10-nh6z@nh6z.net>
References: <20190319033756.20616-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com
 [173.203.187.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46FC7F89715
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 04:38:19 +0100 (CET)
In-Reply-To: <20190319033756.20616-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The clocks are double-disabled when they are first coming up
because they are already off when it first moves into STANDBY.
Check if the state is already off and leave things alone if
it is.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index b8b97b211d46..10f0e07889b7 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -814,6 +814,8 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
 	int ret;
+	struct snd_soc_dapm_context *dapm =
+					snd_soc_component_get_dapm(component);
 
 	struct clk_bulk_data clocks[] = {
 		{ .id = "madc" },
@@ -836,6 +838,7 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		if (dapm->bias_level != SND_SOC_BIAS_OFF)
 			clk_bulk_disable_unprepare(ARRAY_SIZE(clocks), clocks);
 		break;
 	case SND_SOC_BIAS_OFF:
-- 
2.19.1
