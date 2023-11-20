Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D46C197A0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 16:20:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3337E94;
	Mon, 20 Nov 2023 17:19:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3337E94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700497222;
	bh=Ye49npAxr44QVuf9KCJ/XizEuwkFoxOH9c0SK9WHHic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ggtt80I6TggnugXC1SJbQZygKcLgxRhuCfQjBRB9B41fNNsItQd+tNygKyefMPG9F
	 tVYHpGbLqw+kNZ5A1bSivFZkG6CtoPLhWvzHCkjDzibO7gUZT/WBBt+uGHDeKApEbd
	 /+5nONMyCDmyrl2FhKUOervHpaxqqEaBTuAT0UWg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89A75F80563; Mon, 20 Nov 2023 17:17:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8917F80563;
	Mon, 20 Nov 2023 17:17:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8368AF80580; Mon, 20 Nov 2023 09:19:01 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B89C9F8057E
	for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2023 09:18:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B89C9F8057E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=YoT6gagd
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9f26ee4a6e5so549110766b.2
        for <alsa-devel@alsa-project.org>;
 Mon, 20 Nov 2023 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700468332; x=1701073132;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAFgiTdwpGDvtNPEo9+dnVRad4u3rIMlxH/kmiggZYk=;
        b=YoT6gagdqqh4nQwXuTwdbQmWvFv8OatHFh3LMb2gDrRccQyLCVsIKEL5IqjUrw1F85
         uqrucfRVKILqV4b4MDscZLd2qTrSwryHTLpqjzO+dd8fpxqTEDoyb8718DEYM8p3deKL
         4/HiTkRGYaQjj7ktnJqrv2bNVZQZYsYOyibA+wI8QGPy0VO79YAgTGpnhFnPn27R6+2s
         rP/p0D2vaA2WKJNj7e646FMwX7S+VoYwE9fSF5gqh+I+qKlBglYRvLylwlYoxAN3pfjp
         MBd/q2Zvh3uyeHGp+IYflfcV/avmZwBtk6zjCMEGHXy6mJ8w9pv7NoBXjoEZkUGsxG5m
         q9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468332; x=1701073132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAFgiTdwpGDvtNPEo9+dnVRad4u3rIMlxH/kmiggZYk=;
        b=bw/fyeJ2LtqcJZB8fpctf1EIq4vpULc77yvUs7v79KJa3jE6HrAefejnUJu5RhUPXu
         X8f4tJUFGjya/rBJOQoPfP6f64xMQPZXphLd/vt+FS/Q/O0rtOMaq64lxVt7eM0kJqvu
         orPhsMwkCnHqcmZc+3DEWiZdouEoGoYghNEPMyM6Pq4kiXAz5Nzt/FkO3hT8nqw6EnrP
         89XLreOPuxP8up+yYlKOXJWZ94T980feJWC5YeqINpUBcVQF1Fd3pjec+UGfnOXZJW9/
         4Rfhn+aUPOZxJtT27qEuKhED+vF4Fng2OuPSiGuOR2OpVoKu+TnJP6LpxUpHaYkuzWfw
         st9g==
X-Gm-Message-State: AOJu0YzaQFIy8yCLCaTwOg+281TkznxOR3AKHgEl8CmHiHlua4g90rDx
	dpt6rXkSKabXmQJnZ7me+Wg=
X-Google-Smtp-Source: 
 AGHT+IGiIKcBWwRL/o09TJmoMPMNMyfT63u4veXE5630FRGEbdy6Jh0jHuro+96Puv48MGhGeKgRzQ==
X-Received: by 2002:a17:906:5357:b0:9bf:30e8:5bf9 with SMTP id
 j23-20020a170906535700b009bf30e85bf9mr4603272ejo.4.1700468331949;
        Mon, 20 Nov 2023 00:18:51 -0800 (PST)
Received: from t14s.fritz.box
 (p200300d38f2bca00f021423dbbbc0b9b.dip0.t-ipconnect.de.
 [2003:d3:8f2b:ca00:f021:423d:bbbc:b9b])
        by smtp.googlemail.com with ESMTPSA id
 k18-20020a1709065fd200b009ff8be60791sm355806ejv.210.2023.11.20.00.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:18:51 -0800 (PST)
From: Oliver Sieber <ollisieber@gmail.com>
To: bagasdotme@gmail.com
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	ollisieber@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	tiwai@suse.de
Subject: [PATCH] Subject: ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad
 T14s Gen 2
Date: Mon, 20 Nov 2023 09:18:34 +0100
Message-Id: <20231120081834.125555-1-ollisieber@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZVoS13B2Br9U8mvu@archie.me>
References: <ZVoS13B2Br9U8mvu@archie.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ollisieber@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YPSNDWUVBVNWVHJS2ZHGPJOU4VHB2CKF
X-Message-ID-Hash: YPSNDWUVBVNWVHJS2ZHGPJOU4VHB2CKF
X-Mailman-Approved-At: Mon, 20 Nov 2023 16:17:15 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YPSNDWUVBVNWVHJS2ZHGPJOU4VHB2CKF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ThinkPad T14s Gen 2 latop does not have the internal digital
microphone connected to the AMD's ACP bridge, but it's advertised
via BIOS. The internal microphone is connected to the HDA codec.

Use DMI to block the microphone PCM device for this platform.

Signed-off-by: Oliver Sieber <ollisieber@gmail.com>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index b3812b70f5f9..754e24d55e6f 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id rn_acp_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20NLCTO1WW"),
 		}
 	},
+	{
+		/* Lenovo ThinkPad T14s Gen 2 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20XGS1KT02"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1

