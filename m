Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF5FC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 23:48:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74FDA5E1D;
	Fri, 21 Oct 2022 01:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74FDA5E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666309709;
	bh=J4wHPtfry2OsTd4bhGIrr3Nrp52OQCpiduMCJPr0MBw=;
	h=Resent-From:Resent-Date:Resent-To:From:To:Date:Subject:
	 In-Reply-To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=jZQyH1GdyxR2TRbsfNAS5qP7BAfqMUxRqsHocn2CuZYNcvO+ibBEbIICRrP4lf2wt
	 FD6W8vB3zHJNDXrE6B/o9huvFK1hhWUcSmy0iUfSNqcn/bBFoHSbzZfv4UWPKERenJ
	 M8YGbszToKAsVACuGjCfBgVpBvkDSd2xXTbxNR8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 289ADF8032B;
	Fri, 21 Oct 2022 01:47:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99F90F804D8; Fri, 21 Oct 2022 01:47:37 +0200 (CEST)
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9347BF80137
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2022 01:47:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9347BF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=angband.pl header.i=@angband.pl
 header.b="CM07kka2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl; 
 s=tartarus;
 h=In-Reply-To:Subject:Date:To:From:Resent-To:Resent-Message-ID:
 Resent-Date:Resent-From:Sender:Reply-To:Message-ID:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Sender:Resent-Cc:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/vzjjUMvm1iD6dPYFRvooGGdAa5BvFtoRHD72sg2mYc=; b=CM07kka2mro8o2oKglgaan75+r
 ZlFQZm1cNyoEKErlot5Adc+GeENhxxov5kRMrsS7QOS3nJhGIHeqXeYwfM7KsHhKESZfOHx7X+HA+
 6HuM86nSgbf9Xxuhtb4dgumPkxmMuWZmhMLamehjRYIStO5RlouWuds+cJl1UZdg8tUI=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
 (envelope-from <kilobyte@angband.pl>)
 id 1oleGM-009OYu-SI; Fri, 21 Oct 2022 00:43:42 +0200
Resent-From: Adam Borowski <kilobyte@angband.pl>
Resent-Date: Fri, 21 Oct 2022 00:43:42 +0200
Resent-Message-ID: <Y1HPHojilsEi5oln@angband.pl>
Resent-To: Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
From: Adam Borowski <kilobyte@angband.pl>
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Date: Wed, 14 Sep 2022 22:06:51 +0200
Subject: [PATCH 1/6] ASoC: mediatek: mt8186: fix an "unused" warning
In-Reply-To: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
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
Message-ID: <20220914200651.DDy0fHMCqvZpWNWcdPlaPgXiFQH7l4FBZGWObeEcDtQ@z>

This, and a whole bunch of referenced functions are not needed without
CONFIG_OF.  The warning makes the build fail under CONFIG_WERROR.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c | 2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index cfca6bdee834..b15e97bd9d4d 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -1000,7 +1000,7 @@ mt8186_mt6366_da7219_max98357_controls[] = {
 	SOC_DAPM_PIN_SWITCH("HDMI1"),
 };
 
-static struct snd_soc_card mt8186_mt6366_da7219_max98357_soc_card = {
+static __maybe_unused struct snd_soc_card mt8186_mt6366_da7219_max98357_soc_card = {
 	.name = "mt8186_da7219_max98357",
 	.owner = THIS_MODULE,
 	.dai_link = mt8186_mt6366_da7219_max98357_dai_links,
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 2414c5b77233..22ce2f849909 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -976,7 +976,7 @@ mt8186_mt6366_rt1019_rt5682s_controls[] = {
 	SOC_DAPM_PIN_SWITCH("HDMI1"),
 };
 
-static struct snd_soc_card mt8186_mt6366_rt1019_rt5682s_soc_card = {
+static __maybe_unused struct snd_soc_card mt8186_mt6366_rt1019_rt5682s_soc_card = {
 	.name = "mt8186_rt1019_rt5682s",
 	.owner = THIS_MODULE,
 	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
-- 
2.37.2.609.g9ff673ca1a

