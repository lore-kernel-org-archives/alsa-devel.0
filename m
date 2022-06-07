Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7406BC43334
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 14:13:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 884291ADE;
	Tue,  7 Jun 2022 16:12:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 884291ADE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654611180;
	bh=LJ/VecaxaHlBm9faMjylfrWOnt1AHRsH4wC5sGgkJVY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ObLulRT9ZJx2vQtM2RHrRgUT7KDjD4M6buw8f+DECjpmIvmxqlqiXqzQJgNc2Vf3U
	 8u+O6x3nl1tzTCMEYzYSs2EZ3MoxPViu2VaAiqAqFU3i1MtffHB3Z+6CFUZ6v3YTcV
	 gHRjo6WahfLzaASxwiLEjKdX0iJjQfj8zazyhD5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF976F80248;
	Tue,  7 Jun 2022 16:11:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E07CEF804BC; Tue,  7 Jun 2022 16:11:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51406F80109
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 16:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51406F80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TibF/vxz"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC9461520;
 Tue,  7 Jun 2022 14:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3173C34114;
 Tue,  7 Jun 2022 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654611093;
 bh=LJ/VecaxaHlBm9faMjylfrWOnt1AHRsH4wC5sGgkJVY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=TibF/vxz0785guXjXQf2zWeP4pXGBJCR0+6dL7rajS7IcV+n0lWSOE8pqIsOOr9EX
 r+EFyAovNBYEF7YJl44Irh9qA4KVH7BdUY482eXgp3wjn3rYJPKUzu0vMpC+P8qCpz
 8zzzeiw8vjTVvo2bX4xjG8HiFgvnIGltPBNvWdZo2PHF0qcRMwtQAkL70WOieeT8ZR
 fDDmkrfRjfnjA4pdxEALsu0+3wG77Cj2WqbkpIu0YwZd2K4HVHhj8zc1DNYDAbaU1R
 mWa/xSkjiqIXhrcMlJHL0liNv+ByfzJBhDXpauuuVdfrX9FWQoTTol7S14gj0HN82p
 NrEPXX7N7oLYQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220605153537.26591-1-u.kleine-koenig@pengutronix.de>
References: <20220605153537.26591-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: simple-card-utils: Make
 asoc_simple_clean_reference() return void
Message-Id: <165461109165.1597191.7359069618885924147.b4-ty@kernel.org>
Date: Tue, 07 Jun 2022 15:11:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, kernel@pengutronix.de
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

On Sun, 5 Jun 2022 17:35:37 +0200, Uwe Kleine-König wrote:
> asoc_simple_clean_reference() returns zero unconditionally. Letting it
> return void instead makes it easier to see in the caller that there is no
> error to handle.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: Make asoc_simple_clean_reference() return void
      commit: e6f08af6340eaf88e9eeff71bd4533eee9a04119

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
