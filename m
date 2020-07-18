Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E62C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:35:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0B72073A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kIscPfPN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiDMLnCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0B72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CE0E14E;
	Mon, 20 Jul 2020 09:34:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CE0E14E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595230503;
	bh=1CewVLm+s7fVMdPViHyCrFuChEZ4jWUHKWZXpgJiBhU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kIscPfPN33j7UuP3M6s8Be64X86T560b7tWYS7DqtaEVwy6klrOfyN5cqqkVsAZz9
	 cmNCedx1+8PD484fdqJS+QaUdvoCmAuoTZ1rT/SO+c1B1weSYRLEFRVJmRync4vJ49
	 SxV7The0Elng4w7nct9E3EbVACXCNfSihZvGJx2g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40412F800E0;
	Mon, 20 Jul 2020 09:34:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCF21F8016F; Sat, 18 Jul 2020 10:23:34 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0A71F800E4
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2020 10:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0A71F800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iiDMLnCD"
Received: by mail-io1-xd41.google.com with SMTP id y2so12776965ioy.3
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2020 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ShK2sOMMXq7aexBMQlQxFYtGN5Ev3tTcy8uw8HQjVb0=;
 b=iiDMLnCDMyvdxaWdQmtg32xcbj2Laauw8YsimO1YHyJTqhm9iU/s7Yy0HWK9yF7WNG
 8FU54ScbxECoKloE+s53hrJ17olTrVLrH8v2qIyqu4+iG1GUJETyuUYrMMY4ZmgEzJGm
 43XuSRIK7Yi9yKH1dnO/+40DQCr0G+JZzkdiWwHD3nImNUuu7WnQyhnDAqQ2S2mm7Hqp
 ZRpjLWElLt0enSA2KLVsrzWIV4Gb1FPaQagfQ8rnqLZ+TBKlUoSq3tZ30Nly04W8iwUJ
 YSLJ+nufV7LNbye1s7VF49eHzCKJ+nVN76bZbszVHA+UsV5Q5J4QkAHerS3VEJcg2ppd
 7n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ShK2sOMMXq7aexBMQlQxFYtGN5Ev3tTcy8uw8HQjVb0=;
 b=OdQ17IHD/GMf3yTxAzJ3xZ31tNVPJxyeYKXSRxSd3v6tu1pJgFM33/Vnj12Rjb8mzQ
 5kg9xV+HDJsfJd2r8YYl5XMjDezI1q36EIbXZireMYGUx7V0Se4oT/ZWznXDPyJgBQ4Q
 cyxnd8F+uyCtFuaX/qhsWoTunUMDUlY3IdiilGurUcW4vi5iyXpwofnI4er2lKlOUeuv
 xKnUDKUTBBOWOUc9L3NjLafx59ysMVM/0I7gwavEgIushgiCKmBfgv1CqiA68EZHdNCL
 e23WI+b1Sp+SnccQdg00umMEJ6Wky+QyQQQCwWxaAVDzVEB+9GDiWDdOH5IzX2c+c/i+
 JgWA==
X-Gm-Message-State: AOAM531Ju+JhnJ5sG6CLUh78lKgqcUSpswQym8ohgxGLvkLW/MljTnVC
 6+RMk/LSFAtiVa+rOcudYl3l4ZAT5lto7d8L/fM=
X-Google-Smtp-Source: ABdhPJw8qWBve6tMh8Sg4KzR05Sj9YkVvZhMBq7KO08H6VUt4IlKL7kkBeQflkSqa5kpa6+dmwoIA8CKQv8Eyi5IF1A=
X-Received: by 2002:a5d:9503:: with SMTP id d3mr138251iom.154.1595060606673;
 Sat, 18 Jul 2020 01:23:26 -0700 (PDT)
MIME-Version: 1.0
From: Junar Wohn <doomsheart@gmail.com>
Date: Sat, 18 Jul 2020 17:23:15 +0900
Message-ID: <CAHcbMh291aWDKiWSZoxXB4-Eru6OYRwGA4AVEdCZeYmVLo5ZxQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fixed ALC298 sound bug by adding quirk for
 Samsung Notebook Pen S
To: tiwai@suse.com, Junar Wohn <doomsheart@gmail.com>
X-Mailman-Approved-At: Mon, 20 Jul 2020 09:34:10 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org
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

Fixed no headphone sound bug on laptop Samsung Notebook Pen S
(950SBE-951SBE), by using existing patch in Linus' tree, commit
14425f1f521f (ALSA: hda/realtek: Add quirk for Samsung Notebook).
This laptop uses the same ALC298 but different subsystem id 0x144dc812.
I added SND_PCI_QUIRK at sound/pci/hda/patch_realtek.c

Signed-off-by: Joonho Wohn <doomsheart@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 737ef82a75fd..ebedc6093642 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7528,6 +7528,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
= {
  SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)",
ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
  SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)",
ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
  SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)",
ALC269_FIXUP_ATIV_BOOK_8),
+ SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)",
ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
  SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807",
ALC283_FIXUP_HEADSET_MIC),
  SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120",
ALC283_FIXUP_HEADSET_MIC),
  SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)",
ALC283_FIXUP_HEADSET_MIC),
--
