Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB6C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 15:47:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D43A64FB8
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 15:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43A64FB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FE77189A;
	Thu, 11 Mar 2021 16:46:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FE77189A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615477657;
	bh=tMhJWLqZZdX9/G3J2gi9Z1ldUIWuU4pPH1Y+I5BFkAM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=es3TmGVHrguyvrsfgqq/8uDZKqAJyELf6f8BZWw+sB4fkIWOZFtT8Gv1g4OO4x13D
	 nXLQugQP5c6id4saqG+qprQOebGtpELE/H6lbQu4QQMAhH/wYkOOHw3eNkDrPrOZga
	 k9GA3qj5IkyFFzeaAFv7dzgpKbvmmjzYaIf2B1HI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13EE4F8019B;
	Thu, 11 Mar 2021 16:46:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2058F80227; Thu, 11 Mar 2021 16:46:45 +0100 (CET)
Received: from z11.mailgun.us (z11.mailgun.us [104.130.96.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC331F8015B
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 16:46:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC331F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="TX0dw7Kh"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1615477595; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=1VBjwvHlfoWkZSq2NKmHy22HPNe4Qn92KKp2+bBnXqE=;
 b=TX0dw7Khqun1u2VQmtSGMyArEzdRQz4lasA/uDJ8YDkqS+qAn4H89YkjBmZdlhQ3h1rwcbpQ
 +9TpfmngaxU+yR9A66tU5tnrAkBQ6tZ8mXyhzLhjGys5nUu9rhbz7zAbHMr37fwTt6h6mjUn
 6P8Xiw0nSY7eTFpri80E4bgaZ+8=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 604a3b46b86af9bf23a45fdd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Mar 2021 15:46:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B675AC433ED; Thu, 11 Mar 2021 15:46:13 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 587C2C433CA;
 Thu, 11 Mar 2021 15:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 587C2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=srivasam@codeaurora.org
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
Subject: [PATCH v2] ASoC: qcom: lpass-cpu: Fix lpass dai ids parse
Date: Thu, 11 Mar 2021 21:15:57 +0530
Message-Id: <20210311154557.24978-1-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The max boundary check while parsing dai ids makes
sound card registration fail after common up dai ids.

Fixes: cd3484f7f138 ("ASoC: qcom: Fix broken support to MI2S TERTIARY and QUATERNARY")

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
Changes since v1:
  -- Fixes commit message chnaged.

 sound/soc/qcom/lpass-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 4762286b33fe..c62d2612e8f5 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -739,7 +739,7 @@ static void of_lpass_cpu_parse_dai_data(struct device *dev,
 
 	for_each_child_of_node(dev->of_node, node) {
 		ret = of_property_read_u32(node, "reg", &id);
-		if (ret || id < 0 || id >= data->variant->num_dai) {
+		if (ret || id < 0) {
 			dev_err(dev, "valid dai id not found: %d\n", ret);
 			continue;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

