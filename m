Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88793C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 16:44:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C9A207E8
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ucpk6jHi";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tchURcgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C9A207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78A88172D;
	Mon, 18 May 2020 18:43:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78A88172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589820278;
	bh=EcO4oElaZZ083rE1M5k+z7XPibVbfi5Bmow4quIlVK8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ucpk6jHiaCTgncNnWlTyTRnog2ahkgRAW8E+HwCdfLJecHKvCqu7hHPkCCVXk+UsT
	 fAecvLzZ1Y3g5SQpB/rQhZFdqiu1SN+YlLs/ghipdbVGAQZ8gcpHJtYg36995QxUFE
	 gJ5HDZ9o+h+MMfXE0Kfh7uDy/8BQEJ0uNyECK84I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77FB5F80274;
	Mon, 18 May 2020 18:41:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44B7AF802A0; Mon, 18 May 2020 18:41:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5056F80274
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 18:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5056F80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tchURcgY"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB17D207D8;
 Mon, 18 May 2020 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589820085;
 bh=EcO4oElaZZ083rE1M5k+z7XPibVbfi5Bmow4quIlVK8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=tchURcgYUhac7PYVJQNNN7I9mxosoZOkOTVMhwHHYkzEzlljiWCjoiP0K1nQVKmKQ
 tVujIxeGSj8y9+2dCfuXAdVii7FIciewNR+znSdcMq5bLrLVhP7b5saziq2Atglj5Q
 4kOk1a3cBJUcR3g/vlYHkkBAVWzCLn3krSwQh9gA=
Date: Mon, 18 May 2020 17:41:22 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200515211531.11416-1-pierre-louis.bossart@linux.intel.com>
References: <20200515211531.11416-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: codecs: rt*-sdw: memory leaks and
 simplifications
Message-Id: <158982005877.28736.5937943209302059995.b4-ty@kernel.org>
Cc: tiwai@suse.de
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

On Fri, 15 May 2020 16:15:28 -0500, Pierre-Louis Bossart wrote:
> While debugging unrelated memory corruption errors, I detected issues
> related to the interaction with the SoundWire and ASoC cores, here are
> 3 small patches to fix all this.
> 
> Pierre-Louis Bossart (3):
>   ASoC: codecs: rt*-sdw: don't assign slave_ops
>   ASoC: codecs: rt*-sdw: fix memory leak in set_sdw_stream()
>   ASoC: codecs: rt1308-sdw: remove duplicate allocation
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/3] ASoC: codecs: rt*-sdw: don't assign slave_ops
      commit: b5dff6ec13260585164d4cd13d7a3ec79bd26acb
[2/3] ASoC: codecs: rt*-sdw: fix memory leak in set_sdw_stream()
      commit: 07b542fe831cbefce163ad1b3aa7292c8a6332b8
[3/3] ASoC: codecs: rt1308-sdw: remove duplicate allocation
      commit: ee5866222ab58531c988492ea54931c1346d4fd4

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
