Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02103C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 09:27:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A92C18F2;
	Wed, 16 Feb 2022 10:26:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A92C18F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645003629;
	bh=HscB8rLqhF0KwXPRWcF94aA2kvjTMKa+BKgc1KOFTvE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lye0GW+bXppJGKtX5K73/95ft8iul9PNPWF8yoYvFPDCIUwqqSAxaEw0wr6B/UvKP
	 qapSCqquYn7+fx7sJT0qPWbZQbS9iJSE3OHIuI4YlWh26Sbkk7zFJTZBZLwXmt7fTd
	 mEE7/jizgleqecMBIotmtPTwpY4DuFD9UMNbumcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5EE0F80516;
	Wed, 16 Feb 2022 10:25:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F05FDF8012F; Mon, 14 Feb 2022 07:12:37 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4E29F8012F
 for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2022 07:12:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4E29F8012F
X-UUID: 9a7bd2dcf0dd41049c8f537e789aee7f-20220214
X-UUID: 9a7bd2dcf0dd41049c8f537e789aee7f-20220214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1806270151; Mon, 14 Feb 2022 14:12:24 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 14:12:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 14 Feb 2022 14:12:22 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:12:20 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 23/23] ALSA: hda/realtek: Make use of the helper
 component_compare_dev_name
Date: Mon, 14 Feb 2022 14:08:19 +0800
Message-ID: <20220214060819.7334-24-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Approved-At: Wed, 16 Feb 2022 10:25:43 +0100
Cc: alsa-devel@alsa-project.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 Jeremy Szu <jeremy.szu@canonical.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Werner Sembach <wse@tuxedocomputers.com>, linux-kernel@vger.kernel.org,
 Cameron Berkenpas <cam@neo-zeon.de>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Joerg
 Roedel <joro@8bytes.org>, Takashi Iwai <tiwai@suse.com>,
 Rob Clark <robdclark@gmail.com>, Hui
 Wang <hui.wang@canonical.com>, James Wang <james.qian.wang@arm.com>,
 Yong Wu <yong.wu@mediatek.com>, Sami Loone <sami@loone.fi>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kailang
 Yang <kailang@realtek.com>, srv_heupstream@mediatek.com, Stephen
 Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

Use the common compare helper from component.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jeremy Szu <jeremy.szu@canonical.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Cc: Hui Wang <hui.wang@canonical.com>
Cc: Cameron Berkenpas <cam@neo-zeon.de>
Cc: Kailang Yang <kailang@realtek.com>
Cc: Lucas Tanure <tanureal@opensource.cirrus.com>
Cc: Sami Loone <sami@loone.fi>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 668274e52674..9da004d99cdb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6530,11 +6530,6 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
-static int comp_match_dev_name(struct device *dev, void *data)
-{
-	return strcmp(dev_name(dev), data) == 0;
-}
-
 static int find_comp_by_dev_name(struct alc_spec *spec, const char *name)
 {
 	int i;
@@ -6595,7 +6590,7 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 					      "%s-%s:00-cs35l41-hda.%d", bus, hid, i);
 			if (!name)
 				return;
-			component_match_add(dev, &spec->match, comp_match_dev_name, name);
+			component_match_add(dev, &spec->match, component_compare_dev_name, name);
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
@@ -6644,9 +6639,9 @@ static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const st
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		component_match_add(dev, &spec->match, comp_match_dev_name,
+		component_match_add(dev, &spec->match, component_compare_dev_name,
 				    "i2c-CLSA0100:00-cs35l41-hda.0");
-		component_match_add(dev, &spec->match, comp_match_dev_name,
+		component_match_add(dev, &spec->match, component_compare_dev_name,
 				    "i2c-CLSA0100:00-cs35l41-hda.1");
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
-- 
2.18.0

