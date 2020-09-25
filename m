Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D34C4727F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:48:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2A320838
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iePDLF6r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwCW8Jdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2A320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDA411947;
	Fri, 25 Sep 2020 22:47:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDA411947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601066885;
	bh=EfSzTCliWhiljJ3+L77GOzDVfo7KHWTv3mmxcKGz2jQ=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iePDLF6rtqTyf26d5jOMtAGHCefT1vnWZ+BlTQC8WFMZoTKeblvg5tBbheWbAknjH
	 oQFrIA9dHXLeMJ/+MMCCC6oEXbsXQGFMOq2G0uUG0jGkmmFfUPznLhRKJ72L/xjr/z
	 4jfp/3Qnh2IW3F1woBtHWqxZvxXa9MAWJ2iHIE1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C829F802FB;
	Fri, 25 Sep 2020 22:43:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70751F802EC; Fri, 25 Sep 2020 22:42:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78141F802E7
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 22:42:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78141F802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XwCW8Jdk"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE72021D42;
 Fri, 25 Sep 2020 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601066571;
 bh=EfSzTCliWhiljJ3+L77GOzDVfo7KHWTv3mmxcKGz2jQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=XwCW8Jdk4w7MvkQoLKzQ7B9IEUn0u+mioiXi243K9sDBT7ApPTyXZkJszGC6B6g+p
 u2H53IuYqY/4RsV1bQgUzgXVhAUkdlli4e/O0QJX7oaM6nTywJ0WCL06SxiXmD81C0
 YWy9+6ZQNSZgcRr8JoAlqg19KPkBzpLpLn2qqNhQ=
Date: Fri, 25 Sep 2020 21:41:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix some warnings when build without
 CONFIG_OF
Message-Id: <160106647647.2866.17205507189233379981.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
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

On Fri, 25 Sep 2020 09:49:23 +0100, Srinivas Kandagatla wrote:
> Here are fixes for two warnings types discovered while building qdsp6 drivers
> without CONFIG_OF and with W=1
> 
> One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
> equally applies to rest of the qdsp6 drivers.
> 
> Srinivas Kandagatla (2):
>   ASoC: qdsp6: Drop of_match_ptr to fix -Wunused-const-variable
>   ASoC: q6asm: fix kernel doc warnings
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6asm: fix kernel doc warnings
      commit: 5d0576bba9eb37bf07dc58a91568a2332a22fbcd

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
