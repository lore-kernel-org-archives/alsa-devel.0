From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/6] ASoC: Tegra: Harmony: Add switch control
	for speaker
Date: Thu,  3 Feb 2011 13:56:14 -0700
Message-ID: <1296766578-13988-2-git-send-email-swarren@nvidia.com>
References: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7227410385F
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:56:28 +0100 (CET)
In-Reply-To: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 26ab4fd..e87395c 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -173,6 +173,10 @@ static const struct snd_soc_dapm_route harmony_audio_map[] = {
 	{"IN1L", NULL, "Mic Bias"},
 };
 
+static const struct snd_kcontrol_new harmony_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Int Spk"),
+};
+
 static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -191,13 +195,17 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 
 	gpio_direction_output(pdata->gpio_spkr_en, 0);
 
+	ret = snd_soc_add_controls(codec, harmony_controls,
+				   ARRAY_SIZE(harmony_controls));
+	if (ret < 0)
+		return ret;
+
 	snd_soc_dapm_new_controls(dapm, harmony_dapm_widgets,
 					ARRAY_SIZE(harmony_dapm_widgets));
 
 	snd_soc_dapm_add_routes(dapm, harmony_audio_map,
 				ARRAY_SIZE(harmony_audio_map));
 
-	snd_soc_dapm_enable_pin(dapm, "Int Spk");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_sync(dapm);
 
-- 
1.7.1
