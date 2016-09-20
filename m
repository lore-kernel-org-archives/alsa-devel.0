From: jeeja.kp@intel.com
Subject: [RFC 16/16] ASoC: Intel: Skylake: To support MST,
	add HDMI routes da7219_max machine
Date: Tue, 20 Sep 2016 19:16:20 +0530
Message-ID: <1474379180-7132-17-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id DC95C2666AA
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:38:29 +0200 (CEST)
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
additional routes for bxt_da7219_max98357a  machine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index c4dca26..5953c4f 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -84,7 +84,11 @@ static const struct snd_soc_dapm_route broxton_map[] = {
 
 	{"HDMI1", NULL, "hif5-0 Output"},
 	{"HDMI2", NULL, "hif6-0 Output"},
-	{"HDMI2", NULL, "hif7-0 Output"},
+	{"HDMI2", NULL, "hif6-1 Output"},
+	{"HDMI2", NULL, "hif6-2 Output"},
+	{"HDMI3", NULL, "hif7-0 Output"},
+	{"HDMI3", NULL, "hif7-1 Output"},
+	{"HDMI3", NULL, "hif7-2 Output"},
 
 	{"hifi3", NULL, "iDisp3 Tx"},
 	{"iDisp3 Tx", NULL, "iDisp3_out"},
-- 
2.5.0
