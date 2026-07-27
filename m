Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929F8C54F51
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB5676018C;
	Wed, 29 Jul 2026 10:58:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB5676018C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315493;
	bh=29SLJtFWgu7ALvVIFmqVM7ytQf5DvPxBKfa1ZnVerIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YTEktmCVtr6ngGUvFxU4GvhoclzGKTII2dRwAChINBjCv8Ne3OazDOdzHcAvP2bk/
	 9PnyvYJDqmQFMuHhBAnugPoIM7Q+qymlI26h+blWrZaYwkW7VApASUVlCfQfK8nuwL
	 PQele8eKsXu8d7ANV1Qb1A36a0E7SAeip6qgEQpQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BD59F8061B; Wed, 29 Jul 2026 10:57:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29AE8F8061D;
	Wed, 29 Jul 2026 10:57:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B524F80526; Mon, 27 Jul 2026 11:19:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785143964;
	b=n0jGvb0AVCXQua4tlu7XdNaVtKgee6zT9sDbngoTh2jweTrHu4r7iwZmkUUKVuyaLgGr
	 4Gi4uZifiatZLjuhrVmTU650uv8e3yzLp6D3e5HSI24QvuP7QNw/q1PInksJrrYSY8NEH
	 1Towhec+OAlEYqxa3oTZ31h5e+FZGAqqGZSFpXcVA9iIUjEKoYz9vhk1YK1OQra3IhUwj
	 pTDeY43D6VkuucyYY0R4VKRkpD+ssP4RTSI4i/XLTMFHJs4SdzzQwM2OLT7uNrcoISMZl
	 5aYTy+wVIeffT4vFOSkkI1drjM12BC2oFb7OUXLZ1yyWzba2sBABT/pwgkeqiDuVPLA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785143964;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=29SLJtFWgu7ALvVIFmqVM7ytQf5DvPxBKfa1ZnVerIU=;
	b=ChGCmai9I7Pa8gmg/Rs86N/i2hx8ArSt5K3O2gBT4iOVJfmmuiOpIKwHGL9O6p3fc+et
	 /O7hDYinzrtcYSLldO1suxFgEQfbTmJjUUMBX3Ns4mVB8Y33FIcuc3QtL1J7tKdoyvRjx
	 wZQcIv1snc2oM1f0+UC6I1ycBw0XgynooAlZ3qtH37ZwiRTE42CIF3VtevY3plPSDyyuI
	 vdKMTK4npbv87Vjld1tu65dxpXVsQ01CGI++9qnzchVeU8KDJcOEN295TOwwUz5c0BJzt
	 dAll6yhAKftGfNlrQ8St6C3UdqorwuMV2OxKKW4nKp1d8p8bm6FfNu/uYyEFxONzFEA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256
 header.s=1984.8680eb header.b=RV07lMUp;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F2090F800BA
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2026 11:19:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2090F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256
 header.s=1984.8680eb header.b=RV07lMUp
Received: from submission (posteo.de [185.67.36.169])
	by mout01.posteo.de (Postfix) with ESMTPS id BF77C240028
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2026 11:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785143961;
	bh=e02G+UAzxZHsnCyPekSkBZLHCHZCED+tLQmm8H77/Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=RV07lMUpQe6n4ueYIA1pfiIKhehTmpJ0FF1ttNHdH1toAfUYV0mUq2OE14Y4z5xKo
	 0KORuaxbVO62x/NFuHoVZ6UGs2cCmAN/e0IlYexKHWLiaImAn7eUK/I87ub+qRKCi7
	 uP5cbbO5W7pTa9B1couA4CUrw0kcA0U1Ihcqbdow5A2WYHOf94mr5ktAJZN8BSx2hJ
	 RUtSUJUN4W9ubpx0iNv//ufCG4uDcxVz6fi6aMOAOucWezTxWALgU11K434uAEj4U1
	 QLDxZXKcaxFOInWQgC8GC1P3llXJ3PcF4LGKhjd+iPrW5lFM6pTa85HrYaxEuBioPt
	 8BFWvaQ2prkOw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h7tMY1ztQz9rxF;
	Mon, 27 Jul 2026 11:19:21 +0200 (CEST)
From: Michael Diesen <michael.diesen@posteo.de>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for HP Dragonfly Folio G3
 2-in-1 (103c:8a05)
Date: Mon, 27 Jul 2026 09:19:21 +0000
Message-ID: <20260727091920.4634-1-michael.diesen@posteo.de>
In-Reply-To: <874ii84j3p.wl-tiwai@suse.de>
References: <874ii84j3p.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: michael.diesen@posteo.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: CMW6H36E5CCEWT3ARJ6NZWJB7IGOZ3D6
X-Message-ID-Hash: CMW6H36E5CCEWT3ARJ6NZWJB7IGOZ3D6
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:57:21 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CMW6H36E5CCEWT3ARJ6NZWJB7IGOZ3D6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP Dragonfly Folio G3 2-in-1 also ships with PCI SSID 103c:8a05.
On this unit the ALC245 codec reports subsystem id 103c:8a06 - the SSID
that is already covered by commit 0a10faad5ca5 ("ALSA: hda/realtek: add
quirk for HP Dragonfly Folio G3 2-in-1") - while the PCI SSID that
SND_PCI_QUIRK matches against is 103c:8a05:

  snd_hda_codec_alc269 ehdaudio0D0: ALC245: picked fixup for PCI SSID 103c:8a05
  cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: CS35L41 Bound - SSID: 103C8A06

The existing entry therefore never applies here, the four CS35L41
amplifiers on SPI are not registered and the internal speakers stay
silent.

Add the same fixup that the 8a06 entry uses: the four amplifiers bind
and the speaker mute LED (codec GPIO 0x04) works.

Signed-off-by: Michael Diesen <michael.diesen@posteo.de>
---
v2:
 - Resend using git send-email. v1 was mangled by my mail client (tabs
   converted to spaces, long context lines soft-wrapped) so it could not
   be applied with git am. Sorry for the noise, and thanks for the
   pointer - I tested this one by mailing it to myself and applying it
   with git am before sending.
 - Use ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED instead of plain
   ALC245_FIXUP_CS35L41_SPI_4. In v1 I claimed this was a non-2-in-1 SKU
   that does not need the LED handling. That was wrong: DMI reports the
   machine as "HP Dragonfly Folio G3 2-in-1", i.e. the same model as the
   8a06 entry, and the speaker mute LED stayed dark with plain SPI_4.
 - Name the entry identically to the 8a06 one, as it is the same machine
   with a different PCI SSID.

On the mic-mute LED: alc285_fixup_hp_gpio_led() also drives GPIO 0x01 as
mic-mute LED. That LED does not respond on this unit. Poking the codec
GPIOs directly with hda-verb shows 0x04 toggling the speaker mute LED,
while neither 0x01 nor 0x02 has any effect, so the mic-mute LED does not
appear to be wired to the codec here. It does not work without the quirk
either, so this is no regression, and it matches what the 8a06 entry
already does - hence I kept the shared fixup instead of adding a new one.

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index b22564f..ec6724e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7160,6 +7160,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8a05, "HP Dragonfly Folio G3 2-in-1", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a06, "HP Dragonfly Folio G3 2-in-1", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a1b, "HP 255 15.6 inch G9 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
-- 
2.54.0

