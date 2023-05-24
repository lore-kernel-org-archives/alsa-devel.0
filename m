Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88067C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 24 May 2023 07:43:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 753D9208;
	Wed, 24 May 2023 09:42:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 753D9208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684914208;
	bh=rIv0A5Qf9tPl9upoHpRp3OawplgowbPYSCpfX7sHQQs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dhrj0nLI+/n61nJxtgS6tz3rBca8ndaXlNG+qjnH1wcAmcZ0+JYe2USQuVwReEh5X
	 lShQ6uBICw74S9t9CHsx7MyqAYLcmijkrad2B1kFD48nQ9yfVqp67XM4tBr8Qv0QaO
	 TPY+4Qe60UwLaYG+RUxA0MtdVbQF4fqIGBT2Qiqo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44D76F8024E; Wed, 24 May 2023 09:42:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 90C6FF8026A;
	Wed, 24 May 2023 09:42:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 61798F8026A; Wed, 24 May 2023 09:42:05 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5625F8016A
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2023 09:42:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5625F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=mkVmnzX7
Received: from localhost (unknown [188.27.34.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id BF15D6605992;
	Wed, 24 May 2023 08:41:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1684914119;
	bh=rIv0A5Qf9tPl9upoHpRp3OawplgowbPYSCpfX7sHQQs=;
	h=From:To:Cc:Subject:Date:From;
	b=mkVmnzX7hyiNjGwuOi5uJH4qVAYOE2KMAxnr1E4ywOBmJfn+sUDyoZNPzuPGiglxb
	 gjMITxPbcKo/PXM0riNWt26Q9cCbbCMLf1xg+14Awi5pPoebFb0+XrZJRAoJFGb18p
	 bZG+D/xkXEBXtPCrTO9Snx0tTpU5IhcQr5BTYB1femUNNNk+9Mom7bW1avP+DKhS97
	 vo1b9t3qacx9zR97zxM4gap6+CCkprrqy8u8Z4j+aGukg/QSqGwiVoawOJVNslroXW
	 gnSOeGiDQN0MWMr70bjVjF7YIR/R5p0mTqF/lDRQmDFSS4GOtYAfZWsfOPPYVZYmwA
	 cmuZIImgz60TQ==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Zhu Ning <zhuning0077@gmail.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	David Yang <yangxiaohua@everest-semi.com>,
	Daniel Drake <drake@endlessm.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	kernel@collabora.com
Subject: [PATCH 0/3] ES8316 audio codec fixes on Rock5B
Date: Wed, 24 May 2023 10:41:53 +0300
Message-Id: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LJ3NUGWKM5RONUV2IB5UZKJCAR77QIOK
X-Message-ID-Hash: LJ3NUGWKM5RONUV2IB5UZKJCAR77QIOK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJ3NUGWKM5RONUV2IB5UZKJCAR77QIOK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series handles a few issues related to the ES8316 audio 
codec, discovered while doing some testing on the Rock 5B board.

Cristian Ciocaltea (3):
  ASoC: es8316: Increment max value for ALC Capture Target Volume
    control
  ASoC: es8316: Do not set rate constraints for unsupported MCLKs
  arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b

 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 ++
 sound/soc/codecs/es8316.c                       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.40.1

