From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: tegra: Add DAPM widgets/routes for
	Harmony
Date: Thu, 13 Jan 2011 15:22:08 -0700
Message-ID: <1294957328-15869-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 47180103B71
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 23:22:17 +0100 (CET)
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

With this change, I can capture from a microphone plugged into the
mic jack on Harmony (after unmuting Left Input PGA, and maybe turning
up the gain there too).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Question: Harmony has a mono mic attached to the left input channel.
However, the I2S controller only supports stereo. Is it possible to
duplicate the mic input to both channels in ALSA? I know the WM8903
can do it via the WM8903_AUDIO_INTERFACE_0 register, but I'm not
sure how to request that in ALSA-speak. It looks like this same setup
applies to many other platforms, but I couldn't see how the issue was
solved, if at all.

 sound/soc/tegra/harmony.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index bf0dbaf..b160b71 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -107,6 +107,36 @@ static struct snd_soc_ops harmony_asoc_ops = {
 	.hw_params = harmony_asoc_hw_params,
 };
 
+static const struct snd_soc_dapm_widget harmony_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route harmony_audio_map[] = {
+	{"Headphone Jack", NULL, "HPOUTR"},
+	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Mic Bias", NULL, "Mic Jack"},
+	{"IN1L", NULL, "Mic Bias"},
+};
+
+static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_new_controls(dapm, harmony_dapm_widgets,
+					ARRAY_SIZE(harmony_dapm_widgets));
+
+	snd_soc_dapm_add_routes(dapm, harmony_audio_map,
+				ARRAY_SIZE(harmony_audio_map));
+
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
 static struct snd_soc_dai_link harmony_wm8903_dai = {
 	.name = "WM8903",
 	.stream_name = "WM8903 PCM",
@@ -114,6 +144,7 @@ static struct snd_soc_dai_link harmony_wm8903_dai = {
 	.platform_name = "tegra-pcm-audio",
 	.cpu_dai_name = "tegra-i2s.0",
 	.codec_dai_name = "wm8903-hifi",
+	.init = harmony_asoc_init,
 	.ops = &harmony_asoc_ops,
 };
 
-- 
1.7.0.4
