From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 01/15] ASoC: hdac_hdmi: Fix to check num nodes
	correctly
Date: Tue,  1 Dec 2015 23:16:57 +0530
Message-ID: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B658D261A80
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:27 +0100 (CET)
In-Reply-To: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
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

This patch fixes below static checker warning.
	sound/soc/codecs/hdac_hdmi.c:416 hdac_hdmi_parse_and_map_nid()
	warn: unsigned 'hdac->num_nodes' is never less than zero.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 205f2c2..65596b9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -415,7 +415,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	int cvt_nid = 0, pin_nid = 0;
 
 	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
-	if (!nid || hdac->num_nodes < 0) {
+	if (!nid || hdac->num_nodes <= 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
 		return -EINVAL;
 	}
-- 
1.9.1
