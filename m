From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/11] ASoC: qcom: apq8096: remove redundant
	owner assignment
Date: Mon, 25 Jun 2018 15:31:14 +0100
Message-ID: <20180625143115.8346-11-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E55B267819
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 16:33:58 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id c5-v6so2767883wrs.10
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 07:33:58 -0700 (PDT)
In-Reply-To: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

module owner is already set in platform_driver_register(), so remove this
redundant assignment.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 561cd429e6f2..6e79fec7e789 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -245,7 +245,6 @@ static struct platform_driver msm_snd_apq8096_driver = {
 	.remove = apq8096_platform_remove,
 	.driver = {
 		.name = "msm-snd-apq8096",
-		.owner = THIS_MODULE,
 		.of_match_table = msm_snd_apq8096_dt_match,
 	},
 };
-- 
2.16.2
