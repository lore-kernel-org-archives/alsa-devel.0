From: jeeja.kp@intel.com
Subject: [PATCH v4 4/5] ASoC: Intel: bxt: Add route change to
	rt298 machine
Date: Mon,  6 Feb 2017 12:09:17 +0530
Message-ID: <1486363158-16496-5-git-send-email-jeeja.kp@intel.com>
References: <1486363158-16496-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E506266884
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 07:28:00 +0100 (CET)
In-Reply-To: <1486363158-16496-1-git-send-email-jeeja.kp@intel.com>
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
port. So change the route in bxt_rt298 machine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index bc9ee09..09be868 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -92,9 +92,9 @@ static const struct snd_soc_dapm_route broxton_rt298_map[] = {
 	{"DMIC1 Pin", NULL, "DMIC2"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"HDMI1", NULL, "hif5 Output"},
-	{"HDMI2", NULL, "hif6 Output"},
-	{"HDMI3", NULL, "hif7 Output"},
+	{"HDMI1", NULL, "hif5-0 Output"},
+	{"HDMI2", NULL, "hif6-0 Output"},
+	{"HDMI2", NULL, "hif7-0 Output"},
 
 	/* CODEC BE connections */
 	{ "AIF1 Playback", NULL, "ssp5 Tx"},
-- 
2.5.0
