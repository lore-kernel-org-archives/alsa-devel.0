Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70689C47073
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 18:53:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 791BFE8F;
	Tue,  2 Jan 2024 19:53:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 791BFE8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704221598;
	bh=1dKzfhSr0CkeYd/UyHB3RHH2+v2IWxDCV4low4xwrLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hQ7NTqVW36vF5wpjcAi1/tBymANJBmG4iDythbCEAL0NBMhKaL9eKkGKls4yT4a3b
	 l4wUVy5Se2///zRz5vA3owxIJVinyOHg+v/jbL9Nq+IIp4ecWjd2lYjmGkMArLiVrk
	 8f/HDpMkHzCgvyNht0HMemF3+TujiOFsRE1IgnW0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 263CCF806A3; Tue,  2 Jan 2024 19:50:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D730EF8069C;
	Tue,  2 Jan 2024 19:50:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA575F80431; Wed, 20 Dec 2023 08:38:34 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 419E2F800D2
	for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2023 08:38:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 419E2F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=ir9WHqoN
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-553ba2f0c8fso676872a12.1
        for <alsa-devel@alsa-project.org>;
 Tue, 19 Dec 2023 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057892; x=1703662692;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHyUbHVpES213ODZcnBd6hLrNU+I64lailKfIQRqxos=;
        b=ir9WHqoN2kHYMuUHOQ5/I502OpjLBQCtWkwwUoVpVu94qn3bWvKSaY5yoKDHFE8pKE
         bkUPwnQfioU4IloUa08YQeysmhhOfIwRQIufNPA4+msXsQK+1G9VD/a13cp0lOeRgDRe
         wVG2ADiKvKy2Ykkldm6MVlNqJwSsV85/CnN9Wi8jQGxKgHT5Zcxpsv+Vd+uC4waX37Sb
         CvDK+pLxOVH10N5EBtHQk/61+55ZUzDGAqtDdZjA6t5qZbOT0co7O9XxwRYyQe14rhRN
         eJMwLV655PR2JwKZPWMknMNR7vP/xZ1Dbs05hqXvmE/cM60BkZL6aZ1W1LGDpTv87ISO
         EFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057892; x=1703662692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHyUbHVpES213ODZcnBd6hLrNU+I64lailKfIQRqxos=;
        b=NFZPKl0ECiGk6GvvfGwz0lvAZJ3WKJOMSPL6RSlXONkSTdsMym8MdI+9JN7xNhZvwQ
         Ou79WMsDKQpHFI6YyGcbnvyDeLeFpOY6F14eW4JZMbbnjNDk6UOfN2bnAQdpoRNjL+yD
         /nXY/yZcQueNuFIrW2ly5hGrtmmTNmkbSPHuRw/EZYAqAASAzaGA/eo6O/7FU+bSTTbK
         uSjko+bd7J+O36/xU2D4KPQLAvLX7KAgkJRC/w2jHHqdjBiwfRvF7wU2hqrR9jC4qFzT
         pqWypopFWXmgA00wgSs1Pf+Z1NPEAUetUv5Y9tFJy1ixorDEywqdkLSdDht8IDvRK+4e
         Dsgg==
X-Gm-Message-State: AOJu0YzyG/EUNYfq9KSSLcgYYPgBuTpu3uFaxbtMZepN+9O8GBZugo4b
	4YB4isET3982lSDu/er0IQ==
X-Google-Smtp-Source: 
 AGHT+IFq8fykuywISDMznNtD+bwpovn1I9rqNtzdYNP/Iv9ilU/ky9etGWkivuriBSkpv49QUETGbg==
X-Received: by 2002:a50:8753:0:b0:553:3354:297f with SMTP id
 19-20020a508753000000b005533354297fmr1542463edv.59.1703057892157;
        Tue, 19 Dec 2023 23:38:12 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch.
 [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id
 p7-20020a056402500700b0055283720ec3sm5979043eda.76.2023.12.19.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:38:11 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: tiwai@suse.de
Cc: alex.vinarskis@gmail.com,
	alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	josbeir@gmail.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	stuarth@opensource.cirrus.com,
	tiwai@suse.com
Subject: [PATCH v2 2/2] ALSA: hda: cs35l41: Support Dell XPS 9530 (2023)
Date: Wed, 20 Dec 2023 08:38:09 +0100
Message-Id: <20231220073809.22027-3-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220073809.22027-1-alex.vinarskis@gmail.com>
References: <87ttokpyws.wl-tiwai@suse.de>
 <20231220073809.22027-1-alex.vinarskis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: alex.vinarskis@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HEI4EYSZFVV4IMRXMXFVCIIWHSTP5X6V
X-Message-ID-Hash: HEI4EYSZFVV4IMRXMXFVCIIWHSTP5X6V
X-Mailman-Approved-At: Mon, 01 Jan 2024 13:16:44 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HEI4EYSZFVV4IMRXMXFVCIIWHSTP5X6V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add new model entries into configuration table.

Co-developed-by: Jasper Smet <josbeir@gmail.com>
Signed-off-by: Jasper Smet <josbeir@gmail.com>
Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index cb305b093311..ee105743333f 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -41,6 +41,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
  * Since this laptop has valid ACPI, we do not need to handle cs-gpios, since that already exists
  * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
  */
+	{ "10280BEB", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
 	{ "104312AF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -355,6 +356,7 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", "10280BEB", generic_dsd_config },
 	{ "CSC3551", "103C89C6", generic_dsd_config },
 	{ "CSC3551", "104312AF", generic_dsd_config },
 	{ "CSC3551", "10431433", generic_dsd_config },
-- 
2.40.1

