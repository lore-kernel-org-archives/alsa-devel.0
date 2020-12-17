Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED153C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 16:31:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8710239EE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 16:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8710239EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EFFE1941;
	Thu, 17 Dec 2020 17:30:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EFFE1941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608222674;
	bh=gURtfj7Nomx5Rd/VJJ/RgQSbyibCEkvIZdmyU49eSQI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YRjbZRwbrC41ugbzWLEqkO7VWk4njq2NqAlQkmhGOAaFxXZEl1Smo+gWOhoFKEeRV
	 eu/dNOejcqHo8V9v3ihh6YR5ZeoIjkXc+64y/aFy5x54OBMq/HdmUKmI9o4fkmBbIO
	 EkgjxcRlGCltHALWlJ/1lNVfEqUZ1XilB2UzMLsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2056BF8028B;
	Thu, 17 Dec 2020 17:29:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6D45F80260; Thu, 17 Dec 2020 17:28:06 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D70FF800C7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 17:27:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D70FF800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="tIiDpTuJ"
Received: by mail-il1-x129.google.com with SMTP id 75so14318379ilv.13
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 08:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DqaDdh80Jc1X6em3g1sQbEFqj9BR18AP205Qoq6HnvQ=;
 b=tIiDpTuJUZPZzRuoSNxcEPMns83IKTVDMFVatIG6cEzvgpI9TGROx8mKgey/PdLUvF
 q9ySr5AgJKnk2ePIfS9NC1Wbci3eqxUW34HmeQrCEd+bb6T48DMLxizg1Tq+sDP/G/7I
 rNRqTFi/0iW797CYfh4tw5wIwIuvmIrBOQjZJe8WkiGYJLRJDHBseC8LkqvRX+zx/Miq
 hi1g8aDu6ikI7ehLZa1esCx+scEfjz/WE8AOKgkK+L+lSBDXK17HQcbzAp1mfDnvuT3Y
 p995VwDnMUXD7H3aVEdtcDPqIziy6Cd2C1AXa2xRgXH37JkjjRGpwqrvBDFp5ewboE1W
 X6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DqaDdh80Jc1X6em3g1sQbEFqj9BR18AP205Qoq6HnvQ=;
 b=P4Yd3A/pnyBl6V1AdAAV+NdrWnOMpKdzHXjtYhQfuqfWceGYnZp+WbdiWEF6zshnWy
 llYmIhUysXf9fR8oRvUJCopx9XoSo1ohPgGNdY7K+VENeaSCqjfsZOZsKAltgmAJ6/Ie
 sdGjF7TYWmjIvk9T0cwHd54UryOsR8twSV2sCSlAaxXpE8BTSUlpISEZAKLbD4KaJOw5
 u6Ybl0lVt7dSbMgltPmq2G5rSbtySireWifxm72NQU6Y6PsXEOQ6eOEQCbung/tJDlaL
 CYm9oAfXrqLmOv2b8xmu4hpoJC21ZYI3nSsQIqhF4BTI17UwN15yMJoH1s0cFVZqR/h6
 /Ufw==
X-Gm-Message-State: AOAM533GjWIhccgVDZ2mCr604ucDyNquwS8h+/wyOVKkORaiz2kASRg1
 uK/xDt3PEvmDWwiNeUGhnLp7sZmhCZQMrw==
X-Google-Smtp-Source: ABdhPJx4ygJHmJS4lU4rhhfgBUhLOTH4vOjx/1K+DgCxR3OuwVOeTbo1edMUcENQmcdfJeqDcYgd2A==
X-Received: by 2002:a05:6e02:4ae:: with SMTP id
 e14mr48619070ils.132.1608222475876; 
 Thu, 17 Dec 2020 08:27:55 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan
 ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
 by smtp.gmail.com with ESMTPSA id y14sm3416240ilb.66.2020.12.17.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Dec 2020 08:27:55 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
Date: Thu, 17 Dec 2020 10:27:40 -0600
Message-Id: <20201217162740.1452000-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Dec 2020 17:29:50 +0100
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Adam Ford <aford173@gmail.com>
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

The driver can request an optional clock for mclk.
Update the txt file to reflect this.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
index dcfa9a3369fd..c36c649ddfd0 100644
--- a/Documentation/devicetree/bindings/sound/wm8962.txt
+++ b/Documentation/devicetree/bindings/sound/wm8962.txt
@@ -9,6 +9,9 @@ Required properties:
   - reg : the I2C address of the device.
 
 Optional properties:
+
+  - clocks : The clock source of the mclk
+
   - spk-mono: This is a boolean property. If present, the SPK_MONO bit
     of R51 (Class D Control 2) gets set, indicating that the speaker is
     in mono mode.
@@ -27,6 +30,7 @@ Example:
 wm8962: codec@1a {
 	compatible = "wlf,wm8962";
 	reg = <0x1a>;
+	clocks = <&clks IMX6QDL_CLK_CKO>;
 
 	gpio-cfg = <
 		0x0000 /* 0:Default */
-- 
2.25.1

