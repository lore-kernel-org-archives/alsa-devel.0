Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A6606A32F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=mwO/8x78;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckFeieER
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DD65601EE;
	Tue, 17 Nov 2026 20:31:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DD65601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794943891;
	bh=aL2iaHRRDwQJadqhD/d56CXxFjGXW/AUrVxnoihiGZ8=;
	h=From:To:Cc:Subject:Date:Reply-To:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mwO/8x78fRtNjz6h50FOYNiYQPDcQNELg42WBmSanTIkaz5aXdIy4Qlsw3m/U+8fk
	 LMXwHVAwrcclugE1EU2+c+aUZVT4U70eY/9HuUGL8mHqAMUtT5/7KZHa8U7EMTDp/g
	 i5VCIVzU9W8a9byqhjLWCf92AIlqNk6jpSg9MtmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F38FFF805FA; Tue, 17 Nov 2026 20:30:58 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 607BCF805F3;
	Tue, 17 Nov 2026 20:30:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1389FF805A8; Tue, 17 Nov 2026 20:30:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794943851;
	b=RKWIAnzTxLzMazCkkxrTLIjeSemaOaONR7YnOTHac9NNMnlPj44cBFM4EorCD96KdPnR
	 N5jiJI+c+YPQy5zHMFUtzxV9LwE9+SkMjIl9pTZM+wkeukDiiQjcgW928G+ge7NRiM9c/
	 FznOfVUVeX/OieuqplJWgfwlyvRf2AkH7fH0R87yFtybG2cG2hmDk1TIMFNM91ZyxgnHS
	 BwbR3yMGjdAnp4bM+ejS3mjlC6OXIE0JjAgUpjuVaUnd9eU1OjNxQF6RgPTUCwJfZzmUr
	 Kw9rPMdFcOvX2U5eqmHW0PvaWHYFZGH/byAC6c5luazO3GTh4LDfTrQdSt33HiCz9pg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794943851;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aL2iaHRRDwQJadqhD/d56CXxFjGXW/AUrVxnoihiGZ8=;
	b=nMKBh1IjgQFhdsLExsRF4hCVSe5jMYC41SdB5W3qQVCVWSfnSbbUCeogiR6/s1/K51JM
	 mFCSAXNiPtXVkhKJfhdP3PuOtLVqTDmQV6K/Fd25bdyLAH4d50h5KHAuqt0+pnmdZgd2p
	 ri2gwt5dQFs+L7PupNvA9iqRgMTEL3BR/0QA6fp3nrueFk+zWaF/zVy/xsVQsKGnOgssa
	 fwncw3m83DpJEQ2MJ932aAF0KAjVcMrsifo6xQrfweI+N9mv5bLZ9D6gY+gw1o39lfuGn
	 mSPe8Fn8wO0t767hm0Y1gHRoyowKTmZR5M9wTax3aB8l9KRcziZQK8aoowFmzKrvlrQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ckFeieER;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AD93CF80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 20:30:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD93CF80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ckFeieER
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F177061258;
	Tue, 17 Nov 2026 19:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA681F000C4;
	Tue, 17 Nov 2026 19:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794943846;
	bh=cHitRilK3/c8/LMMqcQQrmcC+1rbexk23ra6FUWCYzI=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=ckFeieERHQP/AjSAwp+Zkuj9G6rSGcqd0F3xaGqkyQNycTUi8nx2puBOYnnmX2fiv
	 IshJdj6fXaOrJEfWAynu4koGreTv+S9K9PBsgcOcTsD1QniDSbDxEoR4mITEHqGYPh
	 5t3fjqfeV86w22bdm33RvrhyGTSY8h9qxTB69VZFNfeeLW77QGS7ADhpPPe8G1qIm6
	 vhLjDijMFfd1tbX8wgrk3qLYe+KoxzABCNEzpEvSPdSqB314SDwaY7jFiOwt60pUqJ
	 CcHDcE2hFKHEsfsoJ85OAVF4UKCmV/9A9+SRcWb+JTKlxBF0iOxsl8my8qMN+O/Vjf
	 rWHeY6yL0hA4w==
