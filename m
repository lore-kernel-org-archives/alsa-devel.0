Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D54CC54EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 11:36:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A28D82C;
	Tue, 27 Sep 2022 13:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A28D82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664278609;
	bh=LUW6qsWIEHusQY1XjJ2NLqgzENneXnRIXz+N61I5uLs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pceDqMOwm1ePKQzaNzkKNIHWIOlFdSbagdgUr3fdU/SlZMUTa+sEo44T7lVeE38/7
	 MeqrQO5XTYi1nNOQOkDBA4DoYXdZKgV3o2r7Mo3d9G1m++l62W1gch8m+7JkQW1Y3O
	 0lQoynofma+qrfo73K7CulMZV8WZFTHtA5V2CZZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DA11F80539;
	Tue, 27 Sep 2022 13:35:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 428A0F800AA; Tue, 27 Sep 2022 13:35:08 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06D8BF8024C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 13:35:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06D8BF8024C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="epQhjYPm"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1664278500; bh=5V2FNZPR/FdcUVzzKFU8iKVMDZyNajtosOiBMcFQsT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=epQhjYPmlZqP/1YEmMW5V9o7ox8YLE07sN5IT+3c4uucytmQspASsFu3ECdKzHBZM
 8JSIcd4NQFQEypJvmQGjxIizfiCept4da+QPhxsjQAU/aGKhWHHKbEpOeYuqerB1XH
 X4SwHtoQ81W4y2TV0HWLPL19lYsg1MOs4PqsE6/w=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: apple: mca: Adjust timing of component unregister
Date: Tue, 27 Sep 2022 13:34:26 +0200
Message-Id: <20220927113426.49724-3-povik+lin@cutebit.org>
In-Reply-To: <20220927113426.49724-1-povik+lin@cutebit.org>
References: <20220927113426.49724-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 alsa-devel@alsa-project.org, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org
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

On removal of the driver, the ASoC component should be unregistered
first, before we start releasing any of the other resources.

Fixes: 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 7ca653987b78..24381c42eb54 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -1129,8 +1129,8 @@ static int apple_mca_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &mca_component,
-					      dai_drivers, nclusters * 2);
+	ret = snd_soc_register_component(&pdev->dev, &mca_component,
+					 dai_drivers, nclusters * 2);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register ASoC component: %d\n",
 			ret);
@@ -1148,6 +1148,7 @@ static int apple_mca_remove(struct platform_device *pdev)
 {
 	struct mca_data *mca = platform_get_drvdata(pdev);
 
+	snd_soc_unregister_component(&pdev->dev);
 	apple_mca_release(mca);
 	return 0;
 }
-- 
2.33.0

