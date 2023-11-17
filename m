Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B4C197A0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 16:18:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D07DDEB;
	Mon, 20 Nov 2023 17:17:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D07DDEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700497080;
	bh=kqWQxxaRJK2f8YuOe/bS67b+rRbkqEynPbhEKVHYlqY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TYpU61uHrYdJ9JMuP1UpT2doWBYygsjJi4KtYIBkUt3pDA5vJPFAaJ7K8qsG2NUcu
	 gQkxw/dFMowJRDGbM5tjwM8jEktavOmMpDt6uBC4SIr3Qbxxhg0wmO2+ZjmpwNKv2C
	 0Y9dr80PoBmid/QofPOmpcwfsRjgAqQ1fj/ecmPY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5032BF80568; Mon, 20 Nov 2023 17:16:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5D1EF8055B;
	Mon, 20 Nov 2023 17:16:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA488F801D5; Fri, 17 Nov 2023 21:17:54 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2667DF80093;
	Fri, 17 Nov 2023 21:17:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2667DF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=DlRNHiHM
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so3557729a12.2;
        Fri, 17 Nov 2023 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252265; x=1700857065;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mi8ISTsArPwPL7ga5yoIlC1IaD5VKkkH/FsrB8IjmmE=;
        b=DlRNHiHMhHx7m5dRB0o9XGU9gTKbbfCQSzNkt9AQh/hHraMJrzJI7zBEID6AbH5jUG
         dNATay3smoQIEMNSNFgez1znvURvVg8D3jaA70xKaRJu/IW/6PYDk/fBu4Cp48mOjy/w
         mbJuJ0w+J5zZ4kpma7G5e3ezgTCEjFoNZAzZvmLeGGOaLukqmaLh6PjsUi4jO1iumgho
         EplSr1D4m+tigF3W/YFSu2Bl+6IbyTy9jy7VpJ86lq+7f4O4t2TRsDaxWrtq5j5tYw38
         FT/5YUicog/O7BgnjdXxiQm6r6xUE+W42ATuxCOyk6YF8lmsfy8dA2HRzcNqNLjWgfCW
         AiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252265; x=1700857065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi8ISTsArPwPL7ga5yoIlC1IaD5VKkkH/FsrB8IjmmE=;
        b=beJDHK86c0Va2iZK7RaB7SPvXvIRwkHeydx4U8Xs7GcHbM503aQlJpy352UhWspuBr
         mXx0LXVU0PcFWQVfUxElsg+KOgOplPrVC6J071jsl7MEdMyjnnZe83p9yd4j8iP1z8sj
         /jGSKiVVcTQ8gL4XPTlH5ZZsMCprrxoxh/DXAYufgvyyp0mzPD6VMJBOeOnYLI8kuABx
         XaBDqrd3NYtSGOEcDO8SK3SmmdJHCcFEITH3QKGqii9LuKp1YJJC6Qcl8o1yvQrxRNEB
         6ukpjOdBpmutMezHQbFE6feaFAK30RAPCFSiWKYzoB7RFi5NsCD2Y/0Msb8sEYZWqRSr
         YWaA==
X-Gm-Message-State: AOJu0YwJej4vi4vtXQtBkPikSCUZKSWxIWLbuxDC77fIvrMT4KSaUmpq
	ZKx4s4sAv+UwVtUoLK8r6fM=
X-Google-Smtp-Source: 
 AGHT+IH77hFHX8GrcvjdUH4PXScFsQ/iLIAG2r073PEHo2aTsPknOHJfSFQ+lDSsNeobF/G4qA4rpg==
X-Received: by 2002:aa7:d409:0:b0:53e:7d60:58bb with SMTP id
 z9-20020aa7d409000000b0053e7d6058bbmr79671edq.27.1700252264798;
        Fri, 17 Nov 2023 12:17:44 -0800 (PST)
Received: from localhost.localdomain (87-206-74-243.dynamic.chello.pl.
 [87.206.74.243])
        by smtp.gmail.com with ESMTPSA id
 e10-20020a50ec8a000000b00540e894609dsm1016175edr.17.2023.11.17.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:44 -0800 (PST)
From: Kamil Duljas <kamil.duljas@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	sound-open-firmware@alsa-project.org,
	Kamil Duljas <kamil.duljas@gmail.com>
Subject: [PATCH] ASoC: SOF: acp: Add prevent against NULL
Date: Fri, 17 Nov 2023 21:16:06 +0100
Message-ID: <20231117201606.1955-2-kamil.duljas@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: kamil.duljas@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: VIBM3ISKSQK236KZFMLSMBCUKJTJZMTY
X-Message-ID-Hash: VIBM3ISKSQK236KZFMLSMBCUKJTJZMTY
X-Mailman-Approved-At: Mon, 20 Nov 2023 16:16:06 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VIBM3ISKSQK236KZFMLSMBCUKJTJZMTY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

When kasprintf function fail, then NULL is returned. The callers
dereference them without null checked.

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
---
 sound/soc/sof/amd/acp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 603ea5fc0d0d..c60a3e28b5f3 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -548,11 +548,15 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
 	if (dmi_id && dmi_id->driver_data) {
 		adata->fw_code_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-code.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
+							plat_data->fw_filename_prefix,
+							chip->name);
+		if (!adata->fw_code_bin)
+			return -ENOMEM;
 		adata->fw_data_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-data.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
+							plat_data->fw_filename_prefix,
+							chip->name);
+		if (!adata->fw_data_bin)
+			return -ENOMEM;
 		adata->signed_fw_image = dmi_id->driver_data;
 
 		dev_dbg(sdev->dev, "fw_code_bin:%s, fw_data_bin:%s\n", adata->fw_code_bin,
-- 
2.42.0.windows.2

