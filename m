From: Mark Brown <broonie@kernel.org>
Subject: Applied "soc: qcom: apr: fix invalid msg_type check"
	to the asoc tree
Date: Thu, 17 May 2018 18:12:49 +0100 (BST)
Message-ID: <20180517171249.8B9FB44007C@finisterre.ee.mobilebroadband>
References: <20180517160353.27561-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 21A332675CD
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 19:12:52 +0200 (CEST)
In-Reply-To: <20180517160353.27561-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, agross@codeaurora.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   soc: qcom: apr: fix invalid msg_type check

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

>From e744619d056e6ec5cd9db38e55511a22dc463f89 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 17 May 2018 17:03:53 +0100
Subject: [PATCH] soc: qcom: apr: fix invalid msg_type check

Removed invalid msg_type check.
This also fixes below static checker warning:
apr.c:95:35: warning: comparison is always true due to limited range of
 data type [-Wtype-limits]
warn: always true condition '(msg_type != 69864) => (0-u16max != 69864)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/soc/qcom/apr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 97f3622da535..57af8a537332 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -92,7 +92,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 	}
 
 	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
-	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
+	if (msg_type >= APR_MSG_TYPE_MAX) {
 		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
 		return -EINVAL;
 	}
-- 
2.17.0
