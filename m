From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 1/2] sound: q6core: Use kmemdup to replace kzalloc + memcpy
Date: Sat, 8 Sep 2018 16:36:19 +0800
Message-ID: <1536395780-18725-2-git-send-email-zhongjiang@huawei.com>
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz, broonie@kernel.org
Cc: lgirdwood@gmail.com, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

kmemdup has implemented the function that kzalloc() + memcpy() will
do. and we prefer to use the kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/qcom/qdsp6/q6core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index 06f03a5..ca1be73 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -105,12 +105,10 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 		bytes = sizeof(*fwk) + fwk->num_services *
 				sizeof(fwk->svc_api_info[0]);
 
-		core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
+		core->fwk_version = kmemdup(data->payload, bytes, GFP_ATOMIC);
 		if (!core->fwk_version)
 			return -ENOMEM;
 
-		memcpy(core->fwk_version, data->payload, bytes);
-
 		core->fwk_version_supported = true;
 		core->resp_received = true;
 
@@ -124,12 +122,10 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 
 		len = sizeof(*v) + v->num_services * sizeof(v->svc_api_info[0]);
 
-		core->svc_version = kzalloc(len, GFP_ATOMIC);
+		core->svc_version = kmemdup(data->payload, len, GFP_ATOMIC);
 		if (!core->svc_version)
 			return -ENOMEM;
 
-		memcpy(core->svc_version, data->payload, len);
-
 		core->get_version_supported = true;
 		core->resp_received = true;
 
-- 
1.7.12.4
