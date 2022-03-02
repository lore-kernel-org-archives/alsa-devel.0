Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FAFC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 01:36:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E006D1913;
	Wed,  2 Mar 2022 02:35:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E006D1913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646185008;
	bh=opmbzsqmBiZ/FFZoI3HXvFp45v3SoeNkJ5Uwxrmt+hQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lLQOgW9xtjprEopBzMm5vSvRHOffDGo7uMa7+YWTT+i2B5nJo/+1XZT6rssH0dxiS
	 dD+ieyIuKDP9JnWcsrL1uiP3rdnLClWrsurcKMcoFJfyrHWijeKU6eup4qD7Czhe+A
	 lZQBenquxMMnd1ycSE6ci5Hm27Mt3K3XPyt/lHfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B1EAF80054;
	Wed,  2 Mar 2022 02:35:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA63DF80227; Wed,  2 Mar 2022 02:35:55 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0783DF80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 02:35:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0783DF80054
X-UUID: 66b5d979f953409ca628dad6f38cac4f-20220302
X-UUID: 66b5d979f953409ca628dad6f38cac4f-20220302
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1145418492; Wed, 02 Mar 2022 09:35:37 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 2 Mar 2022 09:35:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 2 Mar 2022 09:35:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Mar 2022 09:35:35 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>
Subject: [v2] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect to the
 endpoint
Date: Wed, 2 Mar 2022 09:35:33 +0800
Message-ID: <20220302013533.29068-1-jiaxin.yu@mediatek.com>
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

Change from v1:
   fix build error

Hi maintainer,
   Need your comments. The patch is the one that I think it makes the
   most sense. Maybe we can define the new stream_name for
   "bt-sco-pcm-wb" and add the new route.

 sound/soc/codecs/bt-sco.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index 4d286844e3c8..cf17b9741bd8 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -13,11 +13,15 @@
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
 };
 
 static struct snd_soc_dai_driver bt_sco_dai[] = {
-- 
2.25.1

