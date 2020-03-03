Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763DC3F2D1
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:38:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E7120842
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hT2khNDm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs2wtgU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E7120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FAB0167A;
	Tue,  3 Mar 2020 16:37:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FAB0167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583249895;
	bh=pxufw6znpUXIv6jZUx+JZVJl+r6m9h8JiiFpo5lPnxI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hT2khNDm1ALvQ2v4xcf2YviicP+YFMbfiSfy/O7gtugEmJLcR5fJoXIlHnPqUqcVj
	 /zjvRl8DXap/D0kYXSff79/wKN4vGJwyQw3vTTvtSKkRvZERqd7+I+Kt3LxiGTaeQ0
	 V4pEXsTf4mJx+YqC2+85LlBw7HbJpp5e47iU8mi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED0E3F80266;
	Tue,  3 Mar 2020 16:36:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 295E7F8025F; Tue,  3 Mar 2020 16:36:30 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0AEFF8011C
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 16:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0AEFF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Bs2wtgU4"
Received: by mail-wr1-x442.google.com with SMTP id h9so3946282wrr.10
 for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2020 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JcrMrcr18C9BvF7z9tdmIPfuQXb50JBD+U+5ocXJjHw=;
 b=Bs2wtgU4jAt7IUITsVgTBY7+8x2xD+/U/WMFNrYZFcY02kP+w9oNOdjHGH9UULECMv
 hfd9shjggWI4MdljtDCJb+XF9MUOAeazms2kde3BvIf+3CtBkLv2x4LSM0jo+x4wCkxx
 HekAOmTg4SPnwa3S4T8RcGWa4p/RHr8ojje0UjGFnrI4EBaUEG30yMy78zlnBj6huwgV
 a+jAgvYa3SfgvCyaEoT6XvdHSGlAzbc5oV4klsYLVyHcjn2g0Rua2AS7wr/Vni8B8laS
 mJUUGzY6JCNqWvi2kTEDQAV6y5sT6ZX78jtxQ7Aevm8XBRkLByqM2Te9kznXqSCk+FJE
 UpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JcrMrcr18C9BvF7z9tdmIPfuQXb50JBD+U+5ocXJjHw=;
 b=nNKxlJehLo3OtOs7nR3eINFOhYsaJbLAO8yL/kihDMSVxdycdbR1HKGDrs8LQ8MDl+
 XQeko9JTTEWKbk2tKf9xUb1QayuAqViBeum4DYti2hTDsTCVDSSaoUL26SKAT0wRuY5i
 DOt6BKTRRat/t3HWaQsc3CzkjNYnt3K7XkEToy5qSDWcMrx1ZZ+UB6AJWnsguJQmTul8
 3BcpBdMRNqrdmeP/DXAJrD0Wys5JB5XH6D/JVOEDaVCd6CVpLio4WZVqQ/CaJpzgMSLg
 n4B3Zx5p3F8hoiwkcTQx0Zc+UgQvXh4E5WxiVkQWJWgKPSdnxN0htAbwW9GKB+s1pCE7
 q/gA==
X-Gm-Message-State: ANhLgQ0MdoTm9Luvv32JIGEnpcqN4Wv5/OSCXPtpbsZYPIGOLfWRezhK
 Ff6gHV1y4cnuFDMaxKwWVs0=
X-Google-Smtp-Source: ADFU+vtGoI/mzPs0ynrsF7uDds5DfI6X5RtIeDU79XDyRUfO5NXsknUOwCjbB2kpWpbc0tQQ2LFkmA==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr5729401wru.136.1583249785571; 
 Tue, 03 Mar 2020 07:36:25 -0800 (PST)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at.
 [84.114.134.91])
 by smtp.gmail.com with ESMTPSA id n8sm32836331wrm.46.2020.03.03.07.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:36:25 -0800 (PST)
From: Christian Lachner <gladiac@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com
Subject: [PATCH v2 1/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570
 Aorus Master
Date: Tue,  3 Mar 2020 16:36:19 +0100
Message-Id: <20200303153619.24720-2-gladiac@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303153619.24720-1-gladiac@gmail.com>
References: <20200303153619.24720-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christian Lachner <gladiac@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

The Gigabyte X570 Aorus Master motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. Set up a quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 477589e7ec1d..8722616c6cc6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2447,6 +2447,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
-- 
2.25.1

