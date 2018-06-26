From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/12] ASoC: qcom: apq8096: remove redundant
	owner assignment
Date: Tue, 26 Jun 2018 10:20:14 +0100
Message-ID: <20180626092016.9296-11-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E436F2676B4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:22:34 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id l14-v6so11398431wrq.13
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:22:34 -0700 (PDT)
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

module owner is already set in platform_driver_register(), so remove this
redundant assignment.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
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
