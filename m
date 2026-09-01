Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF8EC79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:37:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 711AE602DE;
	Tue,  8 Sep 2026 20:37:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 711AE602DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892677;
	bh=ya2zK+3lf2slUOufJrjfoai2gX4sEp1x5gMTcD91a44=;
	h=Date:To:From:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OZER0xsBJcgNXzYQJcb1ultIQpRDucqizv81c/OTICUVGXZ7PTXb9M7tciseUd8fi
	 3jGEOpowNgxOVaaQnjtKcErZaL+Vv7Re6S0bG/+saeWOaLss/KJri+ro367Ch5eDhL
	 GiujIg0LZJ2TCF2if8x7ibWvnmpRNOAYcsQ4EP9o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68674F80714; Tue,  8 Sep 2026 20:35:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0909BF8070B;
	Tue,  8 Sep 2026 20:35:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 273D6F804CC; Tue,  1 Sep 2026 20:33:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=109.224.244.28
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788287609;
	b=roA1WKBU+wKg+GWwrn2ZJGDs0FQ2he2d6SxAxqvTSnv1eDqP4//BL6igBw/PfCFaFvKB
	 5t4Xijw2mZmx18+lncAhKro86OoLJcWbFD8Mm1A2RoIweOCaJIYV3fRsVp6ZXQlBRBR0I
	 dvbXd4g6Vuyc3fcLuLD+uVtS8A20fQcD+6auVQFUTvvqooyroJ6FZepJ1Kp1/92KcustC
	 kOGF5VofHKfZsBB7lrS0Q6yrhqGEn/jzBByp6+QrNPM1edNdti79NRBl/4hyy77iFwedp
	 6Z/Pxe+9YEN+av8RCbvXQbYbwuVhyw8bqB+BceLGH/5eKESVuzhre5SojQvwD3/WSJA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788287609;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=l2K9CjiPYt/xmUakOF8kxIcKk3WRSg9DFLERfy1hA18=;
	b=o0/BV84ffVV4dWeR/ahx02JRpkBn/AE44Bskyuc+ET/hScizBN6z3e1y/OWnIGRUsh2A
	 UYoxCVOtXJ+m6v6E+O64MCY8J0xPtFxN5jT9BrNlBbgLe7cggZ1AX2jeQgUziKaDT1OaE
	 UlGHpNBnYDRmFeCaQccuZKl4SfRs3X6dUyemNUH2hVuWfAGbao5CVU/POsIAwkdLOlWWi
	 koSBykV66j/0WGwOep7oTSX25bkXoT3q4hIGr+RT5fdB5FT8npOYI22/R6Ib09ERUkFMg
	 uHbKnuYyLaodfOqk7Jj4h76b1smwskISlXOrVaOwsfZR4p9Ev0bifO30LiakESLEdPA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=fgj1y2QJ;
	arc=none smtp.remote-ip=109.224.244.28
Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch
 [109.224.244.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9E5F7F80246
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 20:33:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E5F7F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=fgj1y2QJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788287607; x=1788546807;
	bh=l2K9CjiPYt/xmUakOF8kxIcKk3WRSg9DFLERfy1hA18=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fgj1y2QJ7MfrcsLlriZKBC2KD394GW9FSQEs3u38GlTqV7FhJ4U7m3gAI240cCUAE
	 7LPvq68ldGjgktFFOfOE00Euod/hOOIHdGU6aZtaP5Tz8ulQ3ZbsLiOVedczeyJ0dx
	 F9L2DHD1zgVc4YUsUQ9NgZy5qPv4Fkmn0kiyWc189/jDgh/oacjNIwWcFxkOpYixaE
	 CqqBE+pqTapm4NIy/G2zeJoh6qwqbzY3iQYrkQvchWhEWW2RlBBrqMWlDzsXSfjFEZ
	 7pk5pxwWJdVn26woz+eTWpWiOuOPDNzveqzjdUkivPl69R9LI350nKZRwsYGbfdkQd
	 kwE4nmhCRvoFw==
Date: Tue, 01 Sep 2026 18:28:27 +0000
To: "tiwai@suse.de" <tiwai@suse.de>
From: Jonne Vuorela <jonne.vuorela@proton.me>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: hda/cs420x: Add CS4208 fixup for MacBookAir 7,2
Message-ID: 
 <Qcui5livawCaJbO1jfx_jebS64rR0f9KATkqn8May0pPyLw8U5DqPQBigmSzRxJp-GeMPqs-jAK6PCnagk3bspzmH__YPte-eyvPtFtuolo=@proton.me>
Feedback-ID: 120530430:user:proton
X-Pm-Message-ID: 49800b2c475cef0bb884859310a7749f88e41f01
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: jonne.vuorela@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WCPUQTYDICSMAFQYGU72ZJOWGP5HTKWM
X-Message-ID-Hash: WCPUQTYDICSMAFQYGU72ZJOWGP5HTKWM
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WCPUQTYDICSMAFQYGU72ZJOWGP5HTKWM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

>From 6aaa1f7fe990490a9b3d259a5ecde7495b60a281 Mon Sep 17 00:00:00 2001
From: Jonne Vuorela <jonne.vuorela@proton.me>
Date: Tue, 1 Sep 2026 16:40:10 +0300
Subject: [PATCH] ALSA: hda/cs420x: Add CS4208 fixup for MacBookAir 7,2

The MacBookAir 7,2 HDA controller has PCI subsystem 8086:7270
rather than Apple 0x106b, so no fixup is selected and all pins
default to 0x400000f0. The pin wiring matches MBA6, so add the
subsystem ID to both lookup tables pointing to CS4208_MBA6.

Tested on MacBookAir 7,2.

Signed-off-by: Jonne Vuorela <jonne.vuorela@proton.me>
---
 sound/hda/codecs/cirrus/cs420x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/cirrus/cs420x.c b/sound/hda/codecs/cirrus/cs4=
20x.c
index 85c2ecf46d3..564a0e49a75 100644
--- a/sound/hda/codecs/cirrus/cs420x.c
+++ b/sound/hda/codecs/cirrus/cs420x.c
@@ -571,6 +571,7 @@ static const struct hda_model_fixup cs4208_models[] =3D=
 {

 static const struct hda_quirk cs4208_fixup_tbl[] =3D {
 =09SND_PCI_QUIRK_VENDOR(0x106b, "Apple", CS4208_MAC_AUTO),
+=09SND_PCI_QUIRK(0x8086, 0x7270, "MacBookAir 7,2", CS4208_MAC_AUTO),
 =09{} /* terminator */
 };

@@ -580,6 +581,7 @@ static const struct hda_quirk cs4208_mac_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x106b, 0x6c00, "MacMini 7,1", CS4208_MACMINI),
 =09SND_PCI_QUIRK(0x106b, 0x7100, "MacBookAir 6,1", CS4208_MBA6),
 =09SND_PCI_QUIRK(0x106b, 0x7200, "MacBookAir 6,2", CS4208_MBA6),
+=09SND_PCI_QUIRK(0x8086, 0x7270, "MacBookAir 7,2", CS4208_MBA6),
 =09SND_PCI_QUIRK(0x106b, 0x7800, "MacPro 6,1", CS4208_MACMINI),
 =09SND_PCI_QUIRK(0x106b, 0x7b00, "MacBookPro 12,1", CS4208_MBP11),
 =09SND_PCI_QUIRK(0x106b, 0x7f00, "iMac 16,1", CS4208_MBP11),
--
2.55.0
