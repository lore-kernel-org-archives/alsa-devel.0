Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CFECE58D
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 10:01:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07E3218DE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 10:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D++3u4UX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aCDZm1Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07E3218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A12CC15E2;
	Wed,  9 Oct 2019 12:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A12CC15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570615277;
	bh=RqJg4ze2tBDzUkPjK0Ar1XrHajvDiNaTB6j6wZsYDEY=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=D++3u4UX3KMHJ6w6Ks80tcW4i3LSZIELcjqluu7F3Xpe1MPr507qMAIST6o1+YHh6
	 0uPvSNt8z/OCBLjxgprKq1GRVa7vErovKJ5KWclAH9peQE2wwftIZPw9u/P2yit87r
	 6TAlwkdkWQCxsZt5NqE8XOL3ZKlEWtSJaTNX2woI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 424A4F800BF;
	Wed,  9 Oct 2019 12:00:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7047EF802BE; Wed,  9 Oct 2019 12:00:26 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74DD5F800BF
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 12:00:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74DD5F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="aCDZm1Nf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=jOarO4Eh1p5RlVKQTdwkeSKmVo158ikbV07LA/3FdDo=; b=aCDZm1Nf3xp6
 igbdigKiPb3bn0i2AlS3zvwXQW0nA0XXHef4E/YVTznUtatHRZ1+CwWA+1MxFvZMeJp56FLz3wH1Y
 z7gggxhm3dwxt/C8wzzmClCEGH3R7xQJuxA0kRm7bXadp5pq5UtyDI44q/BcdlRNFj4kK1hXd7bfn
 Y7+Nc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iI8lY-0004Lx-4n; Wed, 09 Oct 2019 10:00:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 5E7B02741DF9; Wed,  9 Oct 2019 11:00:19 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20191008235212.228856-1-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191009100019.5E7B02741DF9@ypsilon.sirena.org.uk>
Date: Wed,  9 Oct 2019 11:00:19 +0100 (BST)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frank Rowand <frowand.list@gmail.com>
Subject: [alsa-devel] Applied "ASoC: jz4740: Remove unused match variable"
	to the asoc tree
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

   ASoC: jz4740: Remove unused match variable

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From ad4abed36433a4fc18d21c0f0eaede84006f219f Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 8 Oct 2019 16:52:12 -0700
Subject: [PATCH] ASoC: jz4740: Remove unused match variable

After commit 67ad656bdd70 ("ASoC: jz4740: Use
of_device_get_match_data()"), the match local variable is unused and the
compiler rightly warns.

sound/soc/jz4740/jz4740-i2s.c: In function 'jz4740_i2s_dev_probe':
sound/soc/jz4740/jz4740-i2s.c:500:29: warning: unused variable 'match' [-Wunused-variable]
  500 |  const struct of_device_id *match;

Drop it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <alsa-devel@alsa-project.org>
Fixes: 67ad656bdd70 ("ASoC: jz4740: Use of_device_get_match_data()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191008235212.228856-1-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index d2dab4d24b87..38d48d101783 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -497,7 +497,6 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
 	int ret;
-	const struct of_device_id *match;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
