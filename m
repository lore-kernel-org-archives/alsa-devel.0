Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07238606A31B
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=GYTLrVeK;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=hHF+5r7+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6885160238;
	Fri, 23 Oct 2026 09:10:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6885160238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739446;
	bh=yJ9VzWJnjsUlDkFPUvQPh9MrxtG0IxT1EMet2uY3ExE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GYTLrVeK9os0joMh2TRmJJ0PUENv0IRRaai7t8jmozD5On+8KN+1/clhmi+YHu0f6
	 MbShgR93Oo7pv2r1iI0fJ+q7oFPvawfP8FOcSobNP831HDAnzSSwNj3wUS2/HSLcfF
	 nVmJ5lMWmzQXwPi5PN0/fSUOrS7VsOAhfqYdvac8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 294AEF806DA; Fri, 23 Oct 2026 09:08:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 00D01F806D6;
	Fri, 23 Oct 2026 09:08:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F0B3F800B6; Wed, 21 Oct 2026 18:57:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru
 [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 11E7FF80087
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:57:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11E7FF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=astralinux.ru header.i=@astralinux.ru
 header.a=rsa-sha256 header.s=mail header.b=hHF+5r7+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792403914;
	bh=yJ9VzWJnjsUlDkFPUvQPh9MrxtG0IxT1EMet2uY3ExE=;
	h=From:To:Cc:Subject:Date:From;
	b=hHF+5r7+w4YGYV4lUvq5aO6JxxF4g7nYspPiRaBPa2bqLL2ju4wMoKrE6qd9V7oTq
	 FVP4RGst5YiMfQ1eHwwETmQYeyhIzsNiBNTj9KEXv+a52VamFS2EnwRsoJBAqhhn8V
	 wrbHDBeGOCfh5+NltBGwGWenjmfogkek9KWkPTdD9ajmlFzp59IwvCLQBvn0ZD7V0g
	 Uc1KmrbllGBAzyGmExGNwvESnN15/CAccXabM+6yDzP0ftA2fikwmV8McGj4ImXb6S
	 RiL2ezkI1yQ1cNWu39uTtqvvx9hIho+SiP4Ou/RyyY39YoaciGZrNmoo/B/FH4Wl9t
	 jIK7m5OAFQ49Q==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 36FFE259D9;
	Mon, 19 Oct 2026 12:58:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 19 Oct 2026 12:58:33 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.51.9])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j7VqS2cWnzDhp;
	Mon, 19 Oct 2026 12:39:00 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 5.10] ASoC: stm32: sai: fix OF node leak on probe
Date: Mon, 19 Oct 2026 12:38:27 +0300
Message-ID: <20261019093829.1428-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/19 08:08:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127
 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld},
 {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to},
 patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2,
 FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206789 [Oct 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2026/10/19 08:59:00 #28702808
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/19 08:08:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-MailFrom: mdmitrichenko@astralinux.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LSNM6EKNQGXVUFWFIZK2C4AVWFLFVLUB
X-Message-ID-Hash: LSNM6EKNQGXVUFWFIZK2C4AVWFLFVLUB
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LSNM6EKNQGXVUFWFIZK2C4AVWFLFVLUB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Johan Hovold <johan@kernel.org>

commit 23261f0de09427367e99f39f588e31e2856a690e upstream.

The reference taken to the sync provider OF node when probing the
platform device is currently only dropped if the set_sync() callback
fails during DAI probe.

Make sure to drop the reference on platform probe failures (e.g. probe
deferral) and on driver unbind.

This also avoids a potential use-after-free in case the DAI is ever
reprobed without first rebinding the platform driver.

Fixes: 5914d285f6b7 ("ASoC: stm32: sai: Add synchronization support")
Fixes: d4180b4c02e7 ("ASoC: stm32: sai: fix set_sync service")
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: stable@vger.kernel.org      # 4.16: d4180b4c02e7
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20251124104908.15754-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2025-71081
 sound/soc/stm/stm32_sai.c     | 12 +++---------
 sound/soc/stm/stm32_sai_sub.c | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index df167c389b98..026321620a20 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -122,7 +122,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
 			"Device not found for node %pOFn\n", np_provider);
-		of_node_put(np_provider);
 		return -ENODEV;
 	}
 
@@ -131,21 +130,16 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!sai_provider) {
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
-		ret = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	/* Configure sync provider */
-	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
-
-error:
-	of_node_put(np_provider);
-	return ret;
+	return stm32_sai_sync_conf_provider(sai_provider, synco);
 }
 
 static int stm32_sai_probe(struct platform_device *pdev)
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 962e5606c2c9..325089a20872 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1440,7 +1440,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"External synchro not supported\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 			sai->sync = SAI_SYNC_EXTERNAL;
 
@@ -1449,7 +1450,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			    (sai->synci > (SAI_GCR_SYNCIN_MAX + 1))) {
 				dev_err(&pdev->dev, "Wrong SAI index\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 
 			if (of_property_match_string(args.np, "compatible",
@@ -1463,7 +1465,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			if (!sai->synco) {
 				dev_err(&pdev->dev, "Unknown SAI sub-block\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 		}
 
@@ -1473,13 +1476,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 	of_node_put(args.np);
 	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
-	if (IS_ERR(sai->sai_ck))
-		return dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
-				     "Missing kernel clock sai_ck\n");
+	if (IS_ERR(sai->sai_ck)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
+				    "Missing kernel clock sai_ck\n");
+		goto err_put_sync_provider;
+	}
 
 	ret = clk_prepare(sai->pdata->pclk);
 	if (ret < 0)
-		return ret;
+		goto err_put_sync_provider;
 
 	if (STM_SAI_IS_F4(sai->pdata))
 		return 0;
@@ -1501,6 +1506,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+err_put_sync_provider:
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1571,6 +1578,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1583,6 +1591,7 @@ static int stm32_sai_sub_remove(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	of_node_put(sai->np_sync_provider);
 
 	return 0;
 }
-- 
2.43.0

