From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 6/6] ASoC: hdac_hdmi: Remove redundant
	assignments
Date: Wed,  6 Dec 2017 16:34:06 +0530
Message-ID: <20171206110406.11400-7-guneshwor.o.singh@intel.com>
References: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9BA2678F5
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 12:04:57 +0100 (CET)
In-Reply-To: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Patches Audio <patches.audio@intel.com>, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Puneeth Prabhu <puneethx.prabhu@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Puneeth Prabhu <puneethx.prabhu@intel.com>

Assignments for start_nid, end_nid and num_nodes of hdac_device
structure are already done in init.  So, remove the redundant
assignments.

Signed-off-by: Puneeth Prabhu <puneethx.prabhu@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index ab1889f55227..69d7404dfbc4 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1465,10 +1465,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		return -EINVAL;
 	}
 
-	hdev->num_nodes = num_nodes;
-	hdev->start_nid = nid;
-
-	for (i = 0; i < hdev->num_nodes; i++, nid++) {
+	for (i = 0; i < num_nodes; i++, nid++) {
 		unsigned int caps;
 		unsigned int type;
 
@@ -1494,8 +1491,6 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		}
 	}
 
-	hdev->end_nid = nid;
-
 	if (!hdmi->num_pin || !hdmi->num_cvt) {
 		ret = -EIO;
 		goto free_widgets;
-- 
2.15.1
