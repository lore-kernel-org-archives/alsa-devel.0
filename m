Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B91C27C4F
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:51:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CF50B60;
	Thu, 13 Jun 2024 17:51:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CF50B60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718293893;
	bh=SrwrcA8EO/kpCKyL39XjnsPTrNdBE58a73YIeAazdTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cwJ+hwMnuhQOhfcWQ9bhF0BITHgPYm9L+2fqSMN4ggdHcBuI7tTF5BuCGAX7K/C7z
	 /5GmeU2RvQcIDqn7NwxXJc2RtLpAvxMNvYoEHL3004rX4NviOV4cQHwILEJfZsUn/p
	 zCyU/c8ZU0j4nt1998qbxAvJoBQ0bX4Tm4RguEi0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 687F9F805DA; Thu, 13 Jun 2024 17:50:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4FF3F805E5;
	Thu, 13 Jun 2024 17:50:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EC9AF8051F; Sat, 25 May 2024 15:30:58 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD6E0F801F5
	for <alsa-devel@alsa-project.org>; Sat, 25 May 2024 15:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD6E0F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Qa9aQHmK
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f466so1659292a12.1
        for <alsa-devel@alsa-project.org>;
 Sat, 25 May 2024 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716643692; x=1717248492;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BndYTHAhfTKZPUuhsQObxrH+e5h7zSrDvT6UBM9kSxU=;
        b=Qa9aQHmKq3Dy9BmAfxhrUK3q9auLSWmqz/0k3FEzw87NwU4HxvUkQTAx1OK1jP3dYz
         7nD7G82SxGk6Op9N+jkrZ/egT58dJbppPUHUlu6WD9rHugHCjnpvaz9bQrQ1EleCzM4y
         wRXVhgdSsbTdC/Q2iVAxXiQTRiPMyEfQ4wiSQekuqUJDZDCZEKeLVi47BQLBYy7YO63T
         3PzDr20r222x7EWnxrEYq4bub4OyWX00GHUJ9/6sSy+nnBE+e4NRdUtJxOGfvVZaMlSe
         /3KwWZ0Mo4nnkI2/IjvAJ4O8gXqsAJRhbBz5B9IK0H7bAs3R9Yf2g75P55jf2nzAztg+
         THcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716643692; x=1717248492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BndYTHAhfTKZPUuhsQObxrH+e5h7zSrDvT6UBM9kSxU=;
        b=jwJK18z91ocwRuzkl0bhk0loy20ZUcoQOQngyvo2X6Pdi0klOWV8rNuEuXp/fgpyqA
         5KvJvOciD9tsyNEiSYLtO0oVrfpoDuZkD4i9YHjSuvlIqPnedpqSHN0/utIvh0qIsO7n
         hfnne5Sv4Q3/phuHLxzyweQNGC6wFkyktc4idQFJb4bC4qpamdNtFv4Or4SBq8o6SCiY
         jzJusTrtYmWfZTEABXdo9iIA82um5XwwKMsVyxpwYOvgLCWqKbwJHJiSrOFvUfZVK3J9
         5XfYC2lgv2slMb8TyVe4Fgw2Cgdkj8JHRkBYrwUlO1dRudj7Nk6WhkV2mOoc1AsoW6IH
         j/6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN1JZ/nAKqH0D3dhz5D3g0HMTECEiXp8PqkwskAcLWtE+fjaJGz5Y68psEV0Vx0klH8HjchlYLWY/VcaFHpR85pCHMzDY8GLo0AJc=
X-Gm-Message-State: AOJu0Yw3JADcVSPpS1u74yGxR9vOh/doQLP1MzK96UNFhUTgwWoye91I
	w46sPPrRDbp+0mm7+VKJPYCHNxFOI0tDV/njizwZ8GuXtZ6zO+yc
X-Google-Smtp-Source: 
 AGHT+IGnZd7WsivKWQF4T7VRJoyzWWWhjF8m2C3S/hvrEcSGj7gVML/vaSsvg/m9ubAfv5dSHplv5A==
X-Received: by 2002:a17:906:34c4:b0:a5d:1079:ae43 with SMTP id
 a640c23a62f3a-a62646cff2bmr303714966b.46.1716643691879;
        Sat, 25 May 2024 06:28:11 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl.
 [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda46e1sm251842566b.196.2024.05.25.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 06:28:11 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 25 May 2024 15:28:08 +0200
Subject: [PATCH v4 4/9] ASoC: samsung: midas_wm1811: Add headset mic bias
 supply support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-midas-wm1811-gpio-jack-v4-4-f488e03bd8c7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716643685; l=1496;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=SrwrcA8EO/kpCKyL39XjnsPTrNdBE58a73YIeAazdTE=;
 b=aOb+rU2suanKpvf9j7yJWCC8tRfhD79vM2VGE9vwAf3aAdab1HBw88AGPfMZzkzES4TSFtHuM
 6DZtzJEPYveCOX4cpcoNbmRXsBVqaoVegYq+563CTSs9fB2kR85Cl6t
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-MailFrom: aweber.kernel@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: BVN6TAOGGPEH6SZXLYPSIBVQ26PPJRUO
X-Message-ID-Hash: BVN6TAOGGPEH6SZXLYPSIBVQ26PPJRUO
X-Mailman-Approved-At: Thu, 13 Jun 2024 15:50:36 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVN6TAOGGPEH6SZXLYPSIBVQ26PPJRUO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some devices use a headset mic bias supply (sometimes referred to as
"ear mic bias") to enable/disable the headset mic.

Add a REGULATOR_SUPPLY widget for this supply which gets the headset-
mic-bias supply and is routed to the Headset Mic switch similar to how
it's done for the other mic bias regulators.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Completely changed to adapt to SND_SOC_DAPM_REGULATOR_SUPPLY switch
Changes in v2:
- Added this commit
---
 sound/soc/samsung/midas_wm1811.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 20b274734487..96cec8e9de98 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -237,6 +237,7 @@ static const struct snd_soc_dapm_widget midas_dapm_widgets[] = {
 
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("headset-mic-bias", 0, 0),
 	SND_SOC_DAPM_MIC("Main Mic", NULL),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("mic-bias", 0, 0),
 	SND_SOC_DAPM_MIC("Sub Mic", NULL),
@@ -248,6 +249,7 @@ static const struct snd_soc_dapm_route midas_dapm_routes[] = {
 	/* Bind microphones with their respective regulator supplies */
 	{"Main Mic", NULL, "mic-bias"},
 	{"Sub Mic", NULL, "submic-bias"},
+	{"Headset Mic", NULL, "headset-mic-bias"},
 };
 
 static int midas_set_bias_level(struct snd_soc_card *card,

-- 
2.45.1

