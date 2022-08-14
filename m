Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301E7C25B06
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Aug 2022 16:23:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E68515F2;
	Sun, 14 Aug 2022 18:22:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E68515F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660494191;
	bh=YPFGWF+SZ3nfFejBqr/SAmSzFD052TPPo811pYAyxFQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U7RLWUnJEL2mDCao7UtPZjseUUX8xzQ/+oaMSBrvNvTPHt7OhETqTErgyZU6y26fC
	 90KNXCO/Lo24HpMUTtaEBtxRrf3uZ2tx7EfmIzxfd2MPl37Ovi8IJA1IipDog0FXbA
	 rJndlPsJlBPYD3oS4wbO9YSqIlkG/y+VNQOTRKKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DB68F80588;
	Sun, 14 Aug 2022 18:21:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBB38F80589; Sun, 14 Aug 2022 18:20:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A710BF804FC
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2022 18:20:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A710BF804FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YdhxYoj/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CA7BAB80B3C;
 Sun, 14 Aug 2022 16:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1A3C433D7;
 Sun, 14 Aug 2022 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660494053;
 bh=YPFGWF+SZ3nfFejBqr/SAmSzFD052TPPo811pYAyxFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YdhxYoj/EFmPWuPCghNhU2zzoSAssOQHmQ8weHLRcInX8X24bEn0xcJVbblJ4cTi1
 O5uEJTFNnWDWE7FsP5x8jFAmhBQCaPWvlAlMqz2neLbtsfKIzEk+qX9l4VP3KVQeq0
 hz2EA0BrhsLd96IA59AFueE4ennY8aMAtSvBWSDrK6IoGdvnZB02mel8d9dWFfS73K
 3/LOHiaW5pN1sv05pW0Vwr+KoyxDMeSot3iGHWRITh+mQD4VFey+OrXRcgnjvpZNsz
 sYHbv+XlCoBKBi9Q43PKHZrKfC3EqZ4g1SlnuMIiLgYHianSj5/srDyeq5AyGMSrZs
 f4ReBu+X1dDyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 19/48] ASoC: nau8821: Don't unconditionally free
 interrupt
Date: Sun, 14 Aug 2022 12:19:12 -0400
Message-Id: <20220814161943.2394452-19-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814161943.2394452-1-sashal@kernel.org>
References: <20220814161943.2394452-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, pierre-louis.bossart@linux.intel.com,
 alsa-devel@alsa-project.org, steve@sk2.org, wtli@nuvoton.com,
 Zheyu Ma <zheyuma97@gmail.com>, tiwai@suse.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, Vijendar.Mukunda@amd.com
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

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 2d86cef353b8f3d20b16f8c5615742fd6938c801 ]

The remove() operation unconditionally frees the interrupt for the device
but we may not actually have an interrupt so there might be nothing to
free. Since the interrupt is requested after all other resources we don't
need the explicit free anyway, unwinding is guaranteed to be safe, so just
delete the remove() function and let devm take care of things.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Link: https://lore.kernel.org/r/20220718140405.57233-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8821.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index ce4e7f46bb06..e078d2ffb3f6 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1665,15 +1665,6 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
-static int nau8821_i2c_remove(struct i2c_client *i2c_client)
-{
-	struct nau8821 *nau8821 = i2c_get_clientdata(i2c_client);
-
-	devm_free_irq(nau8821->dev, nau8821->irq, nau8821);
-
-	return 0;
-}
-
 static const struct i2c_device_id nau8821_i2c_ids[] = {
 	{ "nau8821", 0 },
 	{ }
@@ -1703,7 +1694,6 @@ static struct i2c_driver nau8821_driver = {
 		.acpi_match_table = ACPI_PTR(nau8821_acpi_match),
 	},
 	.probe_new = nau8821_i2c_probe,
-	.remove = nau8821_i2c_remove,
 	.id_table = nau8821_i2c_ids,
 };
 module_i2c_driver(nau8821_driver);
-- 
2.35.1

