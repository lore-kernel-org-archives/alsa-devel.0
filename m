Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288D1C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 00:57:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6C764E7C
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 00:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6C764E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA5631924;
	Thu,  4 Mar 2021 01:56:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA5631924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819436;
	bh=l2/rshOi2vaG6mRBIofaleAxP3HlWxDPSCCDc257nWA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YEBkHJ1w3R4umAAy6x/sG8IBjULtWM0VyQqPYMqTs2yU2qJHy+v7f3OI5fPFoTHm5
	 WAyhivP9suRcfaOeX0QIrDdDzcTbnJjKM2LaVM8gVQ+vj1gPiLA8e9sWpOgTXC/w6O
	 /OFXyLmyoX+FhoB+wEAYV0maH5weSdLN65uy7GiQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7824F80423;
	Thu,  4 Mar 2021 01:55:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CDF0F80424; Thu,  4 Mar 2021 01:55:24 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BBFAF8032D
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:55:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BBFAF8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZugMl9oQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0090564EDB;
 Thu,  4 Mar 2021 00:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819320;
 bh=l2/rshOi2vaG6mRBIofaleAxP3HlWxDPSCCDc257nWA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ZugMl9oQO0YI/Rmc2VXrVDMQYM9Pn+znkQnDrnHJ3zBIBxZkX/aIsNx78j+JWF3L7
 40m94NS0AsRIGd6XGgJ82uKBMxUnkc9VHqzC2zMF1REs8PEf2Ec30TL4XIviwaCWFJ
 ePk3IZR6jKvZQuymY4p9UtsKX6T5oR8KW1EOYFcYGnbA+k6VMZTYsS1nya1reyy+aY
 8GqnB0n1VKmel5e0TQIuu2lxlUaDGJMKn0uWARsJxANvu67ho+O7K6pD498es5lmEr
 bvVm639qPNw5gU+iE+Y4Lp+G4u1oCp130jdj6qNuZNyuUCtUPUodCp7tNPpj9vYP3H
 V51SlcAiA6itQ==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20210302142817.2141923-1-festevam@gmail.com>
References: <20210302142817.2141923-1-festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix identation of .driver elements
Message-Id: <161481924070.9553.10370069255882212886.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 2 Mar 2021 11:28:17 -0300, Fabio Estevam wrote:
> The .driver elements are not correctly idented.
> 
> Fix the identation of the .driver elements.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sgtl5000: Fix identation of .driver elements
      commit: f62f8fe080852c2883fe66a4e7b4871f280c1fec

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
