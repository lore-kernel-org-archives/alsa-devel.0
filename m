Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B775EB64D7
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jun 2023 22:29:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDB84823;
	Wed, 21 Jun 2023 00:28:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDB84823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687300155;
	bh=pMukWB0Dc/yW8XeN7gZs3fKsPLiPAntaM6BWAC5s3ZI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Sma8El6e2BS06ETp3biGn4Alte+ZeG+Eijl+No9MU08LkixUv/JYXOtTqb4d8Nets
	 DjJM1tgKu4rNhJXrWZKL54WL5R/3ekaUZuWLmoxKGdcQ+tTqXA80wIk4wVADGvpl+G
	 86G5ekdifD0t2LG7bzAnDNyRJ08LqvFhYrcSZGV8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB6CEF80141; Wed, 21 Jun 2023 00:27:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1603FF80163;
	Wed, 21 Jun 2023 00:27:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3E1BF80163; Wed, 21 Jun 2023 00:27:53 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D5ABF80124
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 00:27:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D5ABF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=VaulE6xZ
Received: from localhost (unknown [188.27.34.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id D31576606F5C;
	Tue, 20 Jun 2023 23:27:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687300069;
	bh=pMukWB0Dc/yW8XeN7gZs3fKsPLiPAntaM6BWAC5s3ZI=;
	h=From:To:Cc:Subject:Date:From;
	b=VaulE6xZq8PG0Q2I2jrEKrBsPSG46Sr1cnARHj08qnwGyG1VVilmE+1ruQ0E3U7h6
	 I2x0VPpvtag6a73EWOiZE0x04qC/mayOpWtQoC+5tj7uwERkcLHogohfZF/VF2ZzdP
	 3MiM9DO5q+fRIW54u5dCMTfEUrsUYD1EQRK+JkqoZ+mAZgOSvHABqLJ4BIMOowPzvO
	 +8DHy3nImcICOCiY1jr5tw97vsMgAzfei2WbdUXeyB3yyI4SDJCKA6BOKi+nN+xtBI
	 +WXRRVrdq2s/TEw/LkpSrdj9Cb+FRpe0208oZKeDWf+/2CHDLz/YDqlo54WQ6lik16
	 MyhH0mYD4tBvQ==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 0/2] AMD Vangogh support for NAU8821/MAX98388
Date: Wed, 21 Jun 2023 01:27:41 +0300
Message-ID: <20230620222743.274432-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WHUAIVXFWRGQVLSATEHL2R7NN4ZAKR37
X-Message-ID-Hash: WHUAIVXFWRGQVLSATEHL2R7NN4ZAKR37
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WHUAIVXFWRGQVLSATEHL2R7NN4ZAKR37/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series extends the Vangogh machine driver to support a variant based
on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 Speaker Amplifier.

Cristian Ciocaltea (2):
  ASoC: amd: vangogh: Add ACPI probe support
  ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant

 sound/soc/amd/Kconfig              |   5 +-
 sound/soc/amd/vangogh/acp5x-mach.c | 155 ++++++++++++++++++++++++-----
 sound/soc/amd/vangogh/acp5x.h      |   2 +-
 sound/soc/amd/vangogh/pci-acp5x.c  |   3 -
 4 files changed, 134 insertions(+), 31 deletions(-)

-- 
2.41.0

