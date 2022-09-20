Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7581C6FA82
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 21:35:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B505515C1;
	Tue, 20 Sep 2022 23:34:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B505515C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663709708;
	bh=kF+juegNrgoYd36+kSxeHkJrR6xbLoArmPeABk6/t7w=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XITuMXyJXJGwNHBD391WbEFGtkyj9fRmnAVfLE0FWZJ31fliyAadozYb4ErZQ6YGy
	 g8d+ehZWGu7CLPCTcnEgmZLTedR/VEYUw3riyppYLyAYW0gMFMSFZiaBKZM1CWzFZO
	 UkfzdjnsjFW55ga1FE4hngxqH6tn3/guYUiyu8PM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3110CF8053C;
	Tue, 20 Sep 2022 23:33:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 443F4F8053B; Tue, 20 Sep 2022 23:33:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D056CF8053B
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 23:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D056CF8053B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jhZ0YhEU"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 68A1A62691;
 Tue, 20 Sep 2022 21:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D166DC433D7;
 Tue, 20 Sep 2022 21:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663709602;
 bh=kF+juegNrgoYd36+kSxeHkJrR6xbLoArmPeABk6/t7w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jhZ0YhEU+yLr8iMOA5QEwbaW/KHHccT1JgGLa4La+HAU4EMOyDZhV1OgHCcykAWtt
 kyc4W5UnK7IN/s1SeNJng+Pngxw562WNtM54qU2C2tZ4IJQXHx6m88veZcLai/QOca
 EHdRiPJO1lqhhnfXb0M16IffcmMW3px0m78RGxAhEtbJ5bbjNDZFiq6ZtuIOkF2GxK
 oR34aaAH3tDjbmMCj+HH0HPkfsJjGDsQ89e3m32lrBa4jKN/zY63Yosu1mygusCNj9
 6/z4l/pzwa3dkODaaZ5X+QgU8JpwYmiUt9NLbQY2U0ZOQnaDKttm9b3vnXEC+HZIoZ
 D6vAbhCi8hUzQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220920145405.2089147-1-pierre-louis.bossart@linux.intel.com>
References: <20220920145405.2089147-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: ipc4-topology: minor cleanup
Message-Id: <166370959829.476248.514896301430918126.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 22:33:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: tiwai@suse.de
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

On Tue, 20 Sep 2022 16:54:03 +0200, Pierre-Louis Bossart wrote:
> Two updates on warnings reported by cppcheck.
> 
> Pierre-Louis Bossart (2):
>   ASoC: SOF: ipc4-topology: clarify calculation precedence
>   ASoC: SOF: ipc4-topology: remove useless assignment
> 
> sound/soc/sof/ipc4-topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: ipc4-topology: clarify calculation precedence
      commit: 80d53171f85a8e97b2aa1d50045dbc1b5dd1bc97
[2/2] ASoC: SOF: ipc4-topology: remove useless assignment
      commit: 7738211bce7ae43624121fcf121aec87b2149af1

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
