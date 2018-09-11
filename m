From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: q6core: Use kmemdup to replace kzalloc
	+ memcpy" to the asoc tree
Date: Tue, 11 Sep 2018 12:15:01 +0100 (BST)
Message-ID: <20180911111501.636F51121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 555D6267795
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:15:03 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: q6core: Use kmemdup to replace kzalloc + memcpy

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 18fbe800e6066050ab6ae7751708da04975cdc22 Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang@huawei.com>
Date: Sat, 8 Sep 2018 16:36:19 +0800
Subject: [PATCH] ASoC: q6core: Use kmemdup to replace kzalloc + memcpy

kmemdup has implemented the function that kzalloc() + memcpy() will
do. and we prefer to use the kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index 06f03a5fe9bd..ca1be7305524 100644
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
2.19.0.rc2
