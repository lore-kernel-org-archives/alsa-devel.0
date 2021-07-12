Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21129C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:52:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFE2610A7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFE2610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F40BB16AD;
	Mon, 12 Jul 2021 12:51:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F40BB16AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626087163;
	bh=cugKJZQS+D/bRbakUGj0OOo0zuDNW4DxeSFxRcBYXOc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QfrRAu/esUDJ05PklUQslqH9zbHpflrSNsZOeN2IWKX/RCi0T30CH+WmbWuNEXWSB
	 saOpggPkIW/UegEYH4PFGfDLcLXj5xK8nM/TmRPV4e4jfl/ORq8lIeYbXLxNqhVyeR
	 6ht3+Fvk4MSM2xy67a6fmemu0rO/asSxGAodjQUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DF4BF80516;
	Mon, 12 Jul 2021 12:48:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 443B5F8051E; Mon, 12 Jul 2021 12:48:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32A3AF80515
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 12:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32A3AF80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qij0p1Sb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCCA161159;
 Mon, 12 Jul 2021 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626086888;
 bh=cugKJZQS+D/bRbakUGj0OOo0zuDNW4DxeSFxRcBYXOc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qij0p1SbnjA+DSdKriZm9e6XxhEQ403d047rcfCp6kPZKQk8lmj9xiJNjLhayELK3
 ziRa22M9Dim+Y08nnYCMoXKd/k7/W7sOtMMFyzKiErNRtanWvbhyBVU5nbsdRUnNtW
 161gA4Fs7xd86oYoJHovv5ZhjqkQGdyIQZZG1Ogalw9vZZ93Wk6Ja2cNDpsbo7PC7a
 6jFB3qp17cLPOI12Qdcf6QJEs9mxWvzb4gFl/qB1Q915GaLcQuEPTqRf2UCcDzE9Wn
 nJ4caAw1ujhIDQAQuZxEyBn7bx8A4YSNys0t/DzEMG9j0Vg6QqOn+tAwz0d1Nrtw1w
 HoBuvtKsj8Ehw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 1/3] ASoC: wm_adsp: Correct wm_coeff_tlv_get
 handling
Date: Mon, 12 Jul 2021 11:46:08 +0100
Message-Id: <162608623149.3192.17412874747238610062.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210626155941.12251-1-ckeepax@opensource.cirrus.com>
References: <20210626155941.12251-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
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

On Sat, 26 Jun 2021 16:59:39 +0100, Charles Keepax wrote:
> When wm_coeff_tlv_get was updated it was accidentally switch to the _raw
> version of the helper causing it to ignore the current DSP state it
> should be checking. Switch the code back to the correct helper so that
> users can't read the controls when they arn't available.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: wm_adsp: Remove pointless string comparison
      commit: 2ba907894f9e69b68e5934b57afb744482a72984

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
