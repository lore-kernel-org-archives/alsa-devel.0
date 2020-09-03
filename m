Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D7C433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:50:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936552080C
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fNusTzl4";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRjwlLgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936552080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0F79191B;
	Thu,  3 Sep 2020 15:49:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0F79191B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599141000;
	bh=JvSw5khXq0xtDTAtXhZfqiB6ak5kwj1ew7cgvmtjRVM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNusTzl4tQpMXflzC7+sQwhgvcO9Olrqc7l/jzgfjawgDIcX07aL2zgIQcoPYpttm
	 kdzeQ7JZ6h+juEKiMUQFM9Ifhfp/yHbnJql0w7kTZdCCa24J53GspOouUsRpdsYtD7
	 Av+RJR484Hi2Qc1HkOerUTTfDu+sPoTK+09AhSZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68862F8020D;
	Thu,  3 Sep 2020 15:49:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75CDFF8021D; Thu,  3 Sep 2020 15:49:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9FABF801DA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 15:48:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9FABF801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RRjwlLgk"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D3092071B;
 Thu,  3 Sep 2020 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599140936;
 bh=JvSw5khXq0xtDTAtXhZfqiB6ak5kwj1ew7cgvmtjRVM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=RRjwlLgkVyNA1+lGkllIRjLOtghwygdJX88Pp0V8ohS3x9GEn+WOekQARcLnrRwLB
 QR94hCSGT/pKvyVpFhbh0oZBLpeGczIPLNFqkCRML8fF2igkxx4s0mfmBXw9Jolfwd
 KcUgd0tEYZlMnk2Kj0RZ4qS0ZKzewYj0U7rzAEGg=
Date: Thu, 03 Sep 2020 14:48:15 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, tiwai@suse.com, timur@kernel.org,
 festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits
Message-Id: <159914089549.45733.4128299430192434595.b4-ty@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Tue, 1 Sep 2020 19:01:08 +0800, Shengjiu Wang wrote:
> One data channel is one data line. From imx7ulp, the SAI IP is
> enhanced to support multiple data channels.
> 
> If there is only two channels input and slots is 2, then enable one
> data channel is enough for data transfer. So enable the TCE/RCE and
> transmit/receive mask register according to the input channels and
> slots configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Support multiple data channel enable bits
      commit: 770f58d7d2c58b8ff31d3694ce14a785c2e75009

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
