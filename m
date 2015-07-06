From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: fix incorrect widget name
Date: Mon,  6 Jul 2015 14:12:38 -0700
Message-ID: <1436217158-58679-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B86B26087F
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 23:13:36 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, praveen.k.jain@intel.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

We should use "HiFi Playback" and "HiFi Capture".it will fix below err

cht-bsw-max98090: ASoC: no sink widget found for AIF1 Playback
cht-bsw-max98090: ASoC: Failed to add route ssp2 Tx -> direct ->
AIF1 Playback
cht-bsw-max98090: ASoC: no source widget found for AIF1 Capture
cht-bsw-max98090: ASoC: Failed to add route AIF1 Capture -> direct ->
ssp2 Rx

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index d604ee8..70f8321 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -69,12 +69,12 @@ static const struct snd_soc_dapm_route cht_audio_map[] = {
 	{"Headphone", NULL, "HPR"},
 	{"Ext Spk", NULL, "SPKL"},
 	{"Ext Spk", NULL, "SPKR"},
-	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"HiFi Playback", NULL, "ssp2 Tx"},
 	{"ssp2 Tx", NULL, "codec_out0"},
 	{"ssp2 Tx", NULL, "codec_out1"},
 	{"codec_in0", NULL, "ssp2 Rx" },
 	{"codec_in1", NULL, "ssp2 Rx" },
-	{"ssp2 Rx", NULL, "AIF1 Capture"},
+	{"ssp2 Rx", NULL, "HiFi Capture"},
 };
 
 static const struct snd_kcontrol_new cht_mc_controls[] = {
-- 
1.7.9.5
