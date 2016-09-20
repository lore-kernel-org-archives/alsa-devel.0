From: jeeja.kp@intel.com
Subject: [RFC 14/16] ASoC: Intel: Skylake: To support MST,
	add HDMI routes nau_ssm machine
Date: Tue, 20 Sep 2016 19:16:18 +0530
Message-ID: <1474379180-7132-15-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 64BC72666AA
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:38:23 +0200 (CEST)
In-Reply-To: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
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

Skylake platform support maximum of 3 ports per pin, so add the
additional routes for nau88l25_ssm4567 machine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index d1f843b..5901340 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -136,7 +136,11 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"DMic", NULL, "SoC DMIC"},
 
 	{"DP1", NULL, "hif5-0 Output"},
+	{"DP1", NULL, "hif5-1 Output"},
+	{"DP1", NULL, "hif5-2 Output"},
 	{"DP2", NULL, "hif6-0 Output"},
+	{"DP2", NULL, "hif6-1 Output"},
+	{"DP2", NULL, "hif6-2 Output"},
 
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
-- 
2.5.0
