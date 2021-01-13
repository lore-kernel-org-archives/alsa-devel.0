Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17737C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:30:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6241423382
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6241423382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA017171A;
	Wed, 13 Jan 2021 16:29:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA017171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610551814;
	bh=yF8t4IHeXMhyMj1FVUZptqNcSclfnGbYPmGrQchj5Xk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GPRTv8Bi8EFZA4M77zDuVAsgHQalNnd29IDb4RXtfi62X/FqpEKbps6226X47ZIyQ
	 Lkmiq7CAXy1l8XAneNZAxgxmarmmlzXyTIHvVjpkX6BlRy7DUxf+vO8DaStoxxqHvG
	 UY6sNUtJpU8JBjtkAOnlRTJwg8D1Mo+HMBbDtrnM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8B69F804E7;
	Wed, 13 Jan 2021 16:27:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A82DFF804EB; Wed, 13 Jan 2021 16:27:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C8AEF804E6
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 16:27:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C8AEF804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UMa9xUp/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FFAD2339F;
 Wed, 13 Jan 2021 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610551665;
 bh=yF8t4IHeXMhyMj1FVUZptqNcSclfnGbYPmGrQchj5Xk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UMa9xUp/G2wDgYytwRzx5tk2LEPYmPcva5TN1KUwUWyLc5CfG2j5EnfnPuYHJYrdE
 5IixulTcTWhMuExTXlg6uDvyjPUeEIqVr/ABlEGC24fgltCA/tU91LKrEmArRLKS6H
 o0kvze5qyR7vbEagnzAzcGUH1QsPNh6naXKFszTXJ5PM+AR/uGlcPT8980TON9G6l/
 QpK/3bBTIwtpWt8Mcwy8z0H6ouzmQOUYFgHq0GVdBTVmCRVf0nbdlN8F53ttDE6NDP
 pNhAlyuzKKi/mDIQFlBiY/vqGJsuosGHWjQCFwDwJFf3GIUPHBb2d6icOHR6TVxMxh
 9ZsOm5ccP6B8w==
From: Mark Brown <broonie@kernel.org>
To: Brian Austin <brian.austin@cirrus.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 James Schulman <james.schulman@cirrus.com>
In-Reply-To: <X9NE/9nK9/TuxuL+@mwanda>
References: <X9NE/9nK9/TuxuL+@mwanda>
Subject: Re: [PATCH] ASoC: cs42l56: fix up error handling in probe
Message-Id: <161055160365.21623.3967340008515664713.b4-ty@kernel.org>
Date: Wed, 13 Jan 2021 15:26:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, David Rhodes <david.rhodes@cirrus.com>
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

On Fri, 11 Dec 2020 13:07:59 +0300, Dan Carpenter wrote:
> There are two issues with this code.  The first error path forgot to set
> the error code and instead returns success.  The second error path
> doesn't clean up.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l56: fix up error handling in probe
      commit: 856fe64da84c95a1d415564b981ae3908eea2a76

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
