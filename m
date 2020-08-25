Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3137C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:24:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7503E2074D
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zr+GLwt2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK+pag45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7503E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1234916F0;
	Tue, 25 Aug 2020 22:23:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1234916F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598387071;
	bh=0oBp2PgYfIUVJx13o5uLw09hRmnHEUePiZFJTKDeZmI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zr+GLwt20R73PJv80/C7pIWpVu1y9QHiho2bjNONJAqf88jpysB3L0fLYn7gimwgy
	 +w7k6s/oYFUrJUj8WieHKxvLG4pyLTeYfIsgGebhJpUGzHNUfJKwFf9v0+uTcPAebK
	 dtLlnIkXVFMybBPzhYsduOgOXlBCoPKkQGXpyz4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7CC5F80260;
	Tue, 25 Aug 2020 22:19:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43CEBF8026A; Tue, 25 Aug 2020 22:19:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53CA7F80269
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 22:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53CA7F80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hK+pag45"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA1632074D;
 Tue, 25 Aug 2020 20:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598386783;
 bh=0oBp2PgYfIUVJx13o5uLw09hRmnHEUePiZFJTKDeZmI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=hK+pag45JYtD5+ZgUe7g4zMFo/wt2sB9Rjn2uMsZ2TQ5yMzuYveBaQY+9twlhefqR
 w3a9YUTgCdvYUnP8rDFOTAb1H+2CPGCuuRVjYhsvfYUluDXVIyx/epRfq9vp+JS+8k
 CfpGquO5Dqls45VedaAT8rS32c+3UWPB1Fgrvt2w=
Date: Tue, 25 Aug 2020 21:19:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200825104623.GA278587@mwanda>
References: <20200825104623.GA278587@mwanda>
Subject: Re: [PATCH] ASoC: hdac_hdmi: tidy up a memset()
Message-Id: <159838674787.41542.3818167760566393034.b4-ty@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>, Brent Lu <brent.lu@intel.com>
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

On Tue, 25 Aug 2020 13:46:23 +0300, Dan Carpenter wrote:
> The ARRAY_SIZE() is the number of the elements but we want to use the
> number of bytes.  Fortunately, in this case the value is the same so it
> doesn't affect runtime.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdac_hdmi: tidy up a memset()
      commit: 672072976bf0db6e0aca5382bcf03bc90f439923

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
