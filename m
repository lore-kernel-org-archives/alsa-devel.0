Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1EDC4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:38:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39EAF601F8;
	Sat, 18 Jul 2026 11:38:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39EAF601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367506;
	bh=4tNo6Yc77QWmYsbTfGflRg5UZrmccNSnHNrFESVSPCE=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GbF+iieRC7mq5kqSWn4xY7ZDEl4gvYXPAOJLBc9/2YgUC/OVnAfbgTHVrar4shd5j
	 ++8hwr/F9fnDRiXVUaGuKHMxqIHHsOISTWoMMLzlwBn6GLKY8EEVwb4oxITdIi3MaM
	 SrpKOPnWFR4h3Ea+WMWSJeXVUMNDHsYM5aoLJNzI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F4169F806A9; Sat, 18 Jul 2026 11:36:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79DA9F806AC;
	Sat, 18 Jul 2026 11:36:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 076DFF8055B; Wed,  8 Jul 2026 22:04:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783541074;
	b=Is7N7pUcv8RsppO+QKH3rCz/y/Rm1+ovrn0eEiZnzPElPHkeED3vHLwNWZCWBOB6niO8
	 Ersql5ZH1dJFB2o35l0a77I/DVsoz4RlrTi0j51SAx36L80fpdzDRvdwYcek8WCiwlIsT
	 rjRhmADRVYZcPz3pXkGA+c5ZslzvcihXOjNtwaTlPn4ssJJiCmkW83JD2R8rdZf2fKhas
	 GEcChWprTBHeV0sMqBZuEkYlWvFE6v7d/sY2j7p26sCSNusykoN6UoJRwH9ni6QzGO2ng
	 HAfxlwazXcWlV4WU0+eLaUMP7Fo6CCG4aBwqTf0FP6TZFZyIV4rtyDTtOSHjEZ0SxFg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783541074;
	h=DKIM-Signature:MIME-Version:Date:From:To:Subject:Message-ID;
	bh=4tNo6Yc77QWmYsbTfGflRg5UZrmccNSnHNrFESVSPCE=;
	b=HGp9QD7cjOdQ0/We9modh4iGjZ5pzllQ0ktd0J/UG4rGHadHv0C6T43vFvBXVNBscnP1
	 /yUrRYNQJ+bJ0rXPtHciNStzjKWsg192mJQFju22VJ/KscNkuuRnk90BP4ppuBQP+/R3y
	 QNrFmizH2VngLd5dLC9k9Dxhyr49b7Ul1w7cbWIOiiZxpqSeKudBc5yn3caeYk/ResuA/
	 DqcsK/71p9cngu03byCCGh74y8Ky+CnH5GlRjJVqRbwCCgDOc24hxbp+F0RRI5ywzDxBo
	 2PNms39Hd3k4+B6O8GtAKjODS4EqxYmQDsDLJHivLTUjgniemRLcKmQtdpJVp2ctu/Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256
 header.s=1984.8680eb header.b=OrNBb97b;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2EF83F80224
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 22:04:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EF83F80224
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256
 header.s=1984.8680eb header.b=OrNBb97b
Received: from submission (posteo.de [185.67.36.169])
	by mout01.posteo.de (Postfix) with ESMTPS id 8A855240027
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 22:04:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1783541071;
	bh=Y9MEOAxh5b63Adlfao2iDHFPLGatcwLiz4X9KR+ESHU=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=OrNBb97bHZ9XULCBNTyQ2N2mRusIca2zw70TywWCXIjjDlUeIVkFxE0GDoPfDQis6
	 ZBX8BaiS2y4oSJSyIF0Z4cRybDq/wx9SslgGNC7W3QBxHopOzsKdmNeqNCR/vvhlrU
	 OzZd00+HtTsxsZltJaMO5NSO/qh14AjNaNbCK84/E865EVligzq507lAOCrZntP+gc
	 EwKhViS9VESc+0Nzpj6UUDuyXIcDIngpNmHWmwUAL0X4FLJsEr8upnfzihAssqRpyj
	 PUxncuGdzydEZ5qxZATHGROp0j5aTFq7rPoUTgiQianJNZKdkgs2+jRdnnDxf/z4N6
	 T/a1O2BVLbOdg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gwTZk6cGgz9rxN;
	Wed,  8 Jul 2026 22:04:30 +0200 (CEST)
MIME-Version: 1.0
Date: Wed, 08 Jul 2026 20:04:31 +0000
From: Michael Diesen <michael.diesen@posteo.de>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, linux-sound@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Elite Dragonfly Folio
 G3 speakers
Message-ID: <6b2b71bb318263aeb4f3ff67754d9978@posteo.de>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-MailFrom: michael.diesen@posteo.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: B6D5WOHHYUAI2NXYQL3G5NNRFDPJSCXP
X-Message-ID-Hash: B6D5WOHHYUAI2NXYQL3G5NNRFDPJSCXP
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:36:29 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B6D5WOHHYUAI2NXYQL3G5NNRFDPJSCXP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP Elite Dragonfly Folio G3 (PCI SSID 103c:8a05) has 4 CS35L41
amplifiers on SPI, identical to the non-Folio Dragonfly G3 (103c:8981).
Without this quirk the amps are never registered and speakers stay
silent.

I've been carrying this as a local out-of-tree patch and would like
to get it merged. Note there is a related, recently merged quirk for
a neighboring SSID on what appears to be a sibling board variant:

   0a10faad5ca5 ("ALSA: hda/realtek: add quirk for HP Dragonfly Folio
   G3 2-in-1", 103c:8a06), which uses the SPI4 + GPIO LED fixup
   variant rather than plain SPI4.

My hardware (103c:8a05, "HP Elite Dragonfly Folio G3", non-2-in-1
SKU) works correctly with the plain ALC245_FIXUP_CS35L41_SPI_4
fixup and does not need the GPIO LED handling. Happy to re-test
against SPI_4_HP_GPIO_LED if you think that's actually the more
correct fixup for this board too =E2=80=94 let me know.

Signed-off-by: Michael Diesen <michael.diesen@posteo.de>
---
  sound/hda/codecs/realtek/alc269.c | 1 +
  1 file changed, 1 insertion(+)

--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6817,6 +6817,7 @@
       SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)",=20
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
       SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100",=20
ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
       SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9",=20
ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+     SND_PCI_QUIRK(0x103c, 0x8a05, "HP Elite Dragonfly Folio G3",=20
ALC245_FIXUP_CS35L41_SPI_4),
       SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx",=20
ALC287_FIXUP_HP_GPIO_LED),
       SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx",=20
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
       SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx",=20
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),

---
