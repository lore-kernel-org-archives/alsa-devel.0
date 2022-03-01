Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E80BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Mar 2022 17:12:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE9591A28;
	Tue,  1 Mar 2022 18:12:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE9591A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646154774;
	bh=sCZXFcBAwo2Vev/0iPuFwyhNDq/Nfeq2nktdBj4Aj/E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fmX3PfDYWZAtYXY4E6Qbs8hgeAa6TkKLkjd5nrIQfaMNzEWFRu7dPgsj1IsgDMzLs
	 knIJrAIBNFTVytBLJuEESZAJeKv8uLA2N/wKN/klA/akmDihbH8zl1EIkfIN0iyVPz
	 zFXrEAF5uv47LJIMlj6+UtbD6jn+Fd6yct3IkpVY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75155F801D8;
	Tue,  1 Mar 2022 18:12:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E171CF80227; Tue,  1 Mar 2022 18:12:01 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D81BF80167
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2022 18:11:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D81BF80167
X-UUID: 324a8ac07c6e4322b7abfc1e2e63fe3b-20220302
X-UUID: 324a8ac07c6e4322b7abfc1e2e63fe3b-20220302
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 953268586; Wed, 02 Mar 2022 01:11:48 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 2 Mar 2022 01:11:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 2 Mar 2022 01:11:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Mar 2022 01:11:40 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect to
 the endpoint
Date: Wed, 2 Mar 2022 01:11:37 +0800
Message-ID: <20220301171137.27442-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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

This patch fix the second dai driver's dai widget can't connect to the
endpoint. Because "bt-sco-pcm" and "bt-sco-pcm-wb" dai driver have the
same stream_name, so it will cause they have the same widget name.
Therefor it will just create only one route when do snd_soc_dapm_add_route
that only find the widget through the widget name.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---

Hi maintainter,

   Need your comments. The patch is the one that I think it makes the
   mose sense. Maybe we can define the new stream_name for
   "bt-sco-pcm-wb" and add the new route.

 sound/soc/codecs/bt-sco.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index 4d286844e3c8..578f9df2a25e 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -13,11 +13,16 @@
 static const struct snd_soc_dapm_widget bt_sco_widgets[] = {
 	SND_SOC_DAPM_INPUT("RX"),
 	SND_SOC_DAPM_OUTPUT("TX"),
+	SND_SOC_DAPM_AIF_IN("BT_SCO_RX", "Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("BT_SCO_TX", "Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route bt_sco_routes[] = {
-	{ "Capture", NULL, "RX" },
-	{ "TX", NULL, "Playback" },
+	{ "BT_SCO_TX", NULL, "RX" },
+	{ "TX", NULL, "BT_SCO_RX" },
+};
 };
 
 static struct snd_soc_dai_driver bt_sco_dai[] = {
-- 
2.25.1

