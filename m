Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB738C27C4F
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:53:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5775DBC0;
	Thu, 13 Jun 2024 17:53:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5775DBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718294015;
	bh=KcCxSAxMvDkXt904XYa6/SbZmduZSxVRxErNI/Om7zM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uRDllrF29N50unlCT/rTLmYJghrBV0eKk7JjGwLuypRXLj/T4UA4dAhZ8eEZsNJIs
	 jmaoBKamxpc0cz4y0JoY/kHJbpeLxaC3HY3oyE7pxcjHSPCovgijeznJg9wtCJMv8g
	 oVLWZVtQyXFG/uyEV9pZ2LuZYrRdCWFVjEslEB9w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EBAFF805B1; Thu, 13 Jun 2024 17:51:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A20AF806FA;
	Thu, 13 Jun 2024 17:51:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E492F801F5; Sat, 25 May 2024 15:32:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8FDBF8020D
	for <alsa-devel@alsa-project.org>; Sat, 25 May 2024 15:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8FDBF8020D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Ohn1rKkR
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6267639e86so204499966b.2
        for <alsa-devel@alsa-project.org>;
 Sat, 25 May 2024 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716643688; x=1717248488;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMTEq8/81TXzUfHAT3yRUVR+6g/j7Gm/Znm9RLjIAhg=;
        b=Ohn1rKkRskyOxuo6S9C6a314U7NDE+gC4tWJFufFihAFRrSF3ixf3qPFKwdm7fxg91
         497kzuJ1Lz7RGJlh6qSTr3cpj1r2FP5xcwPaQh1JSPBUSQf2ptfi8VoNr9B7IfjgupJL
         GBVoqGZnrf3IEY6imoxpjXByo5/id2QvnFX7uDGqRIfivt9/eb7BW3q7IAh3hvxd2PCk
         sDB3+6a/O0eg46dAzUSIR216wZSeYNQTtd7TB+pxpWDO3xUVzNvhukICZRdmmQ9nrvHw
         Gg9c51IhWrZEbf6KEDHyQmtjrt7fap8ViuxISWckORHtNweqRFrKZfam2ckZOz1+L1jZ
         xXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716643688; x=1717248488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMTEq8/81TXzUfHAT3yRUVR+6g/j7Gm/Znm9RLjIAhg=;
        b=MQ3UpucsFYtZbHvz1Bi/xmUy9FQmsiNcX+26nVslzhywZbxPoHM0U25K0wLByNQXzU
         ufAL38H9Qcbi2pNl3iUYFl7vTR2fOnhYecXtuIMXccXLxMvBdoZ4uUYftTMzC+Ir5pLE
         gdjIDNuGJwM9NAsFDg4oToEvjJ9Xv3CUaDmb5T+6JCiB01TMZUWLM0lJrE4STcnQ9zA/
         SIxGgIDTXZUkwYZB4pz+trV3MDe8XVNFG/7Cs7fsunp6bsr78wOa7SzUnCHF4/DjtPX0
         nHDzXSlQco+Qq7MlP95VQfgYOn1JtTBgkE738HoIhanpPLwIho7HQ4v/BNW399l+286l
         uE0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvAqP0vcc2NmqduSRlnPHlUwx2nc8+lrnvj6L2sz5UB6BFlLL7A1+/VhJ8vhh+KtHgXUYmOum8GdAg0dCrDjBjzkpveYdvQv8uJxE=
X-Gm-Message-State: AOJu0YxP8uRf9V7ti8+CuAuQF6P4Sk7EGyuWczcwTE9v/ihoEAB1JnvH
	048P5PE93sWEhRworEpbziVvxxzBVOlppXvbaUnPRJSWjzjwxV1O
X-Google-Smtp-Source: 
 AGHT+IFnN0alOg81y3ApkSMx/NppMuYvffZFNlVbN94bNUUJGBOlukHxGi7dQOIDZEZnNR+iOrPy4g==
X-Received: by 2002:a17:906:e2d9:b0:a5a:c194:b53d with SMTP id
 a640c23a62f3a-a62645d6c0dmr338273766b.20.1716643687998;
        Sat, 25 May 2024 06:28:07 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl.
 [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda46e1sm251842566b.196.2024.05.25.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 06:28:07 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 25 May 2024 15:28:05 +0200
Subject: [PATCH v4 1/9] ASoC: dt-bindings: samsung,midas-audio: Add headset
 mic bias supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-midas-wm1811-gpio-jack-v4-1-f488e03bd8c7@gmail.com>
References: <20240525-midas-wm1811-gpio-jack-v4-0-f488e03bd8c7@gmail.com>
In-Reply-To: <20240525-midas-wm1811-gpio-jack-v4-0-f488e03bd8c7@gmail.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716643685; l=1024;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=KcCxSAxMvDkXt904XYa6/SbZmduZSxVRxErNI/Om7zM=;
 b=a8ffLr0BQKc3Mzr1ZH8qlfYzy+cz2DGscrTaCLSE6p59apseaVUutkgI3r1MbdZ60rLEp+h4Q
 zzO93Snks1kAD9Ic+jkeVqx657Cohmx+VeeSF36c4iKWSsDOm9PaIBY
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-MailFrom: aweber.kernel@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: QAX2WHEFGSHUM3XH4DKBY2LBKKKQMD2X
X-Message-ID-Hash: QAX2WHEFGSHUM3XH4DKBY2LBKKKQMD2X
X-Mailman-Approved-At: Thu, 13 Jun 2024 15:51:03 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QAX2WHEFGSHUM3XH4DKBY2LBKKKQMD2X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some devices use a separate mic bias supply (also referred to as
"ear mic bias") to enable/disable the headset mic.

Add the DT property headset-mic-bias-supply to allow for specifying
this supply.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
index 6ec80f529d84..6ed53dd0bb53 100644
--- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
@@ -53,6 +53,9 @@ properties:
   submic-bias-supply:
     description: Supply for the micbias on the Sub microphone
 
+  headset-mic-bias-supply:
+    description: Supply for the micbias on the Headset microphone
+
   fm-sel-gpios:
     maxItems: 1
     description: GPIO pin for FM selection

-- 
2.45.1

