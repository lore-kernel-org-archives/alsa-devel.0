Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D93DC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 12:01:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961F364FE0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 12:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961F364FE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 306D4170B;
	Fri, 12 Mar 2021 13:00:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 306D4170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615550499;
	bh=6ITnr6YV1EJivEskxNPgBOT9I7p10oDELFPOmR/XixI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mdMUpxATqj340kjMF6xLlYGao1ore+iziZLB/z0KApUQtvyC2bkgyBq5mUN5l9Vbl
	 L5sj0lGUDp1spqhfQ0ONggnb9ikjxPliaZ1xgXf0lYLKQqeQOsk+i7hQbMKJB7n5Jj
	 o36a7RGRtvhmEmpVF5EOmekOhxOD/o5XpgNKjE2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3385BF8020D;
	Fri, 12 Mar 2021 13:00:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3922F80272; Fri, 12 Mar 2021 13:00:39 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29379F801ED
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 13:00:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29379F801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="SsCoXK0S"
Received: by mail-wr1-x42a.google.com with SMTP id w11so4634499wrr.10
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j1DVrtDjiNfpMvwpqyQlbpz2bqVmuofXtsZIJDWEwa0=;
 b=SsCoXK0SqP0VUwLVdEmtmSTcvDgX8/74fLxQMnWyD7ZTwKchBMev4r9vaO08c0mVVp
 gYoHGT0OA/Vu0WXUMuBU5+W0uAGX4Xq/L/Tj/AmPJhVAJzgEHvD8d5ddokosquklWarE
 xUfpA/R+p0fY3DkdSn7g4PhM6EA220jfY5T7lpng1KZI7kRUpchcDjZ9LWhZTN9XhRoP
 HkCNgyevql9QEg3yaurq/S76tdyqGd2KrxR/pUFJqEIJlk5hPj+2iWvTg8JzWGz3EKmK
 KHbeT5q+mvuXjKKSTwGqHPUtAOot0c9X2Ai8YWYJPo3UVd7wNwlOCM2jbZSxoxYSUHN+
 TvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j1DVrtDjiNfpMvwpqyQlbpz2bqVmuofXtsZIJDWEwa0=;
 b=EsvL95RtE22WtnNrwuM0vAfZn6AfHPJBovyLBF2ed4wAWUI97zpXNqZS0PLn08Zo1H
 d2PFcF/htl9iaMbP4lTI8hEI+9VvS7tAzKdTUUappog0HtBOlfkCK8XNrqJVUFDr8lTc
 nPeuCc9k//2WUgMwhCLxFqWHORhtt2BPNclhAs6ubAORS196WJ/kQWPela4eJp2f/FIi
 UUIVsddDwB0/YT9Kgl5OJlEgp2gmwgKF/LMCUUB/RGSYMDlRtMYzZLOSTNQ6hry8H+Ce
 T0zbBoBFWUsxRFRt52JOH62+GFr8DIQTJZaA+ElQJiKSvwJ5bXZDYqowYI4e5Y2oWOXQ
 gnNA==
X-Gm-Message-State: AOAM532eBwlzLUaDnXxZIvH+ObzxS13i30wZprWAc2OIIZxjQjwrL1N9
 EjM6ply/FlmI15k+G94lwsqBNg==
X-Google-Smtp-Source: ABdhPJyahixTlJ4FldSgjHcTPFpCWEc0DOYzPjLjbKhEbXXiKjqBXT9G4mHhurytCqMKiYC9lJbrLg==
X-Received: by 2002:adf:f4ce:: with SMTP id h14mr13589603wrp.257.1615550424486; 
 Fri, 12 Mar 2021 04:00:24 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 04:00:23 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v4 1/9] dt-bindings: soundwire: qcom: clarify data port bus
 parameters
Date: Fri, 12 Mar 2021 12:00:01 +0000
Message-Id: <20210312120009.22386-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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

Some of the parameters for data ports are not applicable or not implemented
in IP. So mark them as invalid/not applicable in DT so that controller is
aware of this.

Add comment to these bindings to provide more clarity on the values!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/soundwire/qcom,sdw.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
index b104be131235..b93a2b3e029d 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
+++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
@@ -54,6 +54,8 @@ board specific bus parameters.
 	Value type: <prop-encoded-array>
 	Definition: should specify payload transport window offset1 of each
 		    data port. Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-offset2:
@@ -61,6 +63,8 @@ board specific bus parameters.
 	Value type: <prop-encoded-array>
 	Definition: should specify payload transport window offset2 of each
 		    data port. Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-sinterval-low:
@@ -69,12 +73,16 @@ board specific bus parameters.
 	Definition: should be sample interval low of each data port.
 		    Out ports followed by In ports. Used for Sample Interval
 		    calculation.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-word-length:
 	Usage: optional
 	Value type: <prop-encoded-array>
 	Definition: should be size of payload channel sample.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-block-pack-mode:
@@ -84,6 +92,8 @@ board specific bus parameters.
 		    0 to indicate Blocks are per Channel
 		    1 to indicate Blocks are per Port.
 		    Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-block-group-count:
@@ -92,6 +102,8 @@ board specific bus parameters.
 	Definition: should be in range 1 to 4 to indicate how many sample
 		    intervals are combined into a payload.
 		    Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-lane-control:
@@ -100,6 +112,8 @@ board specific bus parameters.
 	Definition: should be in range 0 to 7 to identify which	data lane
 		    the data port uses.
 		    Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-hstart:
@@ -109,6 +123,8 @@ board specific bus parameters.
 		    SoundWire Frame, i.e. left edge of the Transport sub-frame
 		    for each port. Values between 0 and 15 are valid.
 		    Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,ports-hstop:
@@ -118,6 +134,8 @@ board specific bus parameters.
 		    SoundWire Frame, i.e. the right edge of the Transport
 		    sub-frame for each port. Values between 0 and 15 are valid.
 		    Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 - qcom,dports-type:
@@ -128,6 +146,8 @@ board specific bus parameters.
 		    1 for simple ports
 		    2 for full port
 		    Out ports followed by In ports.
+		    Value of 0xFF indicates that this option is not implemented
+		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
 Note:
-- 
2.21.0

