From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 02/15] ASoC: hdac_hdmi: Fix to warn instead
	of err for no connected nids
Date: Tue,  8 Dec 2015 02:54:16 +0530
Message-ID: <1449523469-4395-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 54BCD2612BD
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:53:59 +0100 (CET)
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

It is possible that some pin widget may return with no converter
connected. So don't throw error if none are found to be connected.
Instead print a warning and continue.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 929f27b..429fa14 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -316,10 +316,12 @@ static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
 
 	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
 			pin->mux_nids, HDA_MAX_CONNECTIONS);
-	if (pin->num_mux_nids == 0) {
-		dev_err(&hdac->hdac.dev, "No connections found\n");
-		return -ENODEV;
-	}
+	if (pin->num_mux_nids == 0)
+		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n",
+								pin->nid);
+
+	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
+			pin->num_mux_nids, pin->nid);
 
 	return pin->num_mux_nids;
 }
-- 
1.9.1