From: Sasha Levin <sashal@kernel.org>
To: stable-commits@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Patch "ASoC: mt8192: Remove function name log messages" has been
 added to the 5.15-stable tree
Date: Tue, 17 Nov 2026 14:30:44 -0500
Message-ID: <20261117193044.2331159-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4E3ZGY3TUBGK6VJ34UL5Q2Z2XMZSKN7Y
X-Message-ID-Hash: 4E3ZGY3TUBGK6VJ34UL5Q2Z2XMZSKN7Y
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
Reply-To: stable@vger.kernel.org
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4E3ZGY3TUBGK6VJ34UL5Q2Z2XMZSKN7Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

This is a note to let you know that I've just added the patch titled

    ASoC: mt8192: Remove function name log messages

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-mt8192-remove-function-name-log-messages.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 7b9983c639e12379afb18a9c87a804748e72409e
Author: Nícolas F. R. A. Prado via Alsa-devel <alsa-devel@alsa-project.org>
Date:   Mon Mar 13 17:29:06 2023 -0400

    ASoC: mt8192: Remove function name log messages
    
    [ Upstream commit f147ca85d6ecaf65106d1650f3c2e8afacbc833f ]
    
    There are some log messages in the mt8192 sound code that print the
    function name, presumably to aid in tracing. However this can also be
    achieved by ftrace and without spamming the console, so remove these
    messages.
    
    Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
    Link: https://lore.kernel.org/r/167874298172.26.17917791030607314817@mailman-core.alsa-project.org
    Signed-off-by: Mark Brown <broonie@kernel.org>
    Stable-dep-of: d6c8a0b5bf69 ("ASoC: mediatek: mt8192-mt6359: Fix error handling in MTKAIF calibration")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-clk.c b/sound/soc/mediatek/mt8192/mt8192-afe-clk.c
index c26f68ec6040f..9b9a3465ddb52 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-clk.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-clk.c
@@ -216,8 +216,6 @@ int mt8192_afe_enable_clock(struct mtk_base_afe *afe)
 	struct mt8192_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
-	dev_info(afe->dev, "%s()\n", __func__);
-
 	ret = clk_prepare_enable(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
 	if (ret) {
 		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
@@ -296,8 +294,6 @@ void mt8192_afe_disable_clock(struct mtk_base_afe *afe)
 {
 	struct mt8192_afe_private *afe_priv = afe->platform_priv;
 
-	dev_info(afe->dev, "%s()\n", __func__);
-
 	clk_disable_unprepare(afe_priv->clk[CLK_AFE]);
 	mt8192_set_audio_int_bus_parent(afe, CLK_CLK26M);
 	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index dd325ce6aaa81..13e0ed6f11ba5 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2055,8 +2055,6 @@ static int mt8192_afe_runtime_suspend(struct device *dev)
 	unsigned int value;
 	int ret;
 
-	dev_info(afe->dev, "%s()\n", __func__);
-
 	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
 		goto skip_regmap;
 
@@ -2097,8 +2095,6 @@ static int mt8192_afe_runtime_resume(struct device *dev)
 	struct mt8192_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
-	dev_info(afe->dev, "%s()\n", __func__);
-
 	ret = mt8192_afe_enable_clock(afe);
 	if (ret)
 		return ret;
diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index dfb125ad37e65..e3a8273159d2f 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
@@ -762,8 +762,6 @@ int mt8192_dai_tdm_register(struct mtk_base_afe *afe)
 	struct mtk_afe_tdm_priv *tdm_priv;
 	struct mtk_base_afe_dai *dai;
 
-	dev_info(afe->dev, "%s()\n", __func__);
-
 	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
 	if (!dai)
 		return -ENOMEM;
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index c1d225b498513..fca228ea781b3 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -142,8 +142,6 @@ static int mt8192_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	int counter;
 	int mtkaif_calib_ok;
 
-	dev_info(afe->dev, "%s(), start\n", __func__);
-
 	pm_runtime_get_sync(afe->dev);
 	mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA, 1);
 	mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA, 0);
