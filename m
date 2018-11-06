From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: qdsp6: q6asm-dai: Only add routing once.
Date: Tue,  6 Nov 2018 11:38:56 +0000
Message-ID: <20181106113857.19737-2-srinivas.kandagatla@linaro.org>
References: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

q6asm routing gets added multiple times as part of dai probe.
Move this to q6routing routes which has those widgets defined, this also
fixes the issue where these are added each time at dai probe.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 33 --------------------------------
 sound/soc/qcom/qdsp6/q6routing.c | 19 ++++++++++++++++++
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a16c71c03058..86115de5c1b2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -122,7 +122,6 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 			.rate_max =	48000,				\
 		},							\
 		.name = "MultiMedia"#num,				\
-		.probe = fe_dai_probe,					\
 		.id = MSM_FRONTEND_DAI_MULTIMEDIA##num,			\
 	}
 
@@ -511,38 +510,6 @@ static void q6asm_dai_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-static const struct snd_soc_dapm_route afe_pcm_routes[] = {
-	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
-	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
-	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
-	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
-	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
-	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia8 Playback" },
-	{"MultiMedia1 Capture", NULL, "MM_UL1"},
-	{"MultiMedia2 Capture", NULL, "MM_UL2"},
-	{"MultiMedia3 Capture", NULL, "MM_UL3"},
-	{"MultiMedia4 Capture", NULL, "MM_UL4"},
-	{"MultiMedia5 Capture", NULL, "MM_UL5"},
-	{"MultiMedia6 Capture", NULL, "MM_UL6"},
-	{"MultiMedia7 Capture", NULL, "MM_UL7"},
-	{"MultiMedia8 Capture", NULL, "MM_UL8"},
-
-};
-
-static int fe_dai_probe(struct snd_soc_dai *dai)
-{
-	struct snd_soc_dapm_context *dapm;
-
-	dapm = snd_soc_component_get_dapm(dai->component);
-	snd_soc_dapm_add_routes(dapm, afe_pcm_routes,
-				ARRAY_SIZE(afe_pcm_routes));
-
-	return 0;
-}
-
-
 static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.name		= DRV_NAME,
 	.ops		= &q6asm_dai_ops,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c6b51571be94..d61b8404f7da 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -909,6 +909,25 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
 	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
 	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
+
+	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
+	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
+	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
+	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
+	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
+	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
+	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
+	{"MM_DL8",  NULL, "MultiMedia8 Playback" },
+
+	{"MultiMedia1 Capture", NULL, "MM_UL1"},
+	{"MultiMedia2 Capture", NULL, "MM_UL2"},
+	{"MultiMedia3 Capture", NULL, "MM_UL3"},
+	{"MultiMedia4 Capture", NULL, "MM_UL4"},
+	{"MultiMedia5 Capture", NULL, "MM_UL5"},
+	{"MultiMedia6 Capture", NULL, "MM_UL6"},
+	{"MultiMedia7 Capture", NULL, "MM_UL7"},
+	{"MultiMedia8 Capture", NULL, "MM_UL8"},
+
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.19.1
