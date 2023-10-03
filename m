Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989AFE7AD75
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 16:03:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0B8ADEC;
	Tue,  3 Oct 2023 18:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0B8ADEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696349003;
	bh=h+DtSnVBP12aetOuLOGx+i6/WHFgyH0QPlUwjV6ftMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F0jCRJfpo9bZtYaBt6evKG1TvE+FHWF3npX2keoN8duEz/ZgfygKPu/Lj8UesWkSO
	 dWDjIU8PYGQiNzLTWXgPMRrgp70vHYxqilroC5ihDvVdyin2olBOBOdC9jKm5S6KUs
	 m/7a+ncSefOjeDZw75j6IA9lbqMkw/jpCTG8ExXw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93404F8047D; Tue,  3 Oct 2023 18:02:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 085A4F8047D;
	Tue,  3 Oct 2023 18:02:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92C1FF805AA; Tue,  3 Oct 2023 17:58:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1CAF6F80578
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 17:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CAF6F80578
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XUz7+KZR
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 38B1A612D7;
	Tue,  3 Oct 2023 15:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2BFC433BD;
	Tue,  3 Oct 2023 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696348711;
	bh=h+DtSnVBP12aetOuLOGx+i6/WHFgyH0QPlUwjV6ftMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUz7+KZRCFoct/l8nCvYjB+m1leRF8k2uFxAv9aS8+cjm+ezua3LvXgehxXstGf19
	 4oACJyyU6uy686EARKf5HTrjnLfIQqQ/ooGQtzFifd8W+samAb5P+kKTHlyYCbudii
	 Mgr+dBJ8vPlLyDG2ZGFIxMawrrHYGG/IyZdE09FNuWGuDqdqyHqEmjGq2MWaTnVOjR
	 E7SJWTugAiK6E9Fk55AwjOI15o9iQPiapUqGvlH03Zffvp64LoHReV/JMwv9G5PRiH
	 lzMxsoRLsWJXlSD3XD/BjhsBgxYQzXBfGBz0+mkX/HRkKPWV61c87HbO/Y+LJV3ofL
	 btdrCu7/n7t+w==
Received: from johan by xi.lan with local (Exim 4.96)
	(envelope-from <johan+linaro@kernel.org>)
	id 1qnhnG-000752-1H;
	Tue, 03 Oct 2023 17:58:42 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 7/7] ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on
 probe errors
Date: Tue,  3 Oct 2023 17:55:58 +0200
Message-ID: <20231003155558.27079-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003155558.27079-1-johan+linaro@kernel.org>
References: <20231003155558.27079-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZQOE6NZ7JBY6BE7W4G3ZZEF7QBAJYWWU
X-Message-ID-Hash: ZQOE6NZ7JBY6BE7W4G3ZZEF7QBAJYWWU
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZQOE6NZ7JBY6BE7W4G3ZZEF7QBAJYWWU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Make sure to balance the runtime PM operations, including the disable
count, on probe errors and on driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1baea04480e2..a1f04010da95 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1278,7 +1278,18 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	return component_add(dev, &wcd938x_sdw_component_ops);
+	ret = component_add(dev, &wcd938x_sdw_component_ops);
+	if (ret)
+		goto err_disable_rpm;
+
+	return 0;
+
+err_disable_rpm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return ret;
 }
 
 static int wcd9380_remove(struct sdw_slave *pdev)
@@ -1287,6 +1298,10 @@ static int wcd9380_remove(struct sdw_slave *pdev)
 
 	component_del(dev, &wcd938x_sdw_component_ops);
 
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
 	return 0;
 }
 
-- 
2.41.0

