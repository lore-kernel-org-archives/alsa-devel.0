Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D52C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jul 2023 01:24:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EBA3AE9;
	Mon, 24 Jul 2023 03:23:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EBA3AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690161841;
	bh=2qlq7uUxNq/Q9bKoby1GbgQFSQ7lyi23LUd+35mUoQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IXH1/thowMhF/jMFNyxGLoGdOnsMRwaDMAn1U3s07pHN6RZ2b1i0585thXLv4NAqL
	 4tAfza3F/Vu78sXiJhTodFMmFDFYz2PKBpemRaJSNGRVZT4GH18JhuyXZbtx/Y/qtP
	 e9q2dPPhiZSgbLaWXHalysTXNrk0RnM7QdoyHMF0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1228CF805AB; Mon, 24 Jul 2023 03:22:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AEB41F8057C;
	Mon, 24 Jul 2023 03:22:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E32A7F8057C; Mon, 24 Jul 2023 03:22:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 207E2F8055A
	for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2023 03:22:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 207E2F8055A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qgVSRsJP
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC7D60F12;
	Mon, 24 Jul 2023 01:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A911C433C7;
	Mon, 24 Jul 2023 01:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690161735;
	bh=2qlq7uUxNq/Q9bKoby1GbgQFSQ7lyi23LUd+35mUoQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgVSRsJPkDUtmOQMkwgE/lnLRyaJk8zhGVqOoIpQNwN52cmpS4kgBVwLvAfXXh65Q
	 VfKwVCsEQhE+hgvyeAa3WYXSGZGX1/xOzR3RTG57lC/aiZSb+YqJ7xnwc49lEi5VRo
	 drkJyMGJX/cARpD6zKlL5yGzXWvCRvMuX4dCPvHB+7T8WMUtDxcaasROwiush3zaLX
	 wSkhz8MY85dnM7mntDZm2JeYrYN5/Yj+D/Hq99HQrNwXERkpIR1sw91lwcVEJyFQ7K
	 x0Ychrq3TYT5TrGIoOBE6lYcV2i+e/vV1L31E9KB5GKK73cDRRfsBOPV47z27fkEsA
	 6bZQcIEXnXohA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 15/41] ASoC: Intel: sof_sdw_rt_sdca_jack_common:
 test SOF_JACK_JDSRC in _exit
Date: Sun, 23 Jul 2023 21:20:48 -0400
Message-Id: <20230724012118.2316073-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MMTHKFKZZOQNAAAGXWPGMRPTIIM7KHZP
X-Message-ID-Hash: MMTHKFKZZOQNAAAGXWPGMRPTIIM7KHZP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MMTHKFKZZOQNAAAGXWPGMRPTIIM7KHZP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 526a1876fc48e2d0c0ea8ad63b58bdb2cc13047f ]

if (!SOF_RT711_JDSRC(sof_sdw_quirk)) is tested in rt711_sdca_add_codec_
device_props(), and we don't add software node to the device if jack
source is not set. We need to do the same test in
sof_sdw_rt711_sdca_exit(), and avoid removing software node if jack
source is not set.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230602202225.249209-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
index 7f16304d025be..cf8b9793fe0e5 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
@@ -143,6 +143,9 @@ int sof_sdw_rt711_sdca_exit(struct snd_soc_card *card, struct snd_soc_dai_link *
 	if (!ctx->headset_codec_dev)
 		return 0;
 
+	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
+		return 0;
+
 	device_remove_software_node(ctx->headset_codec_dev);
 	put_device(ctx->headset_codec_dev);
 
-- 
2.39.2

