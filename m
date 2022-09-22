Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233C3ECAAD8
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 00:02:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BAB6E11;
	Fri, 23 Sep 2022 02:01:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BAB6E11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663891339;
	bh=4W7RqvT+c8OW56kJzLV7Sc/CQ72XqC5XURtmz6cKxB8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2pqdic0lC7fINAjYVVgDBOdnFvGYBYuw0U7wvowS+YD36Ltow6JMMFsogIK5V+rh
	 XnNkkbQ4T083+tO34i9wGWW6ToivO7AAMu7/fJtHYf/H7ja9kWZ0zAcifHQ3kb3b+d
	 /McdceFYdxBViMvv8MKwERAzrkqNgX+HviGDHGr8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A234FF80551;
	Fri, 23 Sep 2022 02:00:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 835B4F8054A; Fri, 23 Sep 2022 02:00:14 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ADC9F80107
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2022 02:00:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ADC9F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="cbePx0+8"
Received: from notapiano.myfiosgateway.com (unknown [71.190.76.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D83D56602239;
 Fri, 23 Sep 2022 01:00:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1663891207;
 bh=4W7RqvT+c8OW56kJzLV7Sc/CQ72XqC5XURtmz6cKxB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cbePx0+8KHszAj8rs78HcGfthzz3DzfHTPIWjGNyeo43Y/hJYLTZGfLPhnkBGuZtW
 nABoilHcoJ0h9aDZt9ceefksz44jlR98aYm35A/pp/9K/Q5k1h3kAqZfwlpc/bvnJg
 4HCnO0ybTZ58O97Tuwd+9qLEGhSkriilKwksQ64vx2yC0TfTyu9H0sWZFage0dufsy
 NJhLZlWM6S4txisEGk+NpYwVSVkrGC3rGnkgfZO2SAuTY++VJnN+D8QIaYDm6jyEC4
 bVxYAzCPHGQaIoQEGqZbRwQtOS8xyUSauuJNX3a6FC6xhvIMTi4yvGC11CNe/844s4
 PVHi9P83ylapw==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/6] ASoC: mediatek: mt8186-rt5682: Add headset widgets with
 switches
Date: Thu, 22 Sep 2022 19:59:50 -0400
Message-Id: <20220922235951.252532-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922235951.252532-1-nfraprado@collabora.com>
References: <20220922235951.252532-1-nfraprado@collabora.com>
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

Add DAPM widgets for headphones and headset microphone, with matching
switches, to allow toggling these paths based on the jack connection
status.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 247f20f594d9..4360871bfc44 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -926,6 +926,8 @@ static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
 static const struct snd_soc_dapm_widget
 mt8186_mt6366_rt1019_rt5682s_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_OUTPUT("HDMI1"),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL1, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -937,6 +939,10 @@ static const struct snd_soc_dapm_route
 mt8186_mt6366_rt1019_rt5682s_routes[] = {
 	/* SPK */
 	{ "Speakers", NULL, "Speaker" },
+	/* Headset */
+	{ "Headphone", NULL, "HPOL" },
+	{ "Headphone", NULL, "HPOR" },
+	{ "IN1P", NULL, "Headset Mic" },
 	/* HDMI */
 	{ "HDMI1", NULL, "TX" },
 	/* SOF Uplink */
@@ -952,6 +958,8 @@ mt8186_mt6366_rt1019_rt5682s_routes[] = {
 static const struct snd_kcontrol_new
 mt8186_mt6366_rt1019_rt5682s_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("HDMI1"),
 };
 
-- 
2.37.3

