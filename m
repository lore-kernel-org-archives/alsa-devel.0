From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH 3/3] ASoC: cs4265: Add a SPDIF enable actl
Date: Mon, 27 Aug 2018 08:58:44 +1000
Message-ID: <20180826225844.13754-3-flatmax@flatmax.org>
References: <20180826225844.13754-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 850FF26784E
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 00:58:51 +0200 (CEST)
In-Reply-To: <20180826225844.13754-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, ckeepax@opensource.cirrus.com
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

This patch adds a SPDIF enable/disable toggle switch to the
sound controls.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/codecs/cs4265.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 17d7e6f0..cdfcca9c 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -112,6 +112,13 @@ static const char * const cam_mono_stereo_text[] = {
 static SOC_ENUM_SINGLE_DECL(spdif_mono_stereo_enum, CS4265_SPDIF_CTL2, 2,
 		cam_mono_stereo_text);
 
+static const char * const spdif_enable_text[] = {
+	"Enabled", "Disabled"
+};
+
+static SOC_ENUM_SINGLE_DECL(spdif_enable_enum, CS4265_SPDIF_CTL2, 5,
+		spdif_enable_text);
+
 static const char * const mono_select_text[] = {
 	"Channel A", "Channel B"
 };
@@ -151,6 +158,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
 				1, 1),
 	SOC_SINGLE("ADC Soft Ramp Switch", CS4265_ADC_CTL2, 7,
 				1, 0),
+	SOC_ENUM("SPDIF Enable", spdif_enable_enum),
 	SOC_SINGLE("E to F Buffer Disable Switch", CS4265_SPDIF_CTL1,
 				6, 1, 0),
 	SOC_ENUM("C Data Access", cam_mode_enum),
-- 
2.17.1
