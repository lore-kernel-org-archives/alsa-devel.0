Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02512C77B7D
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 20:53:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF7E31003;
	Wed, 10 May 2023 22:52:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF7E31003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683752005;
	bh=93lgawgCO2gOMpWhpKKpaOV53cDVxF7QwQnOJtQb0gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jEZy/FK1Y+LFhqS5nQS4HVD2yJMCF8QOj0zr4t0CgpMeZRiIi7JJq+5k36gFDjtHH
	 q9paGMKl6zCp1kAT6lxOdG0YGmxuWy+1UQb4rHKPh6RG1rlFdKYx8maFnzRH08wo2t
	 OwpM0V73GrxlS2Infx6G0OtYQUOk/eUF9a1eVNZ4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C797F805AD;
	Wed, 10 May 2023 22:50:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B666F805A8; Wed, 10 May 2023 22:50:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CF669F805A0
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 22:50:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF669F805A0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=F30MMBJ0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD6D64A32;
	Wed, 10 May 2023 20:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B480DC4339C;
	Wed, 10 May 2023 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683751809;
	bh=93lgawgCO2gOMpWhpKKpaOV53cDVxF7QwQnOJtQb0gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F30MMBJ0N9ODjnQya76KxLSs/GXj4jrzFso8CApCYPAYBLYBnWEusbyzIahmcjpZV
	 8UOmo/18qqGs4QR4AevIn0SNInSU2ZuquU2eZbJBpT1eQzg3WTlDkmGrBxKS+UsKuR
	 zGUguQjw1ilzeKdLTcUFDJIbSKMC2eNShYNTtTi3qyBLH1SwDCVqPeUsjUosEcMeKV
	 0w6+lv0TFSsrKsz4K07LxevDMtWyQ2ERvcrkLec7rTd3IfVoleJGm8qyz2DrNZzchn
	 atrOI0XzLEywNY4CdRhTSIgDGjd9IVqKxCHGavS2nX6DJdIsxfReR4DQTrEs8V4yQ9
	 K+8cy8mb9sgHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agross@kernel.org,
	andersson@kernel.org,
	yung-chuan.liao@linux.intel.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 2/4] soundwire: qcom: gracefully handle too many
 ports in DT
Date: Wed, 10 May 2023 16:50:06 -0400
Message-Id: <20230510205008.104981-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510205008.104981-1-sashal@kernel.org>
References: <20230510205008.104981-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XM433BDQVUR6SOOVDHOVPMOHSGQYDHJM
X-Message-ID-Hash: XM433BDQVUR6SOOVDHOVPMOHSGQYDHJM
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XM433BDQVUR6SOOVDHOVPMOHSGQYDHJM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 2367e0ecb498764e95cfda691ff0828f7d25f9a4 ]

There are two issues related to the number of ports coming from
Devicetree when exceeding in total QCOM_SDW_MAX_PORTS.  Both lead to
incorrect memory accesses:
1. With DTS having too big value of input or output ports, the driver,
   when copying port parameters from local/stack arrays into 'pconfig'
   array in 'struct qcom_swrm_ctrl', will iterate over their sizes.

2. If DTS also has too many parameters for these ports (e.g.
   qcom,ports-sinterval-low), the driver will overflow buffers on the
   stack when reading these properties from DTS.

Add a sanity check so incorrect DTS will not cause kernel memory
corruption.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230222144412.237832-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 500035a1fd460..e76d4cee5e7f4 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1142,6 +1142,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	ctrl->num_dout_ports = val;
 
 	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
+	if (nports > QCOM_SDW_MAX_PORTS)
+		return -EINVAL;
+
 	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
 	set_bit(0, &ctrl->dout_port_mask);
 	set_bit(0, &ctrl->din_port_mask);
-- 
2.39.2

