From: yang.a.fang@intel.com
Subject: [PATCH 7/8] ASoc: Intel: boards: Add WOV as sink for
	nau88l25_ssm4567 machine
Date: Fri, 11 Dec 2015 11:29:12 -0800
Message-ID: <1449862153-68738-7-git-send-email-yang.a.fang@intel.com>
References: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 64A7D2666A3
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:31:19 +0100 (CET)
In-Reply-To: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rohit.m.ainapure@intel.com, james.ausmus@intel.com, vinod.koul@intel.com, joe.konno@intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

We have WOV module which should act as DAPM sink, so add that and
its links.

Also rename the refcap to "Wake On Voice" as some user expect to
find this name

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 1b54613..f6c252c 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -92,6 +92,7 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Speaker", NULL),
 	SND_SOC_DAPM_SPK("Right Speaker", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
+	SND_SOC_DAPM_SINK("WoV Sink"),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -110,6 +111,7 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMic", NULL, "SoC DMIC"},
 
+	{"WoV Sink", NULL, "hwd_in sink"},
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
@@ -188,6 +190,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	nau8825_enable_jack_detect(codec, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
 
 	return ret;
 }
@@ -383,7 +386,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "Skl Audio Reference cap",
-		.stream_name = "refcap",
+		.stream_name = "Wake on Voice",
 		.cpu_dai_name = "Reference Pin",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
-- 
1.7.9.5
