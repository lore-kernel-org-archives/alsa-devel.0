Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF3C47096
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:44:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7660B613EE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7660B613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE813172B;
	Thu,  3 Jun 2021 20:43:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE813172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622745887;
	bh=14roOXPcs5DCgt6AKrjuC09a0UVpqCCBpqmcJOOjjOo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QqMd9bQ2tT+X8ibjb9hCVLipOW6mS0lcMP2xqrzrUd7SRosdn1rhef9+AYDQikzvv
	 CC6VY1ScOnqxGja4I2dVs8E/wz441CwVr6G9tA558h5kI1nu8o20FIYNpUWkcnhvU/
	 wHTu6F0+p2VSovfwq3ssTOLu2h5QY8UjjqvPvHXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56EF5F804B0;
	Thu,  3 Jun 2021 20:43:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EC50F802E7; Thu,  3 Jun 2021 20:42:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42986F80103
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 20:42:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42986F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t8wUNjTc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3CC0613EE;
 Thu,  3 Jun 2021 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622745773;
 bh=14roOXPcs5DCgt6AKrjuC09a0UVpqCCBpqmcJOOjjOo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t8wUNjTcGcWkZ5DfqA0kY0P2Izzr820EMwg6e3LAOS6MPs/RLZX6KNbxgAPK5ZMU9
 /NT8Ca669gPagahF46HoK+HiRs3swYgS1UkOhfdQP1BFDAc/K2T+HlsTQZ6pkYzumU
 UXYOh6qs9dj+Y7+qY2xUFPzjGIcIvIHuB+ejKkzdGzzy0Sp5cC5DQt0lyBzm0gvmtR
 Meo1sEhEO4cuKnv6wBFjyugWnYKHf66WegNc8oPaAwK0dK6gGu8IsIfkQj9y629ldR
 lp4gIU6HV+9zlmyCwUwYkWvhw+gtfa4Uod9w9PaBjnIIcPY4otK6xkO2yjgK9V+XWg
 uLyAW46gf6tNg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
Date: Thu,  3 Jun 2021 19:41:58 +0100
Message-Id: <162274557550.14795.17431456709023435037.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210530203446.19022-1-richard@nod.at>
References: <20210530203446.19022-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, dmurphy@ti.com,
 grandmaster@al2klimov.de
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

On Sun, 30 May 2021 22:34:46 +0200, Richard Weinberger wrote:
> TAS2562_TDM_CFG0_SAMPRATE_MASK starts at bit 1, not 0.
> So all values need to be left shifted by 1.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
      commit: 8bef925e37bdc9b6554b85eda16ced9a8e3c135f

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
