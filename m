From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] ASoC: qcom: Fix uninitialized symbol
	warning.
Date: Thu, 31 Mar 2016 19:23:14 +0100
Message-ID: <1459448595-18620-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459448595-18620-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id BD314266742
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 20:23:22 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id 20so124443492wmh.1
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 11:23:22 -0700 (PDT)
In-Reply-To: <1459448595-18620-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, kwestfie@codeaurora.org
Cc: plai@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

This patch fixes following static checker warning, by initializing the
ret to -EINVAL, as one of the code path in lpass_platform_pcm_new()
uses this variable uninitialized.

sound/soc/qcom/lpass-platform.c:555 lpass_platform_pcm_new()
error: uninitialized symbol 'ret'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- Split the patch into two as suggested by Mark.

 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 6e86654..f5cae01 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -474,7 +474,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret;
+	int ret = -EINVAL;
 	struct lpass_pcm_data *data;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
-- 
2.5.0
