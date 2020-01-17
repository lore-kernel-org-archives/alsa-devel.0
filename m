Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4858BC33CB1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:50:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FCB2083E
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P/VINhBX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VGDNqk/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FCB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D46017FC;
	Fri, 17 Jan 2020 16:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D46017FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579276238;
	bh=c4t3USfChB9o4ALwYktEZPbtZYHoKyfK3oLngQewdaw=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=P/VINhBXftG4ssGJUVBpG2IAJIR/dYxGUM7w2URG7r8DK3BKu0+WDjmvnlhyzf3Mp
	 f+7R7y94GkgPLuIdHaTHYq9II313mVgCTy8irrM8fIiJPg9LXyyHoP1CLtWwloL6Mk
	 LZTeeQBuReyh5b0uAxxOWK3SwtWjIYkTemuMZ7sM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 249E1F8029A;
	Fri, 17 Jan 2020 16:45:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC84EF800E9; Fri, 17 Jan 2020 16:44:20 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 144E9F8014B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 16:44:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 144E9F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="VGDNqk/y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=PnI/PQTjjediv1Dzh6nRabOY57QlvqvVoMoR9cUX4gU=; b=VGDNqk/yzJRy
 yyE5Fjf2D+mJN9l7PEacsPDmIk01+Gr/RUQarCDP/aZnFLKs+oyRrz9SdueumpxKqRuu8AxKwaakY
 MjqbD/6/Et/KgSReOMBNVrzbXo4MS8MmuqE0GniFPlrVAxc4wXDoHDjvhukcvjSwJwgJLPrr5pekg
 LSNa0=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1isTnA-0006sO-Pf; Fri, 17 Jan 2020 15:44:12 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 82324D02C26; Fri, 17 Jan 2020 15:44:12 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20200114161841.451-3-ckeepax@opensource.cirrus.com>
Message-Id: <applied-20200114161841.451-3-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Date: Fri, 17 Jan 2020 15:44:12 +0000 (GMT)
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, david.rhodes@cirrus.com, Mark Brown <broonie@kernel.org>,
 li.xu@cirrus.com
Subject: [alsa-devel] Applied "ASoC: madera: Correct error path handling in
	madera_out1_demux_put" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: madera: Correct error path handling in madera_out1_demux_put

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 4061fdc89ff7704a71dc6df8e5841f861138e7e1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 14 Jan 2020 16:18:40 +0000
Subject: [PATCH] ASoC: madera: Correct error path handling in
 madera_out1_demux_put

Should the write to MADERA_OUTPUT_ENABLES_1 fail and out_clamp[0] not be
set an additional error message will be printed. Clear the ret variable
to avoid this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200114161841.451-3-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/madera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index 12dc468ae6bf..2be64422adf9 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -575,6 +575,7 @@ int madera_out1_demux_put(struct snd_kcontrol *kcontrol,
 	usleep_range(2000, 3000); /* wait for wseq to complete */
 
 	/* change demux setting */
+	ret = 0;
 	if (madera->out_clamp[0])
 		ret = regmap_update_bits(madera->regmap,
 					 MADERA_OUTPUT_ENABLES_1,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
