Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920ECC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Feb 2022 12:53:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B9AF1753;
	Thu,  3 Feb 2022 13:52:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B9AF1753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643892824;
	bh=bifMRxFt15XwZYEhtZYLHJ3rVciq+tWatVuwjf+MMkQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ijX+YiOrvRvU0paB3j86r4lyGnayRFGVY7L7x4WaHlo7B0dPp9vTnAZ+uOW0BD5Pn
	 ZLCB1Hu0JzWrNWqnnB18A2VImz7Q6azDUQEHLNBctOfmPC6M5GQRT6QMWZtoEZcPy6
	 LEh6+1iCDgrNY8cfil5ymxZKvJgNory5iubw/2AE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9492BF802E3;
	Thu,  3 Feb 2022 13:52:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADC31F8030F; Thu,  3 Feb 2022 13:52:22 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F6B5F80082
 for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2022 13:52:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F6B5F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kPK/Xlqf"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id EB7B3CE1F83;
 Thu,  3 Feb 2022 12:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78C4C340E4;
 Thu,  3 Feb 2022 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643892732;
 bh=bifMRxFt15XwZYEhtZYLHJ3rVciq+tWatVuwjf+MMkQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kPK/XlqfgzYA/uqximt3McvYA9w8a4LI5/6jEK9OlndwyFXCud0bAzWCigpoTf+aw
 ioBSD13lUZs5ChYO9641qlYzFW86nw+WqpLU4oGtM7EnTmKopaBTPhurKfxQSD4CHJ
 7GLeYxMx752A60KGPdzE6TWixPgrVjqNVSQSXqeW2102eiBUp7eScDyblmYFg/Zckl
 DMguo7ePhieYz1bi7cD3gkvj5kLgWIVx9Ebdlv7aBOUO8IHgb5bO854xSnPKPYHXlv
 VCXk1xDt2MqhqKZeEgqQlnZS5Qn0fSP+5iXXM3sYMDTftFXSXTqjCKduz07WvLa/X6
 Q3hvDOiR/pirA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
In-Reply-To: <20220201155629.120510-1-broonie@kernel.org>
References: <20220201155629.120510-1-broonie@kernel.org>
Subject: Re: [PATCH v1 0/4] ASoC: ops: Fix stereo change notifications
Message-Id: <164389273145.1027470.4157564013333575037.b4-ty@kernel.org>
Date: Thu, 03 Feb 2022 12:52:11 +0000
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

On Tue, 1 Feb 2022 15:56:25 +0000, Mark Brown wrote:
> The event generation coverage I just wrote shows that the generic ASoC
> ops fail to generate events for stereo controls when only the first
> channel is changed, we just return the status for the second channel and
> discard that for the first.
> 
> Mark Brown (4):
>   ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
>   ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_sx()
>   ASoC: ops: Fix stereo change notifications in
>     snd_soc_put_volsw_range()
>   ASoC: ops: Fix stereo change notifications in snd_soc_put_xr_sx()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/4] ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
      commit: 564778d7b1ea465f9487eedeece7527a033549c5
[2/4] ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_sx()
      commit: 7f3d90a3519680dfa23e750f80bfdefc0f5eda4a
[3/4] ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_range()
      commit: 650204ded3703b5817bd4b6a77fa47d333c4f902
[4/4] ASoC: ops: Fix stereo change notifications in snd_soc_put_xr_sx()
      commit: 2b7c46369f09c358164d31d17e5695185403185e

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
