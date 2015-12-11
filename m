From: yang.a.fang@intel.com
Subject: [PATCH 4/8] ASoc: Intel: boards: fix dapm map of
	nau88l25_ssm4567 machine
Date: Fri, 11 Dec 2015 11:29:09 -0800
Message-ID: <1449862153-68738-4-git-send-email-yang.a.fang@intel.com>
References: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AC80026550C
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:31:07 +0100 (CET)
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

From: "Fang, Yang A" <yang.a.fang@intel.com>

The DAPM map for DMIC and SSP was not properly done, so fix that up.
Also mark machine as fully routed

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 65c65d4..9c9ebb8 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -108,22 +108,22 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 
 	/* other jacks */
 	{"MIC", NULL, "Headset Mic"},
-	{"DMIC AIF", NULL, "SoC DMIC"},
+	{"DMic", NULL, "SoC DMIC"},
 
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
 	{ "ssp0 Tx", NULL, "codec0_out"},
 
-	{ "AIF1 Playback", NULL, "ssp1 Tx"},
+	{ "Playback", NULL, "ssp1 Tx"},
 	{ "ssp1 Tx", NULL, "codec1_out"},
 
 	{ "codec0_in", NULL, "ssp1 Rx" },
-	{ "ssp1 Rx", NULL, "AIF1 Capture" },
+	{ "ssp1 Rx", NULL, "Capture" },
 
 	/* DMIC */
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
-	{ "DMIC01 Rx", NULL, "Capture" },
+	{ "DMIC01 Rx", NULL, "DMIC AIF" },
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
@@ -336,6 +336,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.codec_conf = ssm4567_codec_conf,
 	.num_configs = ARRAY_SIZE(ssm4567_codec_conf),
+	.fully_routed = true,
 };
 
 static int skylake_audio_probe(struct platform_device *pdev)
-- 
1.7.9.5
