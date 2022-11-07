Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73483C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:06:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD155100;
	Mon,  7 Nov 2022 17:05:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD155100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667837209;
	bh=6e+FTGnofEIDKPnZbwTaHwcFF/WfbgxLV2zu73jrm6A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZpicKKv8noMrfqP3ThmZeJBNY6Jg0LQcp9R+ZFn95VJoVuo4xWX417cjLgHU076+f
	 W8I+NrPbVOvsp50AMm4G0NXm/goIKbafrSULkEiAD/dDQLQQ0jWJ+CsFrO3wtC/LE0
	 WRppm1pOo5ElmxiXu6+tRU95CYvFZwXh5pmYOTwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79B7FF80571;
	Mon,  7 Nov 2022 17:05:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0749DF80558; Mon,  7 Nov 2022 17:05:07 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F2B4F80558
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:05:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F2B4F80558
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="Ko8MDotx"
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk
 [167.235.23.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 39E5666028CF;
 Mon,  7 Nov 2022 16:04:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667837099;
 bh=6e+FTGnofEIDKPnZbwTaHwcFF/WfbgxLV2zu73jrm6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ko8MDotxBxiWM5iLzn6IsAs0/irCdcBDSsmMnPto0h/bDRHLRk6kjIXjNZM4J2dPh
 HhxNX/XTVSo4bB8c4H2LchIqFLyi1Hvz35vomiSJk6PYZwThBT1VVQsSxot0bQGfnw
 L793bSeigogCitsw/HGmuK1OkWMfhp+vO+kIMkd21k0AkW73CN/SDcpoDwdzQsLERQ
 /zbdYClYadgLzqjjYTVnwupaArcI8v9GlPql5eyyZam8hqeSLOc+FdZKSpoT4NmjcM
 bZKP3ckLnGiuZSiPUzn9bJ6dFgzsNypnn97MyAAP2fLskY1Rw7NfGa8iyMhQ8vAGrV
 idxXMVxkXdHMg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/9] ASoC: mediatek: mt8183-da7219: Register to module device
 table
Date: Mon,  7 Nov 2022 11:04:32 -0500
Message-Id: <20221107160437.740353-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107160437.740353-1-nfraprado@collabora.com>
References: <20221107160437.740353-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Miaoqian Lin <linmq006@gmail.com>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-mediatek@lists.infradead.org,
 Akihiko Odaki <akihiko.odaki@gmail.com>,
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 9f22d3939818..0e572fe28c58 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -842,6 +842,7 @@ static const struct of_device_id mt8183_da7219_max98357_dt_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt8183_da7219_max98357_dt_match);
 #endif
 
 static struct platform_driver mt8183_da7219_max98357_driver = {
-- 
2.38.1

