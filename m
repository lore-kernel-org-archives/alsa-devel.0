Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B787EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jul 2023 13:45:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33713741;
	Wed,  5 Jul 2023 15:44:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33713741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688564714;
	bh=5bjQOEUku2okttevc3PZVpNPoxW8myAeEIowZbKzBIU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vPYgJiQqtrEbfmfVNEOJjkpQyYP97527j8yDEh+lq8tbBQHJ3GpraWY3KPLk0hGg8
	 S3VrtHkydXLUBwGVcplQg/B2RJupFKivjcltgy5Ft/QiwCJ85YPaaUXPQyeKOf2aCC
	 Twt1405ZoN2tN+8Nt4QYNGcDf7BajMic4oLyRKPg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BAC5AF80544; Wed,  5 Jul 2023 15:43:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AF2FF80104;
	Wed,  5 Jul 2023 15:43:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A89EDF80132; Wed,  5 Jul 2023 15:43:52 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13D25F80104
	for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2023 15:43:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13D25F80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=gwDn4hyI
Received: from localhost (unknown [188.24.137.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E18C766020F5;
	Wed,  5 Jul 2023 14:43:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1688564626;
	bh=5bjQOEUku2okttevc3PZVpNPoxW8myAeEIowZbKzBIU=;
	h=From:To:Cc:Subject:Date:From;
	b=gwDn4hyIXaJbyClgM1YhDa4/fU1uqKrOviP1psPa+4LrL1wjZHA4ROIzF9LACNKaH
	 vX2Y8tw4GWgXzyj/nZQPTXz7HSMAoVTRiBtquILhZDFSFw9SmHYhfpNKaWxbdp5mtH
	 HlM73JCEOguZzO4W6HVR7Vn/ado3CZPPfuQlN9gK0EC4XKs2EMrSQhAY5RKmv5pFD+
	 lV8BnFfSAfJoXJ35FyzBcF8KPsckZhpr3ZlyXoLmni2BXJXJGj8YtgIj1mpSIhc66a
	 SJjW0GO51MlXAxFrcG8XUUZN3tYcQdAEk05/Db6JkZqQKfaM22wb8lS6jHj1pkWxKH
	 oWBsXkBj5hp6g==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 0/3] AMD Vangogh support for NAU8821/MAX98388
Date: Wed,  5 Jul 2023 16:43:38 +0300
Message-ID: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Y2EEXTVCSPML4J55NCDQ4M2N6YRVAHJQ
X-Message-ID-Hash: Y2EEXTVCSPML4J55NCDQ4M2N6YRVAHJQ
X-MailFrom: cristian.ciocaltea@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y2EEXTVCSPML4J55NCDQ4M2N6YRVAHJQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series extends the Vangogh machine driver to support a variant
based on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 
Speaker Amplifier.

Changes in v2:
 * Reworked series to ensure the existing devices based on the CS35L41 
   codec continue to work fine
 * Rebased onto next-20230703

Cristian Ciocaltea (3):
  ASoC: amd: vangogh: Make use of DRV_NAME
  ASoC: amd: vangogh: Use dmi_first_match() for DMI quirk handling
  ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant

 sound/soc/amd/Kconfig              |   5 +-
 sound/soc/amd/vangogh/acp5x-mach.c | 167 +++++++++++++++++++++++++----
 2 files changed, 149 insertions(+), 23 deletions(-)

-- 
2.41.0

