Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2F0C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:29:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B445661027
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B445661027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40C8E167A;
	Wed, 25 Aug 2021 17:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40C8E167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629905344;
	bh=U+R7x0zG7wZDOCbY4AVx/G8Mgmce8xvj5JapM9MDqZA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PYWPxBnGnaxF/Pt4snWDEv9w7LcuuDZPB0rFf0hGUM6IsSiMWrc6o+Q7p7rE+ufUf
	 oTe6KFJ+7VzcaD7yCZAut41KQKYiBaZNqT6rL6mpWmnne5HVwCuVkocLcbdLUSqFLC
	 lQmviDtjszA6hQ4SqvWFl7UjchYXejlAC1bghOxk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ED0AF80240;
	Wed, 25 Aug 2021 17:27:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BE25F8020C; Wed, 25 Aug 2021 17:27:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB3E8F800C9
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 17:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB3E8F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DDkbo11K"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05210610FC;
 Wed, 25 Aug 2021 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629905246;
 bh=U+R7x0zG7wZDOCbY4AVx/G8Mgmce8xvj5JapM9MDqZA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=DDkbo11KFipYgEKtIb83QOW5eT1/FJBuX92jSHGUSc1s3oYe1eErLjQ1w0t6+JQmy
 SbhdnytnuSwmbOlutJzqBdR5jRPtb9CbX2F/0dkiEFAHhsZzGurR1vfpWd8JTqBV6S
 oSp7CBgD3GfNZ0fNDPgtmrsGCXEiUYtG36LZdBGJfEy63/2nfxWk6/fca9+OPvUcj8
 PzCPwVh4k6WILL5dy+ii88XqfVH7RsM3yg69dYG9eobTlaZk29vZF3yMLudUBbIASp
 4mwn9uhcyAr2BNjbzUMVPqzF395PLyqAzT0CLBK9rmn24EhkIRyzn4Znohr39wQxdz
 c+zFx5vDAusiA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, derek.fang@realtek.com
In-Reply-To: <15a267e360f64618b82356b925b002f2@realtek.com>
References: <15a267e360f64618b82356b925b002f2@realtek.com>
Subject: Re: [PATCH RESEND] ASoC: rt5682: Fix the vol+ button detection issue
Message-Id: <162990401496.56501.5907742251809678319.b4-ty@kernel.org>
Date: Wed, 25 Aug 2021 16:06:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Jack Yu <jack.yu@realtek.com>, alsa-devel@alsa-project.org,
	lars@metafoo.de, , Albert Chen <albertchen@realtek.com>,
	Shuming@alsa-project.org, shumingf@realtek.com,
	范書銘@alsa-project.org, "Flove(HsinFu)" <flove@realtek.com>
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

On Mon, 16 Aug 2021 10:36:22 +0000, Derek wrote:
> Fix the wrong button vol+ detection issue with some brand headsets
> by fine tuning the threshold of button vol+ and SAR ADC button accuracy.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Fix the vol+ button detection issue
      commit: 8d3019b63b3d92c9b5f1548f600485d39262bbe1

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
