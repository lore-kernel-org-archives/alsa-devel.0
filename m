Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB54FF8FA71
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41284601E7;
	Tue, 21 Apr 2026 14:55:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41284601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776776148;
	bh=ilTd8G6rGzWSYiPXW0gzw/K+PrTHWdJYsdsOd+dPDUs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vaRyx8L1lfVZzxSfA85gDdvujY+htiHwVx50nrzhcaKRtclWByMVoUX1vPEl1ae/V
	 6YfwBqzHOpeDj5LhtkRUFZPJWgm9Avm8UzvxNIjSuIJige328FAcHWwCnuDTqMTN8O
	 xTRPnvzlL3sE4S9O7cQUClUQfemL657pWPZjcT8A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 134DBF80612; Tue, 21 Apr 2026 14:55:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53CABF8060A;
	Tue, 21 Apr 2026 14:55:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16BE9F8055A; Tue, 21 Apr 2026 10:50:00 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B4368F800AE
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2026 10:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4368F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NHZiEBf1
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488b150559bso31023435e9.1
        for <alsa-devel@alsa-project.org>;
 Tue, 21 Apr 2026 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761394; x=1777366194;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n++iIdotMt6CGRY5H4br6XbDJigW7PJuq4uyuIolAg=;
        b=NHZiEBf1xCw6KitTk1+O+KUKp/B7BljtEgYnJq1D+XU6O/SMoNz/EWLln0gFGWYLQZ
         aC+qGbWOcTPCJ6z83g7M+pOD2oVnp1Rf3MBcR5j7dTZNQSKOQxotSf3pWQSp86QvVAwm
         w0LlsxzLtznZURejGRh0NMcfDdLHF9KidGh/Nu7ALpQnqjgkcxw8kx8KXPk7q/Hc6dau
         c6rnXgQ3NCagvI35Pn6Zd0dbK9ae4CLop3c1sDmsZ93y36NyebxTLTn87jGQBH3cKOOG
         iPFqLyBVPzNxJ1Trek0BsLJYq54UFlh9hQd73IXA8rKrIqmK4EUMXFHYd2e61iyIc3QS
         +pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761394; x=1777366194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n++iIdotMt6CGRY5H4br6XbDJigW7PJuq4uyuIolAg=;
        b=VxH/TeDLnjJfKJ82tyFHo5ntUeGtp5aA5TIFSLYl/xDb9ONm/q2nhuqYFjTlmZ8H0Z
         +3M/ouZTox1GCglQMHJHigGQz2FyWPqBAYKdD0Ypt2zUXqMPeOgUEjPBnd/049Bt+4SA
         VW+/Cnrd9T2dyJ7yATnApovugeJ1JLfbGTs+r7NWI+VqMTfYYYc8g/x+m/o/9DR0ADhI
         WmDuzyojus5yu5FSsw/zvyDTxMbWTZWfjWPO7wzjrVQNuxlqtzlBKN5YoEquVAKJ5/bQ
         zpn7hgk0221rmdOZ2/2STig4Xe4N93Y2+N6JIUkyASQVAShib9OcLTKNn8wC6rjYY4JW
         utvw==
X-Gm-Message-State: AOJu0YxpN0w8OLADHdNzz6tXvbtYGnBzW61pv89wKQ39fXGGXrwUjAob
	+S8jSHXnWaEgvmcU9GYOK1LNtNMlBia3/u6lIhrFRlV6U8clhqS6DirrE0s5n5s/BX0=
X-Gm-Gg: AeBDieswA+M3VkNI0oY88690UUWKBHksevHEWioO2F3Kq38slbIyMDaypdrt+slrSHx
	4Hgzl20ftKt+97zxtiMZMjYVhYdlOW+70riEv7FaeUwh+AEsuNOdVZXcCXTpuNcnQFWKBOgytQr
	TKVtXPUVuX2w78EOh9UI104TGi3yec3DsopGZIpXhVqZwN6n7Hsn2Ir/YNI6a9Qdv/erXGPmvYw
	wGnvwJGyzhcK3OaPGaN8WU15ESRnEnPpDOVpgpFQ6x4M80PECDMuXtCE+pCBzKfv9JEwKeA6aYn
	aLUneO4dBCXYT+myhf8XEUZoOmpilHusch7hkl1fRjuIeuGVfFWO05nMIr1yYUVTjC5MluxlFbV
	6sqUdPYbIKSsBpRbFIdNx5dTccBBGa1IDZ2AU8dAB1HyB1Y1fos/wbJK/5EppptrXEiOHOl3xcp
	nFNt13od8kQKtblFBVeHVCrOKhoCK5qNjIxPQWgslcHVPfgZ2oB74+X4DYMks2CLB8UxJZ7vCHd
	u82FbwibHsLDMPZv/V/eWuZ
X-Received: by 2002:a05:600c:c10a:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-488fb771613mr189503025e9.18.1776761394058;
        Tue, 21 Apr 2026 01:49:54 -0700 (PDT)
Received: from Friday (dsl-197-245-177-193.voxdsl.co.za. [197.245.177.193])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c68asm110715915e9.3.2026.04.21.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:49:53 -0700 (PDT)
From: Spencer Payton <spayton681@gmail.com>
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Spencer Payton <spayton681@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus
 15-fa2xxx
Date: Tue, 21 Apr 2026 10:49:18 +0200
Message-ID: <20260421084918.14685-1-spayton681@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: spayton681@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: D7UTMU2BLDLSLDZN2U4DZRAN6IASZKCC
X-Message-ID-Hash: D7UTMU2BLDLSLDZN2U4DZRAN6IASZKCC
X-Mailman-Approved-At: Tue, 21 Apr 2026 12:54:57 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D7UTMU2BLDLSLDZN2U4DZRAN6IASZKCC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The mute LED on this laptop uses ALC245 but requires a quirk to work.
This patch enables the existing ALC245_FIXUP_HP_MUTE_LED_COEFBIT
quirk for the device.

Tested my Victus 15-fa2xxx (PCI SSID 103c:8dcd).
The LED behaviour works as intended.

Cc: stable@vger.kernel.org
Signed-off-by: Spencer Payton <spayton681@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 4b6266536..98f218844 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7154,6 +7154,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0

