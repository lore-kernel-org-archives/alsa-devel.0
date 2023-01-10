Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCF8C46467
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Jan 2023 14:18:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 818DB7813;
	Tue, 10 Jan 2023 15:18:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 818DB7813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673360335;
	bh=khR8Je2/S/jctq/e4Ct/y9FYt+f+huPTCHFUMhIqpg4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HekijG4UKWrjleud7mrK2ukVfifIF5qm+gBpf7Fhf6VG/0YjsK3lNWka+f7WKZy1t
	 FXkbZd3DCGldMASl90ZOyFhsPqHcmJVtfW96ecLolvHE83KSIjpEsERF8W672R3Bw1
	 extA8rtiZ8RtDd+zBxS5dT7u8Y0RIkKkRlQ12rCk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 371C1F804BD;
	Tue, 10 Jan 2023 15:18:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3D2AF804C1; Tue, 10 Jan 2023 15:18:03 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3935EF8026A
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2023 15:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3935EF8026A
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lSyJyyfL
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1C158B81699;
 Tue, 10 Jan 2023 14:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53DBC433D2;
 Tue, 10 Jan 2023 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673360279;
 bh=khR8Je2/S/jctq/e4Ct/y9FYt+f+huPTCHFUMhIqpg4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=lSyJyyfLiaJsV/QS4mfRCTYKoWBKWJ6LTuciTxGn1k63r4ev8ajQsbP0//uSofaZY
 Ji5gXe8F9/WV7h2rCAV03Rmzyz4TjA9oPFeBe6CyO3rdTdq0Wj9TazS4k89zLv0xbX
 nEZp9TzsK5+cRJZMe/c+pvXsXd6edvtbCqMsF3bfB2H8Aw13vujLSVAOod3tb8IAE7
 v+Dn5WMd9VpspoacTKeNWj9ga6/7/RYecqS5wX0PK6FCjz2i6TdW7JXaP5qGbRIpVO
 D4S+YF19hp04h6dw0DVrBOtuNYZE8qIpWWR7D1siGpAREfELRaGP6CoZ+XfOY7S+16
 R5yXYi+KAzsig==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230106-asoc-udoo-probe-v1-0-a5d7469d4f67@kernel.org>
References: <20230106-asoc-udoo-probe-v1-0-a5d7469d4f67@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: fsl: Fix fsl-asoc-card AC'97 support
Message-Id: <167336027745.725755.13402587013389671005.b4-ty@kernel.org>
Date: Tue, 10 Jan 2023 14:17:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 06 Jan 2023 23:15:06 +0000, Mark Brown wrote:
> The generic driver for Freescale cards with ASRC does not so far as I
> can tell work for AC'97 cards, it's certainly not working for the two
> Udoo boards I have that use it and I'm not clear how it ever worked.
> These patches fix the card well enough to probe and make it through
> pcm-test for playback at standard rates, though there are still issues
> with capture and some playback configurations getting confused about
> constraints.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_ssi: Rename AC'97 streams to avoid collisions with AC'97 CODEC
      commit: 8c6a42b5b0ed6f96624f56954e93eeae107440a6
[2/2] ASoC: fsl-asoc-card: Fix naming of AC'97 CODEC widgets
      commit: 242fc66ae6e1e2b8519daacc7590a73cd0e8a6e4

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
