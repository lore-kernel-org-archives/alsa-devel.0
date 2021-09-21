Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32171C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:15:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B093F60F38
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B093F60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 505B6168C;
	Tue, 21 Sep 2021 23:14:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 505B6168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632258948;
	bh=NW3bpE8J3VKBnOZtBpB10bBc+DHax4UYEF50tjdaBmQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ftEu2O3PcCR7Q0jyDVgU5vQ3TRiZcrwUZR22izqRznSJ5GVRWa7s6xJt/nWmis5qr
	 dYDZqKXuETWuR1vn7XVV1LOb1ODQn1eAkwLQ5oDSawC83ksOHwOtB8SypABxwKJpgh
	 GvFfuTJxGUg6ZvUFmSAA/gIdnmSGiJ6Zhek4VZIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 365C7F8051F;
	Tue, 21 Sep 2021 23:12:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56203F80511; Tue, 21 Sep 2021 23:11:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAADCF804F1
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAADCF804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T7I6aOnJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED34C60F38;
 Tue, 21 Sep 2021 21:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632258709;
 bh=NW3bpE8J3VKBnOZtBpB10bBc+DHax4UYEF50tjdaBmQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T7I6aOnJKHW/HQfGm5kd1aNdbyCrFDozVpkmP9j8XSkkAjVePmXCRSXBvrI9bvf9P
 RkKhsT10CtASPMNuQx28a50RBDNQzpjuqh8gEuQ84fzvdvEiGjjlNqvLY4au8acp1Y
 SGjGHl3sohUEuedFJEaUcKbEwdBQn9puL87JTVN9RlCfPwV1zK0B20Ad++IpUY1TdA
 NxPgNo2mPOTAFZ1nZADJp1YPfTjQCxql7y1uok0W29Qs1zDj491xyQaX7rnUrOhFms
 LGK+KobKQEh/xE1AehSI7v+YwaCZWO6s8zk+khhiIqpcJHPDN27w0GLX8TTjg5uwmQ
 KD/i5kMmAyqLQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 10/16] ASoC: imx-es8328: Update to modern clocking terminology
Date: Tue, 21 Sep 2021 22:10:34 +0100
Message-Id: <20210921211040.11624-10-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921211040.11624-1-broonie@kernel.org>
References: <20210921211040.11624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; h=from:subject;
 bh=NW3bpE8J3VKBnOZtBpB10bBc+DHax4UYEF50tjdaBmQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSknii/HuhL2+C59n6SMrEtArdewZFCYqAk0/3TuH
 hSAfRLiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpJ4gAKCRAk1otyXVSH0LqOB/
 9Yjgt9JEE1FmHlf0PBvtzQjxP39FUTZCrfB/nO/X8CzpQYA5ugpA4dSpxHAoti62m6/IwHNuntZkQB
 wGvj83Fm3Du1U3zUHC6ayws63YOv887zXCyq0vyWfqK4HfjS8RKUAYbUP66S2TsqsQYIstS3/wZLlC
 ZEKHYHpHauNUKcmqpdisU1S2gN2WvqtLvqHOkWcT2neZRtnMUOGjNBUEnDVhTmzApU3ttoVdiHeIak
 4xKnYuzCRYUBYaCHk8R35fmqfgNIe0EA9LH9yxUzCzRHiieA1C16tW9XzLusSY0/lxRiSOH5L8EuEi
 XwKbtjAXPbQLuSepP8IRnSjEhJ2Bik
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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

As part of moving to remove the old style defines for the bus clocks update
the imx-es8328 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-es8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 1981dcd7e930..09c674ee79f1 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -174,7 +174,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	data->dai.platforms->of_node = ssi_np;
 	data->dai.init = &imx_es8328_dai_init;
 	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			    SND_SOC_DAIFMT_CBM_CFM;
+			    SND_SOC_DAIFMT_CBP_CFP;
 
 	data->card.dev = dev;
 	data->card.dapm_widgets = imx_es8328_dapm_widgets;
-- 
2.20.1

