Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF505C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:42:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5848760527
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5848760527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0627A16A8;
	Tue, 21 Sep 2021 23:41:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0627A16A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632260566;
	bh=9kvioNqkIrsS8HBoj2GlyRdysXDxOgoRAuVJFCeoBUo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OCNNjg+OKjLxVwwbNqYvYoDuNSrd0vYwDznh5XZgh9fI8bQI/tXbs39Zgq/v3Amkr
	 sUc1kBA50iyAC32lwXCjz4ZrvkB1WD4Url+vFHiw6X1h3UyYpMg9IOS6086A6d5u07
	 vz3i5gjkjNF30yLMrtk+W3qS7DePnglIPKncnWMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9E08F80549;
	Tue, 21 Sep 2021 23:37:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FF2AF8054A; Tue, 21 Sep 2021 23:37:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC67BF80548
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:37:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC67BF80548
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uOY15jDs"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E151B61166;
 Tue, 21 Sep 2021 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632260247;
 bh=9kvioNqkIrsS8HBoj2GlyRdysXDxOgoRAuVJFCeoBUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uOY15jDsrgthTaNir73Y6vzD7xl5fLU/cBHRothrPthVo3kcEbaanEOiu6zwK244p
 rCWXJ1ftWbyr5GvAVD95SAU5PXTbq7Hhxdygdifb2QiB7vkDZxzgddgpIrwQBvc8Su
 nrV2Hu8gqsXeugV4tzSLF3q8FC0eQoAEmaPbnUdKPxu2KuWom7Y0JJNNZcRDYoh3yj
 FP25k87HopjiKwPng96EJ+uKGN5AM2k+3FY1FTfCjCuZgszKniX2s2wIbiQOJ0bTXR
 qdPzXv7Pp23ji7jxuximnnaHpX+Fu+iwsOKVfVV7lyJk9Qc7cc9xht/xkgu/ZVFH5D
 j/1qsW/itMKcw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH v2 16/16] ASoC: pl1022_rdk: Update to modern clocking
 terminology
Date: Tue, 21 Sep 2021 22:35:42 +0100
Message-Id: <20210921213542.31688-16-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
References: <20210921213542.31688-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; h=from:subject;
 bh=9kvioNqkIrsS8HBoj2GlyRdysXDxOgoRAuVJFCeoBUo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSk8fnpCj8O6TDJnvU0wky8JPu5tjCBxYgZJvjL8x
 177U4GmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpPHwAKCRAk1otyXVSH0FjVB/
 9Ywe58qXb8OE32uPIidA9JwEujm0oJhFQw8tiqvIafVUeAUJVYJIOl2/Gcu2NqU9DugY+iJuaSKWVk
 BwklppUTbyRSf0VWRLCbEM+znePYUfRzT4EOF66eqeivR5RIe31b38dmr/f6b/ESC8RC4hjbxrEbES
 OpoNPlQAZKwAEQAnUJ5jtqfxiWjwYhxZBh4/o3WK2pdpopx8OP3MlQhs8fFZ6mTDV9Dw0qZfUOCPV1
 pUglQ26p59M4zAaZPbiXCI8yS2ylnquFuAY6blUNIepvtEbJrPMFUoxaXHM53tFrBr/G9djypjbqQW
 0sFuSVgMgD7scU1ffSbRI/p1Lz/SF+
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
the pl1022_rdk driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/p1022_rdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 714515b8081f..b395adabe823 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -265,7 +265,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 	 * only one way to configure the SSI.
 	 */
 	mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP;
 	mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 	mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
-- 
2.20.1

