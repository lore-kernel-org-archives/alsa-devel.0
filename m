From: jeeja.kp@intel.com
Subject: [PATCH 09/30] ASoC: Intel: Skylake: Add route change
	to nau88l25_max98357a machine
Date: Mon, 16 Jan 2017 23:27:36 +0530
Message-ID: <1484589477-7630-10-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A7F532670FA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:47:28 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

To support MST moved pin to port, this changes the routes based on
port. So change the route in nau88l25_max98357a machine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 436afb9..57acc58 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -141,8 +141,8 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("Spk", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
-	SND_SOC_DAPM_SPK("DP", NULL),
-	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SPK("DP1", NULL),
+	SND_SOC_DAPM_SPK("DP2", NULL),
 	SND_SOC_DAPM_SUPPLY("ssp0 mclk", SND_SOC_NOPM, 0, 0,
 			ssp_set_clk, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -163,8 +163,8 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{ "MIC", NULL, "Headset Mic" },
 	{ "DMic", NULL, "SoC DMIC" },
 
-	{"HDMI", NULL, "hif5 Output"},
-	{"DP", NULL, "hif6 Output"},
+	{"DP1", NULL, "hif5-0 Output"},
+	{"DP2", NULL, "hif6-0 Output"},
 
 	/* CODEC BE connections */
 	{ "HiFi Playback", NULL, "ssp0 Tx" },
-- 
2.5.0
