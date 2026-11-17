Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC1606A31C
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=dj6NnTTK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIvXkd20
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1B31601F3;
	Tue, 17 Nov 2026 19:51:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1B31601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794941490;
	bh=ccKUF3QsOfYvLeTaHk9GGtzs8aPFmhjRWCtrc4j0w6A=;
	h=From:To:Cc:Subject:Date:Reply-To:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dj6NnTTK83ArmxWOlcTGCm8hpYz5xt+Mirpv0NU0K7nZNF6uneAoLF+lNosmzfwR0
	 E1MnZnGkqhbGML5ZcUMxT1RMktCRGFOLUajnWOXhSQR+ogoxniB+VW4iAENhLoQKDM
	 CgIWJRP9RL2sWbJ1Pi5fpoBx3CO8MR6NpPRvRV0w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48437F80601; Tue, 17 Nov 2026 19:50:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 96AF3F80600;
	Tue, 17 Nov 2026 19:50:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E09A3F805A8; Tue, 17 Nov 2026 19:50:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794941445;
	b=bkXrmgZeeEhct6tCDSgIoTEYzpGi505PVygXwEaN1U7ELp+I1VnliuQmNQAGI6qIQaCC
	 abChsEcbxyGm4fCTUzK6HgUB/ieccOePZysOP/bJo4pci7Kj2UEcsIcxfRa+X65ibsDj6
	 0rshMFK61vdgbuo9IwZnLeFoEF6NFNMAxYmG2RDthbNcVwLuapDjVkilAHAhcPItodYXg
	 j/P02CI/VVycHQkjTGreTAGkhma7FgsSjOl6L03diIaQM+jKoyABIevfOBYCoC8f4YrRY
	 w6JIgGiODrLv47kB23T74L9XRITE59x1pQt9+TC+lz0wahGku9/vB62sEG8Y0hgodwQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794941445;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ccKUF3QsOfYvLeTaHk9GGtzs8aPFmhjRWCtrc4j0w6A=;
	b=MnF0iRx6j3bfxXtnvTsDyrrp8ggrQCj6esLxpsbp5ezmciGLTRM0BB8LUpZNyNji9Nae
	 uQqRfo8OJTiARGUr9BQddmDHq2Drh6ucoIXnzD4x8EEhUXNW50s297KAdJmLy06dIk9Cj
	 qUPyyMuvYvlKpAFjPxgc3x2Ars11nsA45A7RekuQLcJshjFheVhdFqX2OhVKsBcsZugCK
	 HVlIdLGz/cRO6o8BVsO0F40f9khxnPe3E4aPzs2/RhiRkixw/oo0BKayY1dxFx6/4inNx
	 3cUwAXLfYZ9UF/q3HfOJdSKbjyFXzON0lDcB6BURW6V8DL1b3PCSQKmU8nk/rj8zLJA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aIvXkd20;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B344F80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 19:50:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B344F80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aIvXkd20
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6EAF261168;
	Tue, 17 Nov 2026 18:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504601F000C4;
	Tue, 17 Nov 2026 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941441;
	bh=Oiz1/PrrY7G4fbL9Iv/k6bnwMa9SlGBMQGHq8JRyYUY=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=aIvXkd20G+YU6ohVvUw35lWAXQFJuBTtwhXzBUjLuM+quiHWYfrq7EK8SS1YiIXGw
	 Lsit7+NcsULnXDrKXf7EHLApwrGd54dhJnme/KnQyNmyb5fNQxpK7ZuSocyc2OHAQH
	 3WFgVLKiykq60osMA4vyVRRkEu72kxG2IIbZFxODxwdqyLPyOfhQvR4tgrwVpTILwC
	 888BQ46mzhCZ7DpMeZ3GfzsQTzxlmCs6ZDxLRSYPSb4USYhhdSBT8Ld3+ppPRJLoNt
	 iH9c4O8Yzl8dBFQ04PFNc9Rwdz6zDEJQoxog0ikTwS0ezqmyz72M3YcqnZAgwk4mg+
	 Ytix/7f4tKouQ==
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
 added to the 6.1-stable tree
Date: Tue, 17 Nov 2026 13:50:38 -0500
Message-ID: <20261117185039.2284794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AVMUTKFNTEQF6FG5YDZGXXENDWAKVDJU
X-Message-ID-Hash: AVMUTKFNTEQF6FG5YDZGXXENDWAKVDJU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AVMUTKFNTEQF6FG5YDZGXXENDWAKVDJU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

This is a note to let you know that I've just added the patch titled

    ASoC: mt8192: Remove function name log messages

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-mt8192-remove-function-name-log-messages.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 21437085909705ae735f2d5ebe2c4b7303bc4cc3
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
index 95b1ea63cc722..b324e82afd4c0 100644
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
index b93c3237ef2d6..6dedcc7aa68cb 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -161,8 +161,6 @@ static int mt8192_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	int counter;
 	int mtkaif_calib_ok;
 
-	dev_info(afe->dev, "%s(), start\n", __func__);
-
 	pm_runtime_get_sync(afe->dev);
 	mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA, 1);
 	mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA, 0);
