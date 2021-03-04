Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CDBC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:02:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084864F16
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084864F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E83C01AF8;
	Thu,  4 Mar 2021 02:01:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E83C01AF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819726;
	bh=HTFsv6Fv1iYZbTyUPYTDVHFZqM3lA61amO6iQi9gLgU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F89ekFllnMqcDtkdjyD5x3VHskDhUmlOpOIXA3ky9NADMPYE4P1QPreFl8/8FE7Ys
	 BS2Gql+C6Q6t4+p0z9+23VofORnRL7We+6osnx+cPhB9XPjA7/Hflhmj5zuIzXGExx
	 U3wZRnDiKJQ01FVwGPk6fEqtyhYEa6hE3uo9LdTw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50F30F8050F;
	Thu,  4 Mar 2021 01:56:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0280F80510; Thu,  4 Mar 2021 01:56:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5458FF80506
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:56:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5458FF80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RmOiUzLt"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE3C64E86;
 Thu,  4 Mar 2021 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819390;
 bh=HTFsv6Fv1iYZbTyUPYTDVHFZqM3lA61amO6iQi9gLgU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RmOiUzLtiSBt3o6wiPFTH/7CT6WnBQdjuEL4dQjWNhho1+B5vpNaFuEBU1P6uVTlY
 jGXkSWC3Ei62k9+vSdzEEYKWn4LRUPvAvZZNmAgWHa3ahVuIShNcjKbkWKStqZ//uI
 zbCnkL96OGJdTfNcanMJ8tujdTxYJGDmCVzFHL5GNAE4VjAVhxp+VBgNzU7VnkBC53
 U44g+O0RvJ6s3nEao8PxuCphPWOB1GP8HQyz8wzILRFQ3vCkZuxpaFyjfPCbDklEXx
 qvKYf4snK+6fjxHfF5zd6r7R0BAkXs7xGX0p0Ge4hO99r20Z6SImNUx0UVSKElmqcv
 mIILruaj7Jc0A==
From: Mark Brown <broonie@kernel.org>
To: Colin King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20210303091835.5024-1-colin.king@canonical.com>
References: <20210303091835.5024-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: fsl: fsl_easrc: Fix uninitialized variable
 st2_mem_alloc
Message-Id: <161481924070.9553.9267870549828564094.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 3 Mar 2021 09:18:35 +0000, Colin King wrote:
> A previous cleanup commit removed the ininitialization of st2_mem_alloc.
> Fix this by restoring the original behaviour by initializing it to zero.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: fsl_easrc: Fix uninitialized variable st2_mem_alloc
      commit: 84e4eb57ed620adc0371579a5662c4924a72a306

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
