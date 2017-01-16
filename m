From: jeeja.kp@intel.com
Subject: [PATCH 08/30] ASoC: Intel: Skylake: Add route change
	to rt286 machine
Date: Mon, 16 Jan 2017 23:27:35 +0530
Message-ID: <1484589477-7630-9-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D5B2670FA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:47:23 +0100 (CET)
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
port. So change the route in skl_rt286 machine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index dc5c361..5e56af3 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -94,9 +94,9 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 	{"DMIC1 Pin", NULL, "DMIC2"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"HDMI1", NULL, "hif5 Output"},
-	{"HDMI2", NULL, "hif6 Output"},
-	{"HDMI3", NULL, "hif7 Output"},
+	{"HDMI1", NULL, "hif5-0 Output"},
+	{"HDMI2", NULL, "hif6-0 Output"},
+	{"HDMI3", NULL, "hif7-0 Output"},
 
 	/* CODEC BE connections */
 	{ "AIF1 Playback", NULL, "ssp0 Tx"},
-- 
2.5.0
