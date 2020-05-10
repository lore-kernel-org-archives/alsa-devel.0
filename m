Return-Path: <SRS0=BytJ=6Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66438C54E8A
	for <alsa-devel@archiver.kernel.org>; Sun, 10 May 2020 08:24:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FBC208DB
	for <alsa-devel@archiver.kernel.org>; Sun, 10 May 2020 08:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FcBPo4xg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0l7prVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FBC208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5427B1669;
	Sun, 10 May 2020 10:23:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5427B1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589099070;
	bh=5mwyLAzLbW9lyIeOent45cFKnslKjeKhNipgqHn5G7w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FcBPo4xg4IQ88oaZZ5QkCNkPxgjDKulMKwi6Ci62GSqPeemAej2ze4RH2it/n72Q9
	 e/7UZX/IqMLNPmuQRpJGN+idtddCXssP3xVqjMgWmmF9wOczBCWGiNBfNK+RCgjmK2
	 5cc+OnX3VCoR68eJMR6g3mo/y/99AheGkBDSDWRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD56F80292;
	Sun, 10 May 2020 10:21:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A022F80158; Sun, 10 May 2020 05:32:02 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B7A7F800BF
 for <alsa-devel@alsa-project.org>; Sun, 10 May 2020 05:31:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B7A7F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="t0l7prVw"
Received: by mail-pf1-x441.google.com with SMTP id v63so3046408pfb.10
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2020 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4f/clxlilFuIydMRrGudVTp6YYwPxAbh7kCsQ3vkYa8=;
 b=t0l7prVwlEnbr1oApHJznJ8IXBo7EqYNw5LC/qWeeEiUUt/f1TQArV2Py/kzCmpfMh
 BYIpg9VZtjNgm+4uZLo+3coQ3s4gHezzhe9iQv418IqZDIWf+uP91Y2XQMjAAnpSLii1
 lEfOoeStisezK+epg2fvwCR7+joJ/m8aA3xmmPr0RLXBcW++aLzt/HpO4kyVjAzswoc3
 mEcdVE3exs77C4AHMuB+eHS1wRKDLgeCM49fvLQrijIVkSx+dXIQfmImxRMLrG07Sthi
 yL4RxiVJDBtmWrrb8gmZEAil1ay2wu4KZsY8tjHzwySSdReFVfZ9dTn0EKJO8b4YryJ/
 crzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4f/clxlilFuIydMRrGudVTp6YYwPxAbh7kCsQ3vkYa8=;
 b=LfIGaw+2Uev+DXv4dYyRqwbondLatWN4NVuFtqWET+8epqHim/CwGfX+jNHBnhwEMF
 Y2yq4t06DJeU7DAEXX14gOPShbhx4/5gbInNVh8VpL7Ufqv5VVFgyWRgVMCsEOUkgewM
 Fm/j/jBRlruouEBVRWyUKc+2u8gHR+Qn5dV8FW+XEwfAeVHBDapGDXIbA+jPhfqZv4om
 P+evdEZ9vnJJW4TUQJJj9izLEco9mqIfanaTgBjK41NCUqEKePb4XUGYdvFg9S6iLObF
 G8PCxFjkCqMQ7cK+KxgDnBKhu90ABNGhc7GWNw98vumrjUTfp3D7RffMzpkqJ7deO2Vj
 y3jw==
X-Gm-Message-State: AGi0PubgXa9OO3jOoUjt4S77wnu6kjfD50NRhvsb0bxLgrcs3Mod/tuE
 mBtD/U8etei+UsTVWbzjhWA=
X-Google-Smtp-Source: APiQypLz1OxFU4SEHCrEEdHTNeTU4UGxH1nTvxgQ1jPIGJanZTFV2hjQaPmMHWKxUtJ+pt4ES7giRQ==
X-Received: by 2002:a63:3603:: with SMTP id d3mr9313359pga.101.1589081506381; 
 Sat, 09 May 2020 20:31:46 -0700 (PDT)
Received: from localhost.localdomain
 (68-123-15-75.lightspeed.sntcca.sbcglobal.net. [68.123.15.75])
 by smtp.googlemail.com with ESMTPSA id b24sm5726350pfi.4.2020.05.09.20.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 20:31:46 -0700 (PDT)
From: Mike Pozulp <pozulp.kernel@gmail.com>
To: 
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Notebook
Date: Sat,  9 May 2020 20:28:37 -0700
Message-Id: <20200510032838.1989130-1-pozulp.kernel@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2020 10:21:01 +0200
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Tomas Espeleta <tomas.espeleta@gmail.com>,
 Sergey Bostandzhyan <jin@mediatomb.cc>, Mike Pozulp <pozulp.kernel@gmail.com>,
 Chris Chiu <chiu@endlessm.com>, Takashi Iwai <tiwai@suse.com>,
 Hui Wang <hui.wang@canonical.com>, Jian-Hong Pan <jian-hong@endlessm.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 open list <linux-kernel@vger.kernel.org>
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

Some models of the Samsung Notebook 9 have very quiet and distorted
headphone output. This quirk changes the VREF value of the ALC298
codec NID 0x1a from default HIZ to new 100.

Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 63e1a56f705b..9b14ed5c75d7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5923,6 +5923,7 @@ enum {
 	ALC294_FIXUP_ASUS_DUAL_SPK,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_HPE,
+	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7061,6 +7062,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc5 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7336,6 +7344,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
2.24.1

