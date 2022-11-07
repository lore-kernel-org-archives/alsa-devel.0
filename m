Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E0CC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:07:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A6581DB;
	Mon,  7 Nov 2022 17:06:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A6581DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667837242;
	bh=cWcFrxjVwWRyWpHfqO+h4s6yyK8WemwZSSHtSbA6Aew=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HLBKvrHxfpzM/RyIXZKCAHCSAwHDXGcmKlZvpm0yEwRT5fJcITx0uKpD9GI5W5Wmf
	 87dOXW/xHbazEJhflTzqP/KnrUVIi9E3x8GAQbq5Hfs/h3tT8cc+F3VFELdxguYfpW
	 cshynGI8M9xiLbv7jK/VKKf10ZGqomTxpnA2x2QM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0450F8057D;
	Mon,  7 Nov 2022 17:05:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03C5DF8052E; Mon,  7 Nov 2022 17:05:09 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 924BEF80558
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:05:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 924BEF80558
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="caGmBwZ9"
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk
 [167.235.23.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 9482D6602923;
 Mon,  7 Nov 2022 16:05:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667837106;
 bh=cWcFrxjVwWRyWpHfqO+h4s6yyK8WemwZSSHtSbA6Aew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=caGmBwZ9FxdBpYduYe9IVamXR+zFGl3SvC2rT/tF4Pq1KyiVgPZBt+G5AUPR44yXR
 6kPqCJOjWFL+0lycdDmoUWSaLEArIkyG31S6IqvlUqlLKVIrda+KoXJLVYhVgISbqq
 3QiQOrzlHPIJQ5aRTQ6zOMFbMbNewarUl6QkT1034UEAM+uU1acL4pX6c0dcHCB2Fb
 8mZ3vvxGJzP5ggpp9bBrhUPTtAgjJYpaAE4GaBgzo5AGNZ678AKL1oB3EzZl3+3JQJ
 rld7o3VuXIZeTGJJW8MxNn6apulJSK2sOC0AAgUo72bWxCOwnhRN039Dn6itHsFikP
 LnIL4wi+F55lQ==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 6/9] ASoC: mediatek: mt8186-da7219: Register to module device
 table
Date: Mon,  7 Nov 2022 11:04:34 -0500
Message-Id: <20221107160437.740353-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107160437.740353-1-nfraprado@collabora.com>
References: <20221107160437.740353-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, "chunxu.li" <chunxu.li@mediatek.com>,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
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

 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index cfca6bdee834..08ff57f7189c 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -1161,6 +1161,7 @@ static const struct of_device_id mt8186_mt6366_da7219_max98357_dt_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt8186_mt6366_da7219_max98357_dt_match);
 #endif
 
 static struct platform_driver mt8186_mt6366_da7219_max98357_driver = {
-- 
2.38.1

