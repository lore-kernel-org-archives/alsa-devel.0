From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v4 REPOST 01/14] ASoC: hdac_hdmi: Fix to check
	num nodes correctly
Date: Mon,  4 Jan 2016 11:10:51 +0530
Message-ID: <1451886064-30792-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1451886064-30792-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D6DF02604F8
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 06:38:42 +0100 (CET)
In-Reply-To: <1451886064-30792-1-git-send-email-subhransu.s.prusty@intel.com>
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

commit 3c83ac23253c ("ASoC: hdac_hdmi: check error return") fixes
the static checker warning reported by Dan Carpenter:

	sound/soc/codecs/hdac_hdmi.c:416 hdac_hdmi_parse_and_map_nid()
	warn: unsigned 'hdac->num_nodes' is never less than zero.

But it doesn't fix the issue completely.

It's also a failure if no sub nodes found for an afg node. So modify
the return condition appropriately.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 1a2f33b..929f27b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -415,7 +415,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	int cvt_nid = 0, pin_nid = 0;
 
 	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
-	if (!nid || num_nodes < 0) {
+	if (!nid || num_nodes <= 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
 		return -EINVAL;
 	}
-- 
1.9.1
