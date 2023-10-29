Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DCBC4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Oct 2023 23:01:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6560CDEC;
	Mon, 30 Oct 2023 00:00:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6560CDEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698620475;
	bh=6f08pzcovKZTGn6aZpAyBL6OCiu5ckqlVg/z8CmfMJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mk4kr/VuasxtdBIdMSVpuXfLM1M7or+L/D3VWPnYFE1zk1F9rSI8jVkIeswBneAlw
	 XfQggIYmEtteJMVtNPmLVB9/uYtw8lTkuoHpkc+YW/AY3s6Qvl+GTHdAIJUcSZ/fyn
	 DlYlxFGaBUFS/BbnrFpxW/2B4UR4y/kD8tw7RCyQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89ADFF80579; Sun, 29 Oct 2023 23:59:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9980CF80580;
	Sun, 29 Oct 2023 23:59:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1705AF80580; Sun, 29 Oct 2023 23:59:46 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0255EF8055C
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2023 23:59:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0255EF8055C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TOqNcB2N
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 907AFB8069E;
	Sun, 29 Oct 2023 22:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA99C04E60;
	Sun, 29 Oct 2023 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620382;
	bh=6f08pzcovKZTGn6aZpAyBL6OCiu5ckqlVg/z8CmfMJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOqNcB2NT7bT/xJuXk0bLC+40vwQ0WkfGFlpMX8dZHXai9xb+yG/qKsHWfyFVa/ph
	 DzsFU0ujvMUxxBZMeGEUo6FzQ51/ZYZKlioMjg0PET4GwjF4Ux9pJD+FcpXA4uzCXS
	 X4lp3xQUSDXVqCd+mrYJrSpFTyf9HWQvWnZrRGgsi0QxD4iXFRvj9MaBj1aYb9otz8
	 QVeyawCTl419U6MR7NTSZ87jXPrZ+XCj1sFYRRq4JOi0SvN6GEINu32uyVJ0prIoMx
	 MLVf8sBLuIXzcVUvju/sCTlZARTn11SVJ/d57mB42AygBdfffYKOrgYjeXJnB84At5
	 gZiTxvWtUI0Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuming Fan <shumingf@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 18/28] ASoC: rt5650: fix the wrong result of key
 button
Date: Sun, 29 Oct 2023 18:58:53 -0400
Message-ID: <20231029225916.791798-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AVU2VPSMEO45NWDRFKQCU6C6P5K375B4
X-Message-ID-Hash: AVU2VPSMEO45NWDRFKQCU6C6P5K375B4
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AVU2VPSMEO45NWDRFKQCU6C6P5K375B4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit f88dfbf333b3661faff996bb03af2024d907b76a ]

The RT5650 should enable a power setting for button detection to avoid the wrong result.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20231013094525.715518-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8ea6d43335626..385f2cca939a0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3251,6 +3251,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
-- 
2.42.0

