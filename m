Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B2C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:40:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7743820771
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fIQoSGF9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PanpWoHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7743820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01BFF17C9;
	Tue, 23 Jun 2020 14:40:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01BFF17C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592916058;
	bh=X1NGFk6VjiPCuw5A802fb9uY8jmPHXWXlHexWqTClhk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIQoSGF9I7tbz822rsHdblVAXBCoUzvnAzv5xiQTO9NPl0bzdi6uQvnjhqlJVK2br
	 cKpdH8L77HTAfRu7FH3PKwSV3lmr1lxQ5pmAZnoQdPW03O4soP7UB14iEjt3Ztai5p
	 NpLY84r9L3o63oq8XQ01KtEUPQPXGKRf+mCIFa2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 396BFF80249;
	Tue, 23 Jun 2020 14:39:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E04B4F80249; Tue, 23 Jun 2020 14:39:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FF20F8012F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 14:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FF20F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PanpWoHX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 482D320738;
 Tue, 23 Jun 2020 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592915951;
 bh=X1NGFk6VjiPCuw5A802fb9uY8jmPHXWXlHexWqTClhk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=PanpWoHXKDMWNOztIEbisKquKENt9RiS2rMkBoDmD8o6KP2SHiMwIOUq+OcATpaLj
 LC0b2VB9IkVFSRAr3/Lm63WUnX/pEOQ2+WDYDSXvcYIF6Jv5W7v1lFnKb6fAbPNWLW
 9AcmP2WflmMD7szPGwmJLw0wco8ysLs8pK1xxLjU=
Date: Tue, 23 Jun 2020 13:39:09 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200622151348.28063-1-pierre-louis.bossart@linux.intel.com>
References: <20200622151348.28063-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt1011: fix KASAN out-of-bounds bug in
 find_next_bit()
Message-Id: <159291594453.44561.4198315468419375039.b4-ty@kernel.org>
Cc: Fred Oh <fred.oh@linux.intel.com>, tiwai@suse.de,
 Shuming Fan <shumingf@realtek.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
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

On Mon, 22 Jun 2020 10:13:48 -0500, Pierre-Louis Bossart wrote:
> KASAN throws the following warning in rt1011.c:
> [ 170.777603] BUG: KASAN: stack-out-of-bounds in _find_next_bit.constprop.0+0x3e/0xf0
> 
> find_next_bit() relies on unsigned long pointer arguments, but this driver
> uses a type cast that generates the KASAN warning. Replace find_next_bit()
> and find_last_bit() with __ffs() and __fls() to pass the value and avoid
> casting pointers to make the warning go away.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1011: fix KASAN out-of-bounds bug in find_next_bit()
      commit: ee8a41cd30a99b39bd5d46280cc778e275cd2390

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
