Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49C5C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Apr 2022 10:11:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CC511843;
	Wed, 13 Apr 2022 12:10:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CC511843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649844686;
	bh=X8bb90Rr2e2M+IL3QWRI4Jt/d89GL5Hur1ZM+Y65XAM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vQHg/+zbE5ORVsPFFvoj2I64zQlxnHgTscpFRJur2TFiBRYJ1FfkdaZdPWBUrvF65
	 OxNcaF/gOifxxuW1wOnkuYjC2vfqd952ONWrCTkKQSZCfEq8d3UxZWwlC/VtTs/ohh
	 BZY6hT8tBsWRw2aILjuYG0l8PqjG7Cxq3wk2HN4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB1CBF80095;
	Wed, 13 Apr 2022 12:10:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B9CEF80248; Wed, 13 Apr 2022 12:10:34 +0200 (CEST)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8515F80095
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2022 12:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8515F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="q336GL8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649844629; x=1681380629;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=mXEo1vMbCQhz7IIKv1PA2DXOYacKulksQjxVdLQuTL8=;
 b=q336GL8/hmgFlDGu2RENbXMN+fjGAWFDjJVz3CBNiKty8ciln+S+g3f/
 a+0HWLx+FVIVk48o9PyqzUFziYHvNxGcp9b3hPsvBStm4ZHeu3bBJ54+/
 WoZ3tRTlw8tV3IMIi+cvoWMVC1EUmn5eZp1PaK6N0OCtSc43hT5Pp7Odb Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
 by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 03:10:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 03:10:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 03:10:22 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 03:10:16 -0700
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To: <agross@kernel.org>, <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>, 
 <broonie@kernel.org>, <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
 <bgoswami@codeaurora.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <swboyd@chromium.org>, <judyhsiao@chromium.org>
Subject: [PATCH] ASoC: qcom: lpass-platform: Update memremap flag to
 MEMREMAP_WC
Date: Wed, 13 Apr 2022 15:39:56 +0530
Message-ID: <1649844596-5264-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

Update memremap flag from MEMREMAP_WT to MEMREMAP_WC for better
performance.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a7c677f..2590d65 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -1160,7 +1160,7 @@ static int lpass_platform_prealloc_cdc_dma_buffer(struct snd_soc_component *comp
 		break;
 	}
 
-	buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WT);
+	buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WC);
 
 	return 0;
 }
-- 
2.7.4

