Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01465C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:10:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C101651D1
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C101651D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B9F81757;
	Tue,  9 Mar 2021 20:09:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B9F81757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615317013;
	bh=X5DV0+7bQxagO19B+PPtigR8hF4pn1HYTTs6MfV4kqM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9RqexCfqqpVQmbsQaqzFg8uvN9OF4DiFQNKYeJBV7Pz4KNdAYO4QQSqVMm5NN9ZI
	 w/5npsThSK9GJ4QJV9p2OurcEXXzuJ19yHgSjOJC2HuE/CAVH3bxmY6f+eDp3jJX+Q
	 Ce3qD5MBfetGRvo86S20iYvMx5l6Tx8pb5Li7LR4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F245BF8032C;
	Tue,  9 Mar 2021 20:08:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76DC3F80424; Tue,  9 Mar 2021 20:08:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB287F8032B
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 20:07:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB287F8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jA+tDQyi"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 902DA65238;
 Tue,  9 Mar 2021 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615316873;
 bh=X5DV0+7bQxagO19B+PPtigR8hF4pn1HYTTs6MfV4kqM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jA+tDQyilQydUb3ZwV+HkijdzjiZfjdQxeaswauEiGU71XzLzVkxPWi2fvJOJ6K/l
 ba0FziIYFUEAMC376s11TJUrIE3EWUKB5kDebEaVH3fdN6XqzxwJlBWbbbRp4SjDdi
 0yBKPqK+Q+T3QvuBEYq0KjdU2Z3SkarOOOKml4BflvSPa9cI6ZUcDKHGn2QGC700Ar
 bI3oTmrnZnZCwYUK7skW/tn5ExTVeZnVsnd5Eo6t9LqWQJdstix52llrH/4YzjTKJX
 99OaWJdsDnMaBSft2NMa2atIbZDjreYyPg0PBG9SqU6GNh3Q9iWhxromGj/n2W4H8S
 hdiumrS8MwKFg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, shumingf@realtek.com
In-Reply-To: <20210309085827.32032-1-shumingf@realtek.com>
References: <20210309085827.32032-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt5682: add delay time of workqueue to control next
 IRQ event
Message-Id: <161531678411.49117.16681049804699060826.b4-ty@kernel.org>
Date: Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 jairaj.arava@intel.com, cujomalainey@google.com, lars@metafoo.de,
 derek.fang@realtek.com, sathyanarayana.nujella@intel.com, flove@realtek.com
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

On Tue, 9 Mar 2021 16:58:27 +0800, shumingf@realtek.com wrote:
> This patch keeps the delay time (50 ms) for jack detection and zero delay time for the button press.
> This patch improves the reaction of the button press.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: add delay time of workqueue to control next IRQ event
      commit: 113e7a60209aa8b54255a21c0acfc5000753ffff

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
