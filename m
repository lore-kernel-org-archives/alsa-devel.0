Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F43FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 07:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74FE20671
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 07:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HxlgCz9S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vU6CM3mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74FE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 323041607;
	Fri, 15 May 2020 09:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 323041607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589526520;
	bh=bAT/o3wh1Q11NCH7shjvPoqrCJGFpPFKWyyriBusprU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HxlgCz9SZfDHol7eKqmyqkhT5KbkISMbp/OkmbqUM/3EC+hdXhnCGH1TOkwVLZePn
	 PR/UV4tgR2pYuWbocZZAU+ICGsACEv0CsKf0FEBopmhVzpGab5l6bdORUWayIwT4eC
	 dHWldVFOQrzhGYOL7d1PuBsdlQg6XDLA3rbxmm74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8F9EF8022D;
	Fri, 15 May 2020 09:07:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81E69F80247; Fri, 15 May 2020 09:07:48 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CAA3F800E3
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 09:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CAA3F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="vU6CM3mu"
Received: by mail-pl1-x641.google.com with SMTP id t7so576531plr.0
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=M7hX/J76tBtL7VRebaHJrw9xmZRzEx8WmpLsqjkC1B4=;
 b=vU6CM3mun5/XIqHsnKuxhXN5MylGXPGNRiXohIC9XPH62/E0+oScClKAlhhdoACQMj
 BjUjhvgW/ebKfPRMW4RYeYyaIU9XZdnFbRqMSKH+uzdl/J6xxrkLi4nj/HUVKqPKPHjC
 ALWTTQOEuzQ0dScjO0gQYKo9tHZfP9muBFZQ3KTtgB4SsvbtQlgCtv1LXb/opOzEetcJ
 QRQhFt2j1+eXJz7nqzZ7UjonlmYlWsNS/YendGw6inJJlF7VMsSd65H0to+xRhDb7BG7
 irhIkur3UQJQIBz3+T0O6knb0dpMaHdZ9e9HJfhetw2cTnRXAog2dzj+U7iJh+tFEVto
 m9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M7hX/J76tBtL7VRebaHJrw9xmZRzEx8WmpLsqjkC1B4=;
 b=p+AmCZ6HlSfyIK9SUnO+yEZkOrQe3UISLdDwrjK3TRyGRMBGISY5FtnqnYIhD+dyd2
 Uat73E8eNsLaL9MHg6Tp5KDQ4vQw+oKAUX2wytR/E2GjuU/pVRIWV3OWNUJj1Ji16Jiu
 1VP/lCTplHQVdXQmZRcPTgS/Er3ToGcOtsb1xPfMAn5kCNfr/f8n+N/71HdsJpu1uYXU
 YALL2torAxMx+eQ8PhWOLkVE5dPvfjGxPn8nrUTcoiTuZbCb9mzB3XaZfZgCkqKnDS8U
 Pg44dABKwEmSxQGC4d5v8Y8xO+/a8GoCBh63C88VBcpmxyzGERY9gdVhhBMFPZp8tSna
 AOPA==
X-Gm-Message-State: AOAM531Iui1hNEJd6q+7c2qqAAJo8tX2noii7qL2DTyQtcT9HMQ71Ue5
 SPSNu/zbAbk4pxY3x1YcT5wfqqs4
X-Google-Smtp-Source: ABdhPJwXZtIr/mXUcf/FXQH02w4WrWzvrLMq+bbqeL4qm+DMH7iqUNEYKh7qJ4BVzN1fNmiewnNSHg==
X-Received: by 2002:a17:90a:a402:: with SMTP id
 y2mr1853709pjp.24.1589526455357; 
 Fri, 15 May 2020 00:07:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:2d8:e99a:364e:d5fe:3ea6:5791:c8e8])
 by smtp.gmail.com with ESMTPSA id c124sm1062656pfb.187.2020.05.15.00.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 00:07:34 -0700 (PDT)
From: Steve Lee <steves.lee.maxim@gmail.com>
X-Google-Original-From: Steve Lee <steves.lee@maximintegrated.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [V5 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date: Fri, 15 May 2020 16:07:01 +0900
Message-Id: <20200515070701.14102-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Cc: ryan.lee.maxim@gmail.com, steves.lee@maximintegrated.com,
 ryans.lee@maximintegrated.com, steves.lee.maxim@gmail.com
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

Add documentation for DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---


Changed since V4:
	* No changes.
Changed since V3:
	* No changes.
Changed since V2:
	* No changes.
Changed since V1:
	* Modified sample text in example

 .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt

diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
new file mode 100644
index 000000000000..0ddd4c6ae55e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98390.txt
@@ -0,0 +1,26 @@
+Maxim Integrated MAX98390 Speaker Amplifier
+
+This device supports I2C.
+
+Required properties:
+
+ - compatible : "maxim,max98390"
+
+ - reg : the I2C address of the device.
+
+Optional properties:
+
+- maxim,temperature_calib
+  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
+
+- maxim,r0_calib
+  u32. This is r0 calibration data which was measured in factory mode.
+
+Example:
+
+codec: max98390@38 {
+	compatible = "maxim,max98390";
+	reg = <0x38>;
+	maxim,temperature_calib = <1024>;
+	maxim,r0_calib = <100232>;
+};
-- 
2.17.1

