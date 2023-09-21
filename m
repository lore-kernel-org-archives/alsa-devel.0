Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35482E7106D
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 13:28:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B444886;
	Thu, 21 Sep 2023 15:27:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B444886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695302911;
	bh=n/fADfeKoZIjZhq0aIRCr68VMxyyHfjxw3zHT+/cyZ8=;
	h=Date:To:Cc:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=m/Y/L381UiBePwIKq/sxZ2OkQffouZmKUYrkBlU3TSVAXKImbrkpdQPY4Ax+e9tOq
	 gyO0/bW+C0ZEFcEekCYtW/AWMrroclvuW4alFgkIWen2aWJ2BYtkupCKN0AwNRL9wL
	 3jU8vsHq40ORGbLlfWPBuHj/XmXatPtyjBkZcwnQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD755F80634; Thu, 21 Sep 2023 15:24:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DCB9F80630;
	Thu, 21 Sep 2023 15:24:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1222BF8025A; Thu, 21 Sep 2023 09:23:05 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5B5EF800AA
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 09:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5B5EF800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=UuDdrCvJ
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c0179f9043so9305061fa.1
        for <alsa-devel@alsa-project.org>;
 Thu, 21 Sep 2023 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695280981; x=1695885781;
 darn=alsa-project.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/fADfeKoZIjZhq0aIRCr68VMxyyHfjxw3zHT+/cyZ8=;
        b=UuDdrCvJOgesopQdJaXcVwtQShxVS9yv4s97BcCiriL4EhJQyolm07B4N5fFW/r6TQ
         IBzOLtiT+whIQDI2qdNlJR5TbD2jMPF02JJ9zihpCxFUnuZCrpbDn21EFOCoeZY1+irn
         TFoGamlGHIPpvkVMhS1Ifa8gQjLI9j1gsesT8+5eZu4HhmxEe7OBUo9zmQBCErae1ZYY
         G8F+K6cSWA0H5JFFs99N89zXK3KSv4YDaIrmd+mtIROBd+rBASjRMGirWd8LgEQCmOBz
         WMsU5s0uwWKkb1iAJLglegjPCZAVzFyT7Wfz7dS9nJNjBxPkDbDTEAScjlzCEhoWGeWa
         7S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695280981; x=1695885781;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n/fADfeKoZIjZhq0aIRCr68VMxyyHfjxw3zHT+/cyZ8=;
        b=ddIqrGxXrWBiCqIoCEyuQKQYDE5M+kIq0LmPHWqyneTDLorRjh0zLSVYmyWHfdAehU
         9+nAqhahl/MLzYvV8HerSghnJCT2fuGfpINwc0j2dHV/cBLgZdMDK4yknni1ThWZD5qt
         lkRvyx8NDIsS4hg31wfQk5rfSVF+K5ikQCN3HYhx0n7llbSIaRYzAx96gdoVY3bFpEaD
         Y5j0MS66JHTbpeNYEnBClBxFpwbq+YcXTafJUOfRL76yQZlHrEwmFw1Kq8C0zahHMpmL
         AWJziqv1oBaD93FzCYA8zQTB9x2bTS+w2oFS3Zl7VSxWusCKSihKWOjoMIRzhoErX7py
         TU7w==
X-Gm-Message-State: AOJu0YyWjcHSCnQaZ9GXBQhpb9pmf8XIxpDT2vMVg+3cDdx/lesqnZFE
	iif6wYyy63sNcCGLSQRmcZM=
X-Google-Smtp-Source: 
 AGHT+IHI5dM0C9xgNsHyQUlP9jSIJIyxu5ITX4hMYw6AAv/xSIdGQZzyKD3dZWpgRE4MfEYw2I5Fow==
X-Received: by 2002:a2e:9b8a:0:b0:2be:54b4:ff87 with SMTP id
 z10-20020a2e9b8a000000b002be54b4ff87mr3963948lji.40.1695280980822;
        Thu, 21 Sep 2023 00:23:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:7c80:b060::49? ([2600:1700:7c80:b060::49])
        by smtp.gmail.com with ESMTPSA id
 f13-20020a2ea0cd000000b002c029a4b681sm203240ljm.15.2023.09.21.00.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:23:00 -0700 (PDT)
Message-ID: <2436e7f2-b986-4dda-9d4d-0f73845c1ffc@gmail.com>
Date: Thu, 21 Sep 2023 03:22:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
From: Abelardo Ricart <aricart@gmail.com>
Subject: [PATCHv3] ALSA: hda/realtek: Add quirk for ASUS ROG G533Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: aricart@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 5YOT46OZJCALMWHSQWHKIDXTFBSBGZFZ
X-Message-ID-Hash: 5YOT46OZJCALMWHSQWHKIDXTFBSBGZFZ
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:24:01 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5YOT46OZJCALMWHSQWHKIDXTFBSBGZFZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The same quirk applied to the ASUS G533Z is also applicable to the ASUS
G533Q (of which I am an owner and have thus tested).

Signed-off-by: Abelardo Ricart <aricart@gmail.com>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc7b7a407638..fdc3560ad951 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9649,6 +9649,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
     SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
     SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
     SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+    SND_PCI_QUIRK(0x1043, 0x1602, "ASUS ROG Strix G15 (G533Q)", ALC285_FIXUP_ASUS_G533Z_PINS),
     SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
     SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
     SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),

