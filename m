Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 16:45:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C82205CB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c8uOWnvb";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVYUxCnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C82205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 968831726;
	Mon, 18 May 2020 18:44:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 968831726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589820322;
	bh=l4OKSpQb7xCEPsp2YagYvuWupUCN1pS/UdfClZttRgs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c8uOWnvb6Wf8aHdoh70FMR2bUwWq4rdNuNBHDCL2mTCO0FlZ0xPzEOrKdUnjvmKSa
	 un0F6qy/bm0DBorlKFGBH2J+ESKEolnO7Hk2o9tD/BtCilmto+e4HFB8mGbXvCBKPQ
	 C3/Mp5P/Jc1SGsNP4bXYN57lIsf/IthHmNUliCEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A316CF802A7;
	Mon, 18 May 2020 18:41:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B98B7F802A8; Mon, 18 May 2020 18:41:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65B34F8029B
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 18:41:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65B34F8029B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VVYUxCnv"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C9DA207D8;
 Mon, 18 May 2020 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589820090;
 bh=l4OKSpQb7xCEPsp2YagYvuWupUCN1pS/UdfClZttRgs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=VVYUxCnvNuGjTe/K/9RKDzSX19HReSwm5EnLARdFb6d46jsXVop1hldKsi4yp8+Kv
 1O/nkv5EDOxQNkJJMixHYYgc7IWfKdggRvNBznMseYaO+3gshk1H2mOKk4QabD1t/a
 kQHKGZaGPRmPmdrSajdGjDz2p8jADyowt827G4QQ=
Date: Mon, 18 May 2020 17:41:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz, timur@kernel.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
In-Reply-To: <20200518110040.18036-1-tangbin@cmss.chinamobile.com>
References: <20200518110040.18036-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix unused assignment in
 fsl_set_clock_params()
Message-Id: <158982005877.28736.11025452668323550718.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
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

On Mon, 18 May 2020 19:00:40 +0800, Tang Bin wrote:
> Delete unused initialized value of 'ret', because it will
> be assigned by the function fsl_micfil_set_mclk_rate().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: fsl_micfil: Fix unused assignment in fsl_set_clock_params()
      commit: 15b5c496ff99ce99ab3c5e98e96981d015b3168a

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
