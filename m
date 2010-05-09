From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/5] ASoC: Allow DAI links to be kept active
	over suspend
Date: Sun,  9 May 2010 13:40:49 +0100
Message-ID: <1273408849-28599-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E7E6245BD
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:40:52 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

As well as allowing DAPM pins to be marked as ignoring suspend allow DAI
links to be similarly marked.  This is primarily intended for digital
links between CODECs and non-CPU devices such as basebands in mobile
phones and will suppress all suspend calls for the DAI link.  It is
likely that this will need to be revisited if used with devices which
are part of the SoC CPU.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This patch is (as the timestamp and numbering indicate) a late addition
to the series and has not been tested at all yet but hopefully it or
something close to it will do the trick for digital links.

 include/sound/soc.h  |    3 +++
 sound/soc/soc-core.c |   38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9f306f0..8326fc3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -505,6 +505,9 @@ struct snd_soc_dai_link  {
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_codec *codec);
 
+	/* Keep DAI active over suspend */
+	unsigned int ignore_suspend:1;
+
 	/* Symmetry requirements */
 	unsigned int symmetric_rates:1;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8661e5b..34f71bf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -893,19 +893,31 @@ static int soc_suspend(struct device *dev)
 	/* mute any active DAC's */
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (dai->ops->digital_mute && dai->playback.active)
 			dai->ops->digital_mute(dai, 1);
 	}
 
 	/* suspend all pcms */
-	for (i = 0; i < card->num_links; i++)
+	for (i = 0; i < card->num_links; i++) {
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		snd_pcm_suspend_all(card->dai_link[i].pcm);
+	}
 
 	if (card->suspend_pre)
 		card->suspend_pre(pdev, PMSG_SUSPEND);
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (cpu_dai->suspend && !cpu_dai->ac97_control)
 			cpu_dai->suspend(cpu_dai);
 		if (platform->suspend)
@@ -918,6 +930,10 @@ static int soc_suspend(struct device *dev)
 
 	for (i = 0; i < codec->num_dai; i++) {
 		char *stream = codec->dai[i].playback.stream_name;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (stream != NULL)
 			snd_soc_dapm_stream_event(codec, stream,
 				SND_SOC_DAPM_STREAM_SUSPEND);
@@ -943,6 +959,10 @@ static int soc_suspend(struct device *dev)
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (cpu_dai->suspend && cpu_dai->ac97_control)
 			cpu_dai->suspend(cpu_dai);
 	}
@@ -982,6 +1002,10 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (cpu_dai->resume && cpu_dai->ac97_control)
 			cpu_dai->resume(cpu_dai);
 	}
@@ -1004,6 +1028,10 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	for (i = 0; i < codec->num_dai; i++) {
 		char *stream = codec->dai[i].playback.stream_name;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (stream != NULL)
 			snd_soc_dapm_stream_event(codec, stream,
 				SND_SOC_DAPM_STREAM_RESUME);
@@ -1016,12 +1044,20 @@ static void soc_resume_deferred(struct work_struct *work)
 	/* unmute any active DACs */
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (dai->ops->digital_mute && dai->playback.active)
 			dai->ops->digital_mute(dai, 0);
 	}
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+
+		if (card->dai_link[i].ignore_suspend)
+			continue;
+
 		if (cpu_dai->resume && !cpu_dai->ac97_control)
 			cpu_dai->resume(cpu_dai);
 		if (platform->resume)
-- 
1.7.0.5
