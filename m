Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB8C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:40:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330BC2072E
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FvIsGlnt";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9N/jH4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330BC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE36F1794;
	Tue, 23 Jun 2020 14:39:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE36F1794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592916005;
	bh=s4OW4NdQ44yHfXF3p3fF7+PABKLBSDaoh1qVeVv48jo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvIsGlntx1rMO1ZQceP3YHzmD9C7uGUl4Z0JcqTD4yrjmQj92H8QTpipciVJGitM4
	 5ZMxJCyP9PVljS8gY0+ecTE5Em5TWeS0g9lQrHlPf69AMof+ZsnxaFVcBaXUSoAQII
	 ZredWeCJV1kywnDHOzPZSvoUuvDttGd8Gp8ilgMc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADDA5F80218;
	Tue, 23 Jun 2020 14:39:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9138F80234; Tue, 23 Jun 2020 14:39:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B38EF800B2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 14:39:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B38EF800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Y9N/jH4j"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E9AC2072E;
 Tue, 23 Jun 2020 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592915946;
 bh=s4OW4NdQ44yHfXF3p3fF7+PABKLBSDaoh1qVeVv48jo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Y9N/jH4jzDPmLNthFNcz2POvdY6Xdun88Pgoi7N9f/iJ+7334M/fO5ouyXR5taUPv
 nraHStMpCeYODMdMXJ48+OtedCDdwnUtISUvoND5w9tvW+mus0FohFuLNXcmOd08uq
 gJ9GTU0NtGgYw4tIhNtuf8tBFUCy5cqI1YcP2ijk=
Date: Tue, 23 Jun 2020 13:39:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200623055130.159718-1-tzungbi@google.com>
References: <20200623055130.159718-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183-da7219: set playback and capture
 constraints
Message-Id: <159291594453.44561.2367904242159108805.b4-ty@kernel.org>
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

On Tue, 23 Jun 2020 13:51:30 +0800, Tzung-Bi Shih wrote:
> Sets playback and capture constraints to S16_LE, stereo, 48kHz.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183-da7219: set playback and capture constraints
      commit: b1647f9f4f27824a689f774014bc33728b4fe7ec

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
