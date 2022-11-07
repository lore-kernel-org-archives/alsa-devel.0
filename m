Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610DCC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:07:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7612BE0F;
	Mon,  7 Nov 2022 17:06:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7612BE0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667837249;
	bh=oiakfK/KyQsyZ8dFT+n7UDDhSpuPj6+i0VVZ4ScGBTI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cui9i7LVrjgamP6gSv0utDOjp0r/+EgpMYT90ru4lKC6GrJKyNesGAr/3wFTdB1Sb
	 XBMllABqJq8rSWNSv5kTuiqJl3x+6G1KYWIIyWiyiBv6jAeC9GPbhz40xxPa7n7/9+
	 Pegatikizi7qqX0NSbPWyujbKOJoO+4bUxsOLmXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DFADF8057B;
	Mon,  7 Nov 2022 17:05:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A652CF80589; Mon,  7 Nov 2022 17:05:16 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D569F8057B
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:05:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D569F8057B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="LM/BCzWm"
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk
 [167.235.23.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DC6E66028EA;
 Mon,  7 Nov 2022 16:05:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667837109;
 bh=oiakfK/KyQsyZ8dFT+n7UDDhSpuPj6+i0VVZ4ScGBTI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LM/BCzWmyL7gjkAmc0cyLFYZ1P0pS7/pjWtsKAY1HMsJpA6WgBVb+urgQitu/VU4u
 omJw2s0ZEPP/E2KuLjbTGPAeyC4a1FifCx5JR8Thk3ysT6DDUG3uT5w9yIMKWqOKk7
 4zqVYg/4kAB0wy3FHcDuPvnVnMV80l9YN1YIgRa0BhqBS1kg5vgsVltc0sAtcvCNc7
 1dvfcngzV2ySfNd9xVB2bKbAYJ/7theAvhcAEmM4UeMarPjb0Kl8YDfW4vmvZd42Ps
 UFTraaqOseeMJLMkS+r+jeerKMtOXvC1qNnQyAN/CQUV5BvOtDV88sXmOJ1FlmH8u6
 VCzh5kLnklrlw==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 7/9] ASoC: mediatek: mt8186-rt5682: Register to module device
 table
Date: Mon,  7 Nov 2022 11:04:35 -0500
Message-Id: <20221107160437.740353-8-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107160437.740353-1-nfraprado@collabora.com>
References: <20221107160437.740353-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, "chunxu.li" <chunxu.li@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Register the compatibles for this module on the module device table so
it can be automatically loaded when a matching device is found on the
system.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 16d834f3153d..e59d92e2afa3 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -1237,6 +1237,7 @@ static const struct of_device_id mt8186_mt6366_rt1019_rt5682s_dt_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt8186_mt6366_rt1019_rt5682s_dt_match);
 #endif
 
 static struct platform_driver mt8186_mt6366_rt1019_rt5682s_driver = {
-- 
2.38.1

