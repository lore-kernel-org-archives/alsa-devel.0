Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BA7C0015E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jul 2023 08:33:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47F147F4;
	Mon,  3 Jul 2023 10:32:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47F147F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688373204;
	bh=g9hLiJat+dtXzcd2zhhtjEUxB1SI6RvzzK4VEH1nhEk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=oqIDNVyWdD52jGnP2X1d2o7q+RVad/KELUpdO+8J5CUyspIwvsNEI0w+sXDPryudK
	 3ioUtC15GI8rcC8IMeXGxdbX6uurw7Xv6JkAaMdo1gQHWIq+Mk7MRiqqjkC2sKLr9r
	 +LwDKViwc/Q7EZ8DvFByTe5/Tb4/d45x5rzPNO7Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3040F80535; Mon,  3 Jul 2023 10:32:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2AC5F80125;
	Mon,  3 Jul 2023 10:32:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E01BF80246; Fri, 30 Jun 2023 14:04:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52F7DF800E3
	for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2023 14:04:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52F7DF800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DdCvdQpj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0407261730;
	Fri, 30 Jun 2023 12:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69047C433C9;
	Fri, 30 Jun 2023 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688126656;
	bh=g9hLiJat+dtXzcd2zhhtjEUxB1SI6RvzzK4VEH1nhEk=;
	h=From:To:Cc:Subject:Date:From;
	b=DdCvdQpjcPzzD6bDojCti8fnagXcQHzzXrDxTUGCqSFt0f/t1aN6GClYYPMBch45A
	 0noIXvsZXuuHLmISup9G88yZhpXWLHVXSSqFrLIK2PMboCGZ8QeoDuLHdpZqoLvQOe
	 w7ecouI1oH7frM1NgbzO/712nY13RxowM3MUtlPivxxTTRrfvOdy5OlQkqeDU2DSzU
	 bMTEAFVaQKAviE93HsMG2nmosKPGwEIZE9ZOFXjC5U1QXIyMBtWEm8lgo6Nw7uxvFq
	 5Lvb7gxZJAP+sKZfcElMNlZjxT4Gl39kaLeGXaiMkiVq7RPSGrVeNqLt/+gLOzDLcE
	 wjloORClBpiVA==
Received: from johan by xi.lan with local (Exim 4.94.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1qFCrO-0001if-C8; Fri, 30 Jun 2023 14:04:22 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Steev Klimaszewski <steev@kali.org>
Subject: [PATCH] ASoC: codecs: wcd938x: fix codec initialisation race
Date: Fri, 30 Jun 2023 14:03:18 +0200
Message-Id: <20230630120318.6571-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: OBF654437EQNKALM6J6XWF3RXTZIT4JR
X-Message-ID-Hash: OBF654437EQNKALM6J6XWF3RXTZIT4JR
X-Mailman-Approved-At: Mon, 03 Jul 2023 08:32:18 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OBF654437EQNKALM6J6XWF3RXTZIT4JR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Make sure to resume the codec and soundwire device before trying to read
the codec variant and configure the device during component probe.

This specifically avoids interpreting (a masked and shifted) -EBUSY
errno as the variant:

	wcd938x_codec audio-codec: ASoC: error at soc_component_read_no_lock on audio-codec for register: [0x000034b0] -16

when the soundwire device happens to be suspended, which in turn
prevents some headphone controls from being registered.

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e7d6a02cdec0..e3ae4fb2c4db 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3085,6 +3085,10 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 
 	snd_soc_component_init_regmap(component, wcd938x->regmap);
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
 	wcd938x->variant = snd_soc_component_read_field(component,
 						 WCD938X_DIGITAL_EFUSE_REG_0,
 						 WCD938X_ID_MASK);
@@ -3098,6 +3102,8 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			     (WCD938X_DIGITAL_INTR_LEVEL_0 + i), 0);
 	}
 
+	pm_runtime_put(dev);
+
 	wcd938x->hphr_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
 						       WCD938X_IRQ_HPHR_PDM_WD_INT);
 	wcd938x->hphl_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
-- 
2.39.3

