Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FD4EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jul 2023 08:03:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 742BD93A;
	Thu,  6 Jul 2023 10:02:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 742BD93A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688630583;
	bh=qStIk3J6Z6wihOqFl8DSJNUL/Kuc/TFIBxAkI8a+/Tw=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=p1TpcTAzdmQ/dKDvOjdwkT81b3nU30T4wRZBsuROWI/PtigVV4plEBWWws56Ogbn9
	 LfSF1AYy//BY/ed/Uy81QF3hqgzyvaRaBKYN0/myOMyFFLYpo5LDr1HRQigVjLVQkQ
	 S2Iy3PJjLwjnDeWKbyrxuzHxFhvqweg/trXaNGkQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34727F8057B; Thu,  6 Jul 2023 10:01:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB1EBF8057A;
	Thu,  6 Jul 2023 10:01:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A9D8F80125; Wed,  5 Jul 2023 21:03:55 +0200 (CEST)
Received: from mail.andi.de1.cc (mail.andi.de1.cc
 [IPv6:2a02:c205:3004:2154::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4B7DF80124
	for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2023 21:03:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4B7DF80124
Received: from p200300ccff0adc001a3da2fffebfd33a.dip0.t-ipconnect.de
 ([2003:cc:ff0a:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1qH7mh-0017Xc-MG; Wed, 05 Jul 2023 21:03:27 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1qH7mh-001UQf-09;
	Wed, 05 Jul 2023 21:03:27 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: bcousson@baylibre.com,
	tony@atomide.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	peter.ujfalusi@gmail.com,
	jarkko.nikula@bitmer.com,
	dmitry.torokhov@gmail.com,
	andreas@kemnade.info,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ARM: omap4: embt2ws: Add audio support
Date: Wed,  5 Jul 2023 21:03:21 +0200
Message-Id: <20230705190324.355282-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: andreas@kemnade.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ILJNHRF3QBOAUWMAVLGZMITF52D5IPUF
X-Message-ID-Hash: ILJNHRF3QBOAUWMAVLGZMITF52D5IPUF
X-Mailman-Approved-At: Thu, 06 Jul 2023 08:00:55 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ILJNHRF3QBOAUWMAVLGZMITF52D5IPUF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add audio support for Epson Moverio BT-200.
In the vendor kernel, the MCBSP side is used as master,
so do it here also that way.

Andreas Kemnade (3):
  ASoC: ti: omap-mcbsp: Ignore errors for getting fck_src
  ASoC: tlv320aic3x: use BCLK instead of MCLK if not in master mode
  ARM: dts: omap4: embt2ws: Add audio support

 arch/arm/boot/dts/omap4-epson-embt2ws.dts | 21 +++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x.c            |  4 ++++
 sound/soc/ti/omap-mcbsp.c                 |  4 ++--
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.39.2

