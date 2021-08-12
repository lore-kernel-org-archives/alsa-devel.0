Return-Path: <SRS0=v/9x=ND=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF2C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 12:08:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BD260FD7
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 12:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4BD260FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 772701906;
	Thu, 12 Aug 2021 14:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 772701906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628770101;
	bh=5ADPpdHccujvZQXPlEKxF5syhlR8SQp8WXqrMYPJmfc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ggf3gf6XhYulPjninNhDZTTcGPwxP5bQSYp3mIdZ9Gn5AK4pc+a439mm71CVDyPzk
	 vp6vHla3ZiwEdMMq5+TOEgJpmT1MrYcg8Ld7N7BNPkuhK+RmNfuEnG7xDpvEySyc0S
	 aPNUkKVSiSjn3d/OUT+48BFBuew85LI6JtypRFIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAEC7F80279;
	Thu, 12 Aug 2021 14:07:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A965FF8025D; Thu, 12 Aug 2021 14:07:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 826B0F80148
 for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2021 14:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 826B0F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qXcBuBlb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BDF260FD7;
 Thu, 12 Aug 2021 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628770039;
 bh=5ADPpdHccujvZQXPlEKxF5syhlR8SQp8WXqrMYPJmfc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qXcBuBlb176dtDabI0bDUbinjkmt1fCYpG1zBI2xQv18Cj+zggQYEt+X7Dx5qzei2
 Xb0Uq54jZzr+rGejQp234gIERb2r1ynDSpH4/NIgz4C9bBnaCfrwsGhESZ/qgda5Yw
 wtYPrMvUUl0u7F4PkDQOJhPo+dWSpdD2owjEhZ6ChVofBB7zdJVqcjio7kEj6FFNip
 UFB9mA/K6Znprgs8X1+QlC/M7iPgX8Lh3RDf9nPCHp7auAjL3PqW03XbpMdz/8A9Sy
 2tPXo60bbwyF4gZQkxK3AU/16Z7URLIwo2YRAOiJjpeV8WQ4OriPRRf3sJLAFiPr57
 FX/QNGTfyAJug==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>,
 Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong
 device ID
Date: Thu, 12 Aug 2021 13:06:58 +0100
Message-Id: <162876970126.42668.8724722824512964124.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
 Stephen Boyd <swboyd@chromium.org>
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

On Tue, 10 Aug 2021 16:59:15 -0700, Douglas Anderson wrote:
> When I booted up on a board that had a slightly different codec
> stuffed on it, I got this message at bootup:
> 
>   rt5682 9-001a: Device with ID register 6749 is not rt5682
> 
> That's normal/expected, but what wasn't normal was the splat that I
> got after:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Properly turn off regulators if wrong device ID
      commit: 772d44526e203c062171786e514373f129616278

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
