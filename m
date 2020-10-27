Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4432BC4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:38:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8760A207BB
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B0dCA+lU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHWmTg6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8760A207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9916316DF;
	Tue, 27 Oct 2020 19:37:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9916316DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603823877;
	bh=Ue8qZnMFUZeo20dwZRs7/u0dyXcxW17dx1xrato0Uuw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0dCA+lU8AMXcuzQiau3R234H1FCPURDt+n1VmUEypzQbJ7Pqm2PuRVMiMsEnaR8Q
	 Kfz6O5XOSdukC6E7OW0BeWDlyHCSjT/X8vZTyeu+iD+vsz9xYXNYr71M+8bhip+1Qx
	 Ggg8YDHkDaUtrwKMTnCGDrPPUSoErAhZeH3N6hPk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40C79F8051E;
	Tue, 27 Oct 2020 19:32:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4B7EF804F1; Tue, 27 Oct 2020 19:32:23 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 929BDF804C1
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 19:32:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 929BDF804C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="KHWmTg6i"
Received: by mail-wr1-x442.google.com with SMTP id n18so3047394wrs.5
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
 b=KHWmTg6iNDzrUklwwoPUYeB3JIWWDKo+WfE3xEOm21ijBsMHfDp0aI6XXbDtue4XaH
 yF0uAVTb/N3UE0kxVcoNUSQePrz1qUYCgERhqUVFas+4XWL00P9Hmtu9HqBv5R4oVP+j
 c0quqR5yhlruMZ1kqMBRXJrD3WZ91qofkjITlAPNS3FBjTiT9ERLIdTTJ1YBcGnRdNfw
 L4sBfxOFuTEqxkMidOBmwJFJZXxEHsghsrEsS5BpZbSp2CNXNzHcG3rR9gLEvd8k3hGd
 N1yNXHh/yq0neAeDIT8ponfii5LZjEWnjSjHBfMCLEgYqbPpmXKyoyPuEN5vAiA5+glm
 PG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
 b=E6TuEtI8BU461l/oxoY1bGIYlvf1f/HsveIkMJXmXhGZ/+3e/RI79hBjhLy+K32dbm
 loTincnmmG3quiqejkmokFH7JjfBXvLz0313ey1PXqVpspqQzLCYezdpN0a7imW4bwPU
 JQPtGpYzJh9eps6RmfIcuPoQ8na3i80EdU8qZcbEytvXPML3/GnLbRVuAhuE2XykNRtn
 ckTVSP40zWTehXYHYBnxXvHa6/Zq1IZtiU+8j8DDEamGrDBpd6/TRR3KeXfOdzdTFJ47
 mQxPJ7Rlh7/Jn4l8RvqEBP3jyEvJlU2NWeO6E5VD42WKKF7vI7lOV0eoaUorsOKorQpZ
 qLZw==
X-Gm-Message-State: AOAM532QFeKTtolv4qhuZM5+mvui91A1tYFSOLljThEIk5fPuoBbtKTf
 aZebLanh0wyPAk9QbXva/dk=
X-Google-Smtp-Source: ABdhPJxafdY3wzwsE3nWndD8a+Tz8AuK8P+cxxtLyIH8fPdH/CbdGOoBaBsh/wxXO/+pPitC+UGQmQ==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr4120044wrj.195.1603823526969; 
 Tue, 27 Oct 2020 11:32:06 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 11:32:06 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v9 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with
 missing RX channel possibility
Date: Tue, 27 Oct 2020 19:31:48 +0100
Message-Id: <20201027183149.145165-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

Like A83T the Allwinner H3 doesn't have the DMA reception available for
some audio interfaces.

As it's already documented for A83T convert this to an enum and add the H3
interface.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 606ad2d884a8..a16e37b01e1d 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -70,7 +70,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun8i-a83t-i2s
+            enum:
+              - allwinner,sun8i-a83t-i2s
+              - allwinner,sun8i-h3-i2s
 
     then:
       properties:
-- 
2.25.1

