Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B28C3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:03:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFAF21881
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mct4HCXR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="mh3+HhRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFAF21881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 203D0169F;
	Mon,  2 Sep 2019 12:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 203D0169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567418618;
	bh=Ha2riKKiNu8yZWlVWyknZwks4d+AWnPdD9pX2lyDsRc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mct4HCXRDcusR627a3jaX+vbVJVxtf/VJNfpZLw563uAMZZRm54EvucWQbhhXzGXJ
	 N/pt8Qm/G6Jy/cMpyMPRiOENwGRHtF/KYryQhQ1luAyFDUYghrtEPcG85bVezazgVj
	 qcDjijchpxp+Pq8OKqgXOxRF6M8Nmey0/Z7Ws9Sw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5F24F80394;
	Mon,  2 Sep 2019 12:02:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 163B9F803D0; Mon,  2 Sep 2019 12:02:46 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36671F8011E
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 12:02:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36671F8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com
 header.i=@endlessm-com.20150623.gappssmtp.com header.b="mh3+HhRm"
Received: by mail-pg1-x544.google.com with SMTP id w10so7249657pgj.7
 for <alsa-devel@alsa-project.org>; Mon, 02 Sep 2019 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RQ4bgGpDe1aO2dcXCN2kWEia8kVQV/JW3GaWgKM7FYE=;
 b=mh3+HhRmMDF81+H6REGveUB1w/FITeP87l5Kn0pE/4A7ip3Z5n/gzLlKFGvZ4X1urg
 uTrpaaPPotgwE1gr0/qkMLkkEL1LFvVDQ1g6zdBYh5mNyl/iYUjoMweg1L0+Iq06FP5f
 f4Qty34vvU0ICYsKoQ6NQB2X16O+G5MR8/eRKCBB9pORO2u6OXD2bBaa+CskviGyjQRX
 D39hS8k6KY0yQtWXsycwUKfCKd28ujoMsypj9cyIrODLgCNiyce+93/An3DIAZLTGnws
 cujQTluCGz50xtILEjftm19ngvM+CNMXSRx2BuJDGhzdrOePRM8YHdbV93g9Xd4znWws
 /1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RQ4bgGpDe1aO2dcXCN2kWEia8kVQV/JW3GaWgKM7FYE=;
 b=aLCzz1TL5aoEuuqgBndqgvljv0YqNcUAyocjLHioCoCPHxC7bOHChKOeNTqmno7Y/+
 wgw1cX8lh7504dXQ6r9kzmgrI5UNHNmpEuNNJnspfmiojCWpWlDzk3h93ucoXfsEnAh9
 HH9LosbjgFDfnb6ElMtFVkIw0wgmaVUNvX9Bus7yuGGg3RfQ7zi171K5PAt0yw3F0O1Z
 CLW2QZosg2tR10BK8j65tOAwBW7+MR/5cj6PYlCFlwuDoE64vXWOkyBKLEAFygPiLBUL
 XlPIpoVn3Pcufp7tbuOO++VIX3LjEzwyW6ChUg+xQ8N1hm6c6cPqNtYg2APg2cqnMtTU
 6XWQ==
X-Gm-Message-State: APjAAAXGlf7GnFMG0sptCjHFLEtKJMQfDTiGvR4I4/4CloDOV7frsHFv
 YIGicwobMpyqMo3S0obki7+eWQ==
X-Google-Smtp-Source: APXvYqxRf34N5BEFEv8etsDj/JI3+CfZ0JnpQI+TsEcRr5YSB05J7K3rQw7oqzyvUHr981kBtMIs4g==
X-Received: by 2002:a62:2603:: with SMTP id m3mr34483187pfm.163.1567418560532; 
 Mon, 02 Sep 2019 03:02:40 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id z4sm12783932pgp.80.2019.09.02.03.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:02:40 -0700 (PDT)
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Date: Mon,  2 Sep 2019 18:00:56 +0800
Message-Id: <20190902100054.6941-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, alsa-devel@alsa-project.org,
 linux@endlessm.com, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: hda/realtek - Enable internal speaker &
	headset mic of ASUS UX431FL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Original pin node values of ASUS UX431FL with ALC294:

0x12 0xb7a60140
0x13 0x40000000
0x14 0x90170110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x90170111
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x4066852d
0x1e 0x411111f0
0x1f 0x411111f0
0x21 0x04211020

1. Has duplicated internal speakers (0x14 & 0x17) which makes the output
   route become confused. So, the output volume cannot be changed by
   setting.
2. Misses the headset mic pin node.

This patch disables the confusing speaker (NID 0x14) and enables the
headset mic (NID 0x19).

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e333b3e30e31..0a1fa99a6723 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5797,6 +5797,7 @@ enum {
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
+	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6837,6 +6838,16 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		}
 	},
+	[ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x411111f0 }, /* disable confusing internal speaker */
+			{ 0x19, 0x04a11150 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6995,6 +7006,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
