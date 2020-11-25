Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF3C56202
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:54:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D649206D8
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DFornoAg";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="edghX3QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D649206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E8AF17E9;
	Wed, 25 Nov 2020 17:53:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E8AF17E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606323267;
	bh=P+vy5VoZ2F85soXfnFUh9AixDyXElRDgch2cjs4F6Is=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFornoAgruzCmTR54nLn5/Br4ldkm5GaoX8+QKKPgObqyPWTcvnJc6G9ieRTrNk+z
	 s36HcIWY3BM2WR4dG/g5/qMeVtt6GAE0bqiuDEEaa4ElMVqQ+HMprKauKzZZ5Q/M4h
	 Hl6SpEMvXHnIRFXm0U6SlHfmhadSYkmKfMBchI9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD017F8056F;
	Wed, 25 Nov 2020 17:46:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 381BFF80570; Wed, 25 Nov 2020 17:46:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77557F80568
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 17:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77557F80568
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="edghX3QE"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 16C84206D8;
 Wed, 25 Nov 2020 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606322799;
 bh=P+vy5VoZ2F85soXfnFUh9AixDyXElRDgch2cjs4F6Is=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=edghX3QERAr+5sRbZiNtHzHeCF2pS1En5z+/XHZ/zJ+Py11EZX4Yf3L+5SO1kjlDC
 81ySQoDnc5uBRQYNkR1MhtSrbSHfHQWZQ1lMX8l7WWub4rCP7hwwGqUaNuhX3SBcqx
 /AuRw5alTg6jPG3LszxkC1rvOHjujfP4332hqmro=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Oder Chiou <oder_chiou@realtek.com>,
 Kevin Cernekee <cernekee@chromium.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 20/39] ASoC: es8316: skip of_device_id table when !CONFIG_OF
Date: Wed, 25 Nov 2020 17:44:33 +0100
Message-Id: <20201125164452.89239-21-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/es8316.c:837:34: warning: ‘es8316_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/es8316.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index bd5d230c5df2..f9ec5cf82599 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -834,11 +834,13 @@ static const struct i2c_device_id es8316_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, es8316_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id es8316_of_match[] = {
 	{ .compatible = "everest,es8316", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, es8316_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id es8316_acpi_match[] = {
-- 
2.25.1

