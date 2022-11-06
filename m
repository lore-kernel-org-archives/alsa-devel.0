Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED3BC433FE
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Nov 2022 17:05:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1F6D822;
	Sun,  6 Nov 2022 18:04:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1F6D822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667754342;
	bh=o2+ts7+oQiXTOP7MINi299O0Ta42vbh8+bm3bKn2TRo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g0nrVLGNSAnJqSQ0HImnBCHQXgF1KpnIGNxQOGtVN0BUkdRKryxqvprC8cv/KGvyW
	 tQpsHkQ1Qbbagrv/TpXOG2L7uPI9AIZs0E08mLSVMDwHK7sFhGoHxhHjuMdMRMlLIS
	 7Spg7vBnHmi2nfKlFpugespclBczRTEuzZ9P1gPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2CF7F804E5;
	Sun,  6 Nov 2022 18:04:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3AEAF80557; Sun,  6 Nov 2022 18:04:06 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56A10F804D8
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2022 18:04:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56A10F804D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NiprFO/H"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 864A260CF8;
 Sun,  6 Nov 2022 17:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31E0C433D6;
 Sun,  6 Nov 2022 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667754242;
 bh=o2+ts7+oQiXTOP7MINi299O0Ta42vbh8+bm3bKn2TRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NiprFO/H8NWZrZc4a0SjzKk+C+XUKeTsVUnlMbQj8W7Zw4bMcmqM8GuotcYs0T15n
 TwbGioGn50rdyPQP2TqTj01LTC7E29w4uI9ZMnCj/q8fUNu28o6t6C7DgXztGROUx0
 8qkyHJgvm3ei7bWOs4zdJMZNaCXoxHa9/jG1kW6DWFOTDbWxQY5uAdREgKVvVmlJYX
 srNb/wLFUBxzvIJT/dtjLX5z0CqTW+ck1+4f2sTAQaERbXnOdZwn+zUzSPPPjtHypa
 fMRvh9EfQYeZZl4aGG3cesnDygcf7XJa2F/58DaKFgpQ8KCK09Z/xVm9FlS/eUEVQt
 0GrBDjgYS7CTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 06/30] ASoC: mt6660: Keep the pm_runtime enables
 before component stuff in mt6660_i2c_probe
Date: Sun,  6 Nov 2022 12:03:18 -0500
Message-Id: <20221106170345.1579893-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221106170345.1579893-1-sashal@kernel.org>
References: <20221106170345.1579893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org, steve@sk2.org,
 Zhang Qilong <zhangqilong3@huawei.com>, tiwai@suse.com, lgirdwood@gmail.com,
 chi.minghao@zte.com.cn, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 ckeepax@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

From: Zhang Qilong <zhangqilong3@huawei.com>

[ Upstream commit c4ab29b0f3a6f1e167c5a627f7cd036c1d2b7d65 ]

It would be better to keep the pm_runtime enables before the
IRQ and component stuff. Both of those could start triggering
PM runtime events.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20221008140522.134912-1-zhangqilong3@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/mt6660.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index 45e0df13afb9..b8369eeccc30 100644
--- a/sound/soc/codecs/mt6660.c
+++ b/sound/soc/codecs/mt6660.c
@@ -503,14 +503,14 @@ static int mt6660_i2c_probe(struct i2c_client *client)
 		dev_err(chip->dev, "read chip revision fail\n");
 		goto probe_fail;
 	}
+	pm_runtime_set_active(chip->dev);
+	pm_runtime_enable(chip->dev);
 
 	ret = devm_snd_soc_register_component(chip->dev,
 					       &mt6660_component_driver,
 					       &mt6660_codec_dai, 1);
-	if (!ret) {
-		pm_runtime_set_active(chip->dev);
-		pm_runtime_enable(chip->dev);
-	}
+	if (ret)
+		pm_runtime_disable(chip->dev);
 
 	return ret;
 
-- 
2.35.1

