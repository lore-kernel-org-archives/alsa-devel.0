Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B7EC433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:22:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4C62087D
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nrfVhq0v";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLhBb9p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4C62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44C99168A;
	Tue,  8 Sep 2020 19:21:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44C99168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599585726;
	bh=433yfRoWVWryEQg8hs/2ulN02niAHi18hwgI4BieteI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrfVhq0vUpU8qutoKIBQfSthqWRL2hZZDL4sMHq5q1EEHCbRgSC9GTSsHhn5nlNWp
	 ocTXDnBYfMwNBD2Ks8eDXOSLhr7mSnpIiJ9TOiaQqfMJ/JG5lGZ3C2KWhaNYKxqa9v
	 UrYe8SExZK6TPdypS+aGM//Re+v3v0dqGRKSATs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1F01F801F2;
	Tue,  8 Sep 2020 19:21:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 223BAF8026F; Tue,  8 Sep 2020 19:21:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2C2DF8015F
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 19:21:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2C2DF8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VLhBb9p/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 58E1020768;
 Tue,  8 Sep 2020 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599585669;
 bh=433yfRoWVWryEQg8hs/2ulN02niAHi18hwgI4BieteI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=VLhBb9p/sivJUYkANXKukUGp/30WFb806IyMFX7vN65qHwUQH1fH9d9OsFI/dV4cp
 hczKfc0lmVZ+d93cDGqveF1eCHZqvlZ2SQMX813XLl9+3eC7GHCNAoknhCUOClsYV2
 C6x9v4flIm6X3/hA6xC6dfakT6kh3WOJ5tz7iREo=
Date: Tue, 08 Sep 2020 18:20:25 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <20200908112526.9853-1-peter.ujfalusi@ti.com>
References: <20200908112526.9853-1-peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ti: Kconfig: Allow the j721e machine driver to be
 used no K3 platform
Message-Id: <159958562064.16576.17968851366680832500.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org
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

On Tue, 8 Sep 2020 14:25:26 +0300, Peter Ujfalusi wrote:
> The initial machine driver supports only j721e-cpb and the ivi addon, but
> other EVMs for different K3 SoC can have similar audio support which can
> be supported by the driver with small or no modification.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: Kconfig: Allow the j721e machine driver to be used on K3 platform
      commit: 34ce41003bcbff8b20a30eb0938478b156e57a2d

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
