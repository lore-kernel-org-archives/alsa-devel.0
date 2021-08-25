Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43153C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:20:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35C9610FC
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F35C9610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A951B166D;
	Wed, 25 Aug 2021 17:19:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A951B166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629904815;
	bh=xX3sPL8wVgj4gfbIYo+gq9+nKEagcBN77P42+6QE7yw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpCf/HnLXaOXVE4XGycMqAQGbwfk2FcG7P7eCXQ1ME9HgPjqBQxkwbSB2dBsrkv3b
	 SKnm67rXcMaNf6759uDN7QzRBSE4sT2qJotrDgutZQs8eWgvI836im9pKKimcAq7PD
	 bb+uM95Mo1jlXqPKiH/OmB1BbJGqXPn0NxVYz7h8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 490A6F80171;
	Wed, 25 Aug 2021 17:19:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FB65F8020C; Wed, 25 Aug 2021 17:19:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAE36F800AE
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 17:19:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAE36F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M4xH76xU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08BB0610FD;
 Wed, 25 Aug 2021 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629904758;
 bh=xX3sPL8wVgj4gfbIYo+gq9+nKEagcBN77P42+6QE7yw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M4xH76xUnSD05MnyFbAAM3BurUEw7JRDs4QG6ZzMJ8H8X6/Igj1kggEXcTdmiMt3g
 SRID6942Z6+oxEppkOoTlwMqZDzrBXiuXjqBn3nTK2cHN7n0UWJhd0Gxox6tPAqGf8
 NCNJrYQX9jUbQihXnSojqR97dSH0ij+mpXIhbv17pv2aaBKNCFSKHjotIOJUZ1GQjQ
 DnQ0gq1AUmcrOsfBUYvOwLmnOxTs0v3fnWTTsTBXQE6y53lck+KUW730t8t7OMAeqU
 PQwpQgwW3hbgUo+HNdwJ0YvARyIj3aghqmMKeHSiMM/rBAemaTObaOZwStmp4BRZ+L
 vRJnzDHtf9Ktw==
From: Mark Brown <broonie@kernel.org>
To: yang.jie@linux.intel.com, hdegoede@redhat.com,
 pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 liam.r.girdwood@linux.intel.com
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Make
 rt5640_jack_gpio/rt5640_jack2_gpio static
Date: Wed, 25 Aug 2021 16:18:45 +0100
Message-Id: <162990401497.56501.11105326993788990504.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210825122519.3364-1-peter.ujfalusi@linux.intel.com>
References: <20210825122519.3364-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

On Wed, 25 Aug 2021 15:25:19 +0300, Peter Ujfalusi wrote:
> Marking the two jack gpio as static fixes the following Sparse errors:
> sound/soc/intel/boards/bytcr_rt5640.c:468:26: error: symbol 'rt5640_jack_gpio' was not declared. Should it be static?
> sound/soc/intel/boards/bytcr_rt5640.c:475:26: error: symbol 'rt5640_jack2_gpio' was not declared. Should it be static?
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Make rt5640_jack_gpio/rt5640_jack2_gpio static
      commit: dc2d01c754c378a4748ac72c5516d45da7640123

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
