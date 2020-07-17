Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E8C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:40:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF16F2076A
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pqhhQBwz";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9eSijix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF16F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E380844;
	Fri, 17 Jul 2020 17:40:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E380844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595000454;
	bh=ZbC+gDl7WuYsyoEZK9jriCDYB/kmxm2hu4oLKRUdqVE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pqhhQBwztfygIShkSoK9HBCh1b8cWHk5IVyOtP+RiunQwcw3cLzhAA4pY64kn/Olp
	 YSF1FT8WUq0PC8b4WcnnSRbvZF82WEwZBDrDGDGawri+vuaGmklfYBQNWb207w6zKm
	 PG8bd5rKMBFRWOcYR3HTwm5eWcfV4E6F2UtGtcjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 879DBF801D8;
	Fri, 17 Jul 2020 17:40:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 771EDF80227; Fri, 17 Jul 2020 17:40:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1593DF801D8
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 17:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1593DF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J9eSijix"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D73012076A;
 Fri, 17 Jul 2020 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595000396;
 bh=ZbC+gDl7WuYsyoEZK9jriCDYB/kmxm2hu4oLKRUdqVE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=J9eSijixam3yIOX+GVYvq/o5r+fO6G10amtS3F7Io3UeLmGibf1lb8huE5gIbGIXn
 CXr19sVSx79+//Sd2G/GdD8RpG0j0kQzheEH48g9NBzmw8prCK/d+2BbMvvCa8mGTQ
 jGbYFBgHnPvvJvPI8J1zWTbiglvDlWKs1/j9PMak=
Date: Fri, 17 Jul 2020 16:39:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875zam3bmk.wl-kuninori.morimoto.gx@renesas.com>
References: <875zam3bmk.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-dai.h: don't use discriminatory terms for
 comment
Message-Id: <159500037996.27597.7953835559890054472.b4-ty@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On 17 Jul 2020 15:22:26 +0900, Kuninori Morimoto wrote:
> soc-dai is using discriminatory terms for comment.
> This patch renames "slave" to "secondary", thus
> we can keep M/S initials.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai.h: don't use discriminatory terms for comment
      commit: ca00e66c1bc875aef7d84ec16418e08a14d0cda9

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
