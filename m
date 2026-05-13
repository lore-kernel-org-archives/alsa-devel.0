Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79983CD37AC
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 22:30:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A210601F3;
	Thu, 14 May 2026 00:30:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A210601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778711429;
	bh=XPYG8f6X3agucnqnQH9p8A70G2UfOpiLftTI2X/gs7A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Vhrx0meWF7yYS9s6Llt42HoOxVxkHvN45RU3PbWV2LwyDE05Bi9W5RVpcaHh6KCxx
	 LG9K71sdD3Y7MsQ4e3dkvycQk00abbqLZIibfquC6U09hahD7qqyRpH03tN5R6Hb8G
	 kZmMPRHqux+eUUINiEkgqil0dYV9Pv4ARxzKK8EY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E150F805EA; Thu, 14 May 2026 00:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A889F805EB;
	Thu, 14 May 2026 00:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE329F8021D; Thu, 14 May 2026 00:29:49 +0200 (CEST)
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com
 [136.143.188.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C12F5F800C1
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2026 00:29:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C12F5F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=markus-kramer.de header.i=linux@markus-kramer.de
 header.a=rsa-sha256 header.s=zoho header.b=Y7QpTBWv
ARC-Seal: i=1; a=rsa-sha256; t=1778711378; cv=none;
	d=zohomail.com; s=zohoarc;
	b=ecbotbO6Y9626ui30ovfCeA9ExzdZ0yBWNmtsNAkgN5S31dEtu9HHMXk5pGM+1LzMrMczxgNaEpadSrxkS7DH/j3TD4BcA4EKqoxY/shGwD2e5yGQmSnMZxxhi8T+Ix4jWpUuMqo8X9A/SlOA1msLbxRjZM6HucdYf7HAF5GnAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc;
	t=1778711378;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
	bh=Uuz/iCbKUjHtl+HMQAc9fDLbvMD3X4bXHgkahE169Uk=;
	b=JOENk2NXp9jdtMegqDhVCmZXWpDxLbyt9E/9LzMhn2qzVspatiBPcBJwuB4Rm7lWcUDBSTrRo8HgaqONz/2yqaMMq5JfC38kPhVi+Eu6Xucg40/nOj5VRHQHjakVNswlx5GRd6sHprUNgq+tqAkNdL51mymZj8/hdPCYnZLSv70=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=markus-kramer.de;
	spf=pass  smtp.mailfrom=linux@markus-kramer.de;
	dmarc=pass header.from=<linux@markus-kramer.de>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778711378;
	s=zoho; d=markus-kramer.de; i=linux@markus-kramer.de;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Uuz/iCbKUjHtl+HMQAc9fDLbvMD3X4bXHgkahE169Uk=;
	b=Y7QpTBWvDVxzUJquAIDwzek1Fm8fI4vqxXIACzpumDH8RhQTelJ9xrFwHaJOR8bv
	e74JVL/xf97A+5fJfPJSe6IyUoqBgXTL9sx68eiJc2BY6LOVJSUNn6IiNYBZnRlphmc
	JOiF6a6hEKvA1S/TRRMXC6Gq139uhnoZl19IlawY=
Received: by mx.zohomail.com with SMTPS id 17787113764091020.441744321745;
	Wed, 13 May 2026 15:29:36 -0700 (PDT)
From: Markus Kramer <linux@markus-kramer.de>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Kramer <linux@markus-kramer.de>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book5 360
 headphone
Date: Thu, 14 May 2026 00:28:18 +0200
Message-ID: <20260513222818.14351-1-linux@markus-kramer.de>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Message-ID-Hash: DWBHYSNY44AT6ADAKI7RSGEXG7GR3NBZ
X-Message-ID-Hash: DWBHYSNY44AT6ADAKI7RSGEXG7GR3NBZ
X-MailFrom: linux@markus-kramer.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DWBHYSNY44AT6ADAKI7RSGEXG7GR3NBZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Samsung Galaxy Book5 360 (NP750QHA, PCI subsystem ID 0x144d:0xc902)
has severe audio distortion on the 3.5mm headphone jack. Applying
ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET corrects the output path
configuration, consistent with fixes already applied to other Samsung
Galaxy Book models using the same ALC256 codec.

Cc: stable@vger.kernel.org
Link: https://github.com/thesofproject/linux/issues/5648
Signed-off-by: Markus Kramer <linux@markus-kramer.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 55bb98e2e..4c610842c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7504,6 +7504,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc870, "Samsung Galaxy Book2 Pro (NP950XED)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc872, "Samsung Galaxy Book2 Pro (NP950XEE)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc886, "Samsung Galaxy Book3 Pro (NP964XFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x144d, 0xc902, "Samsung Galaxy Book5 360 (NP750QHA)", ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cb, "Samsung Galaxy Book3 Pro 360 (NP965QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
-- 
2.51.2

