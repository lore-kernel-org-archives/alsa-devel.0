Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AAEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:32:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCF3208D5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF3208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 925971736;
	Mon, 11 Jan 2021 17:31:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 925971736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610382718;
	bh=uaqHS7z5RkvbmEe8SBF1rbRHZQZ8K0Zavox9mQwyTdM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k57BvfFb1xxL5bk3OAzfCawIrk1sS3eVyRNpJuwfAGPsF1842gRuhS7tsaaS8rr5U
	 +nFLx5p9Zt8sFx2FO4Vrd7Ikx6uolFwyPPNvbXT+C46V5M/FSQ39op+CipI6+qunEI
	 fNocYKpVQDI/G6AYaI4vlDl1qxF4pSaQc+lf03Ck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78A3EF804F2;
	Mon, 11 Jan 2021 17:28:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51D05F804F3; Mon, 11 Jan 2021 17:28:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76B48F804ED
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 17:28:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76B48F804ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Yujz+ip9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6407B22B51;
 Mon, 11 Jan 2021 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610382523;
 bh=uaqHS7z5RkvbmEe8SBF1rbRHZQZ8K0Zavox9mQwyTdM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Yujz+ip9M7UHyf7RzxeYs9G1Kdo2m0cvD8tnPUZcKwmqRgGxIhKy+Ny9cJDhfxr4A
 YCNexMg4Hkrc4RDIfhL4qECvYchfs6wo/X4CJPWMWyDrv8WlySxM61WOFDmuqnz4yK
 PelBs54xIs8aqH+gYiydjI8tHOcyN0nf+VGRprWlzXsWwi1ViYf+FY+wXG8epTe33n
 pLP5vqeILzJ3ZJDPbsH2BBhOfLxJou2dDp2eUe1CdXgo9to7rBMEbqPb9SD33ujgd4
 QzfO/cbvtUb+q0PXjrzD3wRcweZvaL2KHQJvlzvShoQHxnwdZr5p0C4XcqAzoY2kWJ
 MJgns06bLxkUg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
In-Reply-To: <20210108031248.20520-4-michael.wei.hong.sit@intel.com>
References: <20210108031248.20520-4-michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH v2 0/2] Enable DMA mode on Intel Keem Bay platform
Message-Id: <161038245911.32701.5782165651933217585.b4-ty@kernel.org>
Date: Mon, 11 Jan 2021 16:27:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, lars@metafoo.de, tiwai@suse.com,
 jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com
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

On Fri, 8 Jan 2021 11:12:46 +0800, Michael Sit Wei Hong wrote:
> Michael Sit Wei Hong (2):
>   dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
>   ASoC: Intel: KMB: Enable DMA transfer mode
> 
>  .../bindings/sound/intel,keembay-i2s.yaml     |  14 ++
>  sound/soc/intel/Kconfig                       |   2 +
>  sound/soc/intel/keembay/kmb_platform.c        | 157 ++++++++++++++++--
>  sound/soc/intel/keembay/kmb_platform.h        |   9 +
>  4 files changed, 167 insertions(+), 15 deletions(-)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
      commit: 9ddaa1e6181b3d33080f2ed7c27cb0bba819e562
[2/2] ASoC: Intel: KMB: Enable DMA transfer mode
      commit: 11b943c06a1c1baafb0325896e666d77f5ac78b8

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
