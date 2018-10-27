From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/3] ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures
Date: Sat, 27 Oct 2018 15:34:43 +0200
Message-ID: <1540647284-26728-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/qcom/qdsp6/q6afe-dai.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 60ff4a2d3577..a07a4538d5cf 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -561,13 +561,13 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
 };
 
-static struct snd_soc_dai_ops q6hdmi_ops = {
+static const struct snd_soc_dai_ops q6hdmi_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6hdmi_hw_params,
 	.shutdown	= q6afe_dai_shutdown,
 };
 
-static struct snd_soc_dai_ops q6i2s_ops = {
+static const struct snd_soc_dai_ops q6i2s_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6i2s_hw_params,
 	.set_fmt	= q6i2s_set_fmt,
@@ -575,14 +575,14 @@ static struct snd_soc_dai_ops q6i2s_ops = {
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
 };
 
-static struct snd_soc_dai_ops q6slim_ops = {
+static const struct snd_soc_dai_ops q6slim_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6slim_hw_params,
 	.shutdown	= q6afe_dai_shutdown,
 	.set_channel_map = q6slim_set_channel_map,
 };
 
-static struct snd_soc_dai_ops q6tdm_ops = {
+static const struct snd_soc_dai_ops q6tdm_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.shutdown	= q6afe_dai_shutdown,
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
