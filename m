Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4108CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:17:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2947321721
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KrzOKNNH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cjkNshmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2947321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60ED1205F;
	Mon, 28 Oct 2019 16:17:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60ED1205F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572275873;
	bh=bEFWLQ4b11TwINaO12AxuqPFcYkaQikEW/k0E7sqx6M=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=KrzOKNNHpLOd2DeOVkn8+EaQtX+umMZNI8AW+RE//P+6A/GiM5lLFniWkcx8h3+ba
	 AVcgwHMlBlw6qIGYzzTH2ISPe/pnkO3nAwQsvQ88JZANp5DxRNJydixK471KDmU/Bz
	 6TY0ax6ovxWyr9v2e2UVyuhZze5BhMRuiGdhHBmY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05D53F80C43;
	Mon, 28 Oct 2019 15:57:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F68F80714; Mon, 28 Oct 2019 15:57:15 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3E7DF8063B
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 15:56:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3E7DF8063B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="cjkNshmd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=Wg5/WSipepYlxE85FYEPX9AdCg1p/wZZkY7Hj68ZkRc=; b=cjkNshmdXHEO
 8z4UC3tX0JQzBN3tXK5t/OxwFZoma6ZUXRbRceui8R9FU2vd48wqbNpfh+2tJ99Ek1Y5u/UlRZJhE
 vcjFuMBb7k3eBX3KsAgMulJZkvknrm7pt+e/RzU2NQ84MvVHPPzWB4emq3n0u72Zek9j5Q5a5LZqJ
 YSfnw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iP6Ri-0008RW-3V; Mon, 28 Oct 2019 14:56:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 65C6027403EF; Mon, 28 Oct 2019 14:56:36 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y2x530a4.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145636.65C6027403EF@ypsilon.sirena.org.uk>
Date: Mon, 28 Oct 2019 14:56:36 +0000 (GMT)
Cc: Pavel Machek <pavel@denx.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: rsnd: core.c: add WARN_ON() on
	rsnd_channel_normalization()" to the asoc tree
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

   ASoC: rsnd: core.c: add WARN_ON() on rsnd_channel_normalization()

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

From 5db8617ba7e8fcda1c5dd310c62ac8d31eaf9eae Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 28 Oct 2019 14:29:55 +0900
Subject: [PATCH] ASoC: rsnd: core.c: add WARN_ON() on
 rsnd_channel_normalization()

chan > 8 or chan < 0 shouldn't happen.
This patch uses WARN_ON() for such case.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87y2x530a4.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 72924c8b0696..871afe75ca42 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -302,7 +302,7 @@ int rsnd_runtime_channel_after_ctu_with_params(struct rsnd_dai_stream *io,
 
 int rsnd_channel_normalization(int chan)
 {
-	if ((chan > 8) || (chan < 0))
+	if (WARN_ON((chan > 8) || (chan < 0)))
 		return 0;
 
 	/* TDM Extend Mode needs 8ch */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
