Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C96C27C76
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 03:21:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0087A4C;
	Thu, 26 Jan 2023 04:20:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0087A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674703259;
	bh=FfRgHL/7Dx/SVKBCkpvhzPjgwsAoVkg6PuI3GqsuH20=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=chr2kkkXt4T2YX2Rl8+smMZqFgHavgZOXj4UFdF3kYXqzW8Y9F93hds3QfbScmGFH
	 lH/fmUS6o/zpydp4nz8o9XelXZkDh/p1Q7H301JS3eYhlwxZjz9Ak7ByEbpuaB2dzp
	 nr+o/IV9VgUSQjJDuk0x0aVTJyx3FuKQCLxL6k2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB4BBF805E8;
	Thu, 26 Jan 2023 04:15:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4704F805E0; Thu, 26 Jan 2023 04:15:24 +0100 (CET)
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7438F80568
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 04:14:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7438F80568
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256
 header.s=qcdkim header.b=AomrpIU/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1674702898; x=1706238898;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=l+njOKa/UFfOWF7VK5VgFL97OAxm3R4PP9cElfezPbw=;
 b=AomrpIU/3U1DePDDKsGj8/mU7eAN2Wpm0ZbDbcoftsPC6+GAuWXKF3hk
 y6GPJu2dUyx+v73Eqnmo3bvL6uerJsBL6o7iLMZRFcY3o7juATZDc1b7E
 67OPym91uhS3Mjf+0nvd+osxm4nGY7HVjGS1/cqKoFBpTnY0JFtmTk8HF s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jan 2023 19:14:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 19:14:51 -0800
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:50 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
 <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
 <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>, <bgoswami@quicinc.com>,
 <tiwai@suse.com>, <robh+dt@kernel.org>, <agross@kernel.org>
Subject: [RFC PATCH v2 22/22] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Date: Wed, 25 Jan 2023 19:14:24 -0800
Message-ID: <20230126031424.14582-23-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
 quic_jackp@quicinc.com, quic_plai@quicinc.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add an example on enabling of USB offload for the Q6DSP.  The routing can
be done by the mixer, which can pass the multimedia stream to the USB
backend.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 .../devicetree/bindings/sound/qcom,sm8250.yaml      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 70080d04ddc9..60cd84e6727a 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -216,6 +216,19 @@ examples:
                 sound-dai = <&vamacro 0>;
             };
         };
+
+        usb-dai-link {
+            link-name = "USB Playback";
+            cpu {
+                sound-dai = <&q6afedai USB_RX>;
+            };
+            codec {
+                sound-dai = <&usbdai USB_RX>;
+            };
+            platform {
+                sound-dai = <&q6routing>;
+            };
+        };
     };
 
   - |
