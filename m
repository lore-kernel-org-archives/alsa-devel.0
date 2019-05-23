From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: qdsp6: q6core: Use struct_size() in kmemdup()
Date: Thu, 23 May 2019 11:07:48 -0500
Message-ID: <20190523160748.GA4844@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

sizeof(*fwk) + fwk->num_services * sizeof(fwk->svc_api_info[0]);

with:

struct_size(fwk, svc_api_info, fwk->num_services)

and so on...

Notice that variables bytes and len are unnecessary, hence they are
removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/qcom/qdsp6/q6core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index cdfc8ab6cfc0..ae314a652efe 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -98,13 +98,13 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 	}
 	case AVCS_CMDRSP_GET_FWK_VERSION: {
 		struct avcs_cmdrsp_get_fwk_version *fwk;
-		int bytes;
 
 		fwk = data->payload;
-		bytes = sizeof(*fwk) + fwk->num_services *
-				sizeof(fwk->svc_api_info[0]);
 
-		core->fwk_version = kmemdup(data->payload, bytes, GFP_ATOMIC);
+		core->fwk_version = kmemdup(data->payload,
+					    struct_size(fwk, svc_api_info,
+							fwk->num_services),
+					    GFP_ATOMIC);
 		if (!core->fwk_version)
 			return -ENOMEM;
 
@@ -115,13 +115,13 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 	}
 	case AVCS_GET_VERSIONS_RSP: {
 		struct avcs_cmdrsp_get_version *v;
-		int len;
 
 		v = data->payload;
 
-		len = sizeof(*v) + v->num_services * sizeof(v->svc_api_info[0]);
-
-		core->svc_version = kmemdup(data->payload, len, GFP_ATOMIC);
+		core->svc_version = kmemdup(data->payload,
+					    struct_size(v, svc_api_info,
+							v->num_services),
+					    GFP_ATOMIC);
 		if (!core->svc_version)
 			return -ENOMEM;
 
-- 
2.21.0
