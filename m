Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D709C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jun 2022 05:58:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46C6017D6;
	Wed,  8 Jun 2022 07:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46C6017D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654667904;
	bh=hbOOnYDg9fEFeCwruQXXRuEsh0rxFRJvfhCZpghDEmI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=okxAlB16fTWEJ4OQYUCNPbzuRXcnu1lPKXY7dLigksgYEXPXteRuNu5B/+vfmbgtT
	 YlWxl4i+pt0anCBV/BE02crkom8/pLDD8H+YLidfhcoQAHOfQzRfvbGRBIGfwgqVSa
	 t/z4RhSvTFYWwOZI93rB8FBUoJ95sDIDFBHjAzMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9368F80116;
	Wed,  8 Jun 2022 07:57:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 150D7F8024C; Wed,  8 Jun 2022 07:57:32 +0200 (CEST)
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 484FEF80116
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2022 07:57:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 484FEF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="tlzO2lzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1654667850; x=1686203850;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=7/c9yjEpm0QP/PuEQyVQXV8LuDzF1qmG2vO2z5UKT+o=;
 b=tlzO2lzwvoxW2t0q5k6SmIPEmjDB3eyDD0aWf8LJzYn3VfaoPFBV9LTA
 hsAkpnp27ZwiNVarYhInMSQ196X9qUUmThaH+E5mKo0lsYBTYHtux0wBF
 vQiCGcHm3OusKGf7mZWKDWQLHYCrEl/CWCLflfX3wag/g2jVFw0u/bo98 I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jun 2022 22:57:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2022 22:57:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 22:57:25 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 22:57:18 -0700
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To: <agross@kernel.org>, <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>, 
 <broonie@kernel.org>, <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
 <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <swboyd@chromium.org>, <judyhsiao@chromium.org>, <vkoul@kernel.org>
Subject: [PATCH v2 0/2] Add software clock gating requirement check
Date: Wed, 8 Jun 2022 11:27:02 +0530
Message-ID: <1654667824-3760-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

This patch set is to add software clock gating requirement check

Changes Since V1:
	-- Fix if check before reset control call
	
Srinivasa Rao Mandadapu (2):
  soundwire: qcom: Add flag for software clock gating check
  ASoC: qcom: soundwire: Add software clock gating requirement check

 drivers/soundwire/qcom.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.7.4

