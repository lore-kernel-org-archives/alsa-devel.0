Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67713E7AD74
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 16:04:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58A6EE80;
	Tue,  3 Oct 2023 18:03:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58A6EE80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696349049;
	bh=0qc7/9y/unJJylgNAX3JbS8b4NM02Ln9LHqplyR4wyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i4YyHFuN3uXJTxMs73/gVBEERY6jSFCeu4EVBwT10GVbPQah+6OqHaOYWlbzUTmyO
	 f0gF167Zg4OHwFHFV08A87s3AQYbt/r29JGBKl2EgYCpZvwNM988Tju5C/ZhElDJZF
	 jAcWhCmf5d22sB4MgLJbRTEZNmPRtKvtiJcOw2iQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B97E3F8057B; Tue,  3 Oct 2023 18:02:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25F0BF8057B;
	Tue,  3 Oct 2023 18:02:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 224A4F8047D; Tue,  3 Oct 2023 17:59:29 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0AE01F80549
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 17:58:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AE01F80549
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=I/uNHvQs
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C3DDC612CC;
	Tue,  3 Oct 2023 15:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E279DC433CC;
	Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696348710;
	bh=0qc7/9y/unJJylgNAX3JbS8b4NM02Ln9LHqplyR4wyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/uNHvQsrULhHsQWc04qSOzIBUXExGDZ4pciHPiv2KV5h6AgsAi2a8IfizwFLrUaj
	 WAv+yqUyQj0XpaLVX96MhM4imcZ0susNTT7GGTogrCIio/+MhDU2KUaLpejxWpBRCD
	 OxDCnn6A3KQjuAfUAYUu2S2yG5A78yy8MvUvLXxTwNLk+fAjoIwD1sDcXs6+vES5U/
	 ADFo/sjBsipBAjVUPMYWdbBGKiJG2NxoSzgW8vDilA52fmH2+ujNbwdzwqpOfRbEIx
	 C5xFZe8Jst6b0gXhmJOT7e/abhVkk4FZ2xpXgupMtHxSY/AtpU6nbC8PnQg3Jet29H
	 wb1OP+QBLe+qQ==
Received: from johan by xi.lan with local (Exim 4.96)
	(envelope-from <johan+linaro@kernel.org>)
	id 1qnhnG-00074w-0q;
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
Subject: [PATCH 5/7] ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
Date: Tue,  3 Oct 2023 17:55:56 +0200
Message-ID: <20231003155558.27079-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003155558.27079-1-johan+linaro@kernel.org>
References: <20231003155558.27079-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QSOARVQG2VIWZMVAVDG4OTS4ISTH6EXV
X-Message-ID-Hash: QSOARVQG2VIWZMVAVDG4OTS4ISTH6EXV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QSOARVQG2VIWZMVAVDG4OTS4ISTH6EXV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Make sure to balance the runtime PM operations, including the disable
count, on driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 679c627f7eaa..d27b919c63b4 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3620,9 +3620,15 @@ static int wcd938x_probe(struct platform_device *pdev)
 
 static void wcd938x_remove(struct platform_device *pdev)
 {
-	struct wcd938x_priv *wcd938x = dev_get_drvdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
+
+	component_master_del(dev, &wcd938x_comp_ops);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 
-	component_master_del(&pdev->dev, &wcd938x_comp_ops);
 	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }
-- 
2.41.0

