Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8702C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:29:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0541223FD
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B3i/adKS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAmJZUQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0541223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CAC717F7;
	Fri, 20 Nov 2020 17:28:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CAC717F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889764;
	bh=+j1OMI4byGz3lhkFhbKgRErhPASUUpHiO1mBssgMMAU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B3i/adKS1EYepH7ujyBYX8Lfh1Baj5o2cl3GpaQ1TTnhNB1wZmbZ35YJxPSNCF37Z
	 vnOfBBBLLuv2VPX/BCFpFKA/VBIxWdVuVSv1k4SO71vVwQaQ3JITBV1oR13ZgTFT/O
	 kvVDZLzaP/0oMo1oTmMC4UXpU1VcZ9IjLOioSUlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11F1DF805C3;
	Fri, 20 Nov 2020 17:19:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA080F805C2; Fri, 20 Nov 2020 17:19:24 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBDCDF805AC
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:19:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBDCDF805AC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HAmJZUQt"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4543238E6;
 Fri, 20 Nov 2020 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889160;
 bh=+j1OMI4byGz3lhkFhbKgRErhPASUUpHiO1mBssgMMAU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HAmJZUQtRR6NeoLmC45vn0OLu2Hghp+k74GpwUVn4mFlh0HOiVp3CRsIXmowF19l4
 XB5k10Xi+YHf1YkVsT27vAHgZtKOdKUncqHqgwi/1xknpYMqinDkEfQ4SIeho0c+Uc
 vOySrgXO3ZAnKUThh0gMqSQ6IyjHyIH0/8aZroMo=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 27/38] ASoC: pcm179x: skip of_device_id table when !CONFIG_OF
Date: Fri, 20 Nov 2020 17:16:41 +0100
Message-Id: <20201120161653.445521-27-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

  sound/soc/codecs/pcm179x-i2c.c:33:34: warning: ‘pcm179x_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/pcm179x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 36e01678bef4..34a3d596f288 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -30,11 +30,13 @@ static int pcm179x_i2c_probe(struct i2c_client *client,
 	return pcm179x_common_init(&client->dev, regmap);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm179x_of_match);
+#endif
 
 static const struct i2c_device_id pcm179x_i2c_ids[] = {
 	{ "pcm179x", 0 },
-- 
2.25.1

