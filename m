Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186A4C43219
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Apr 2022 16:01:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 632451798;
	Mon, 25 Apr 2022 18:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 632451798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650902478;
	bh=bsHqNUTnWPaHjYk95fjam2oUfRdQnolYudYxp8VJ/Cc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZgtjIaSnJYaBtXDjpzE5WIBMy+uvABUIwKSUXsnG2H+Aqm6TO12eIWsyyQZDtwSTH
	 lJtWXqr4fuBef6NzcVmGnfrR7DYPFY3YcJMKgNVaeBWH3wD3gqbczQPyhXLMby//kp
	 a31tPA6Ql4VJdCMfKq/8C7s0bWqdVikrG8nvuw+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 036C3F80152;
	Mon, 25 Apr 2022 18:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C68A7F8016A; Mon, 25 Apr 2022 18:00:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3850BF800FA
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2022 18:00:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3850BF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ClQWGAPe"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F1A3B6126D;
 Mon, 25 Apr 2022 16:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D347C385A4;
 Mon, 25 Apr 2022 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650902417;
 bh=bsHqNUTnWPaHjYk95fjam2oUfRdQnolYudYxp8VJ/Cc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ClQWGAPen5ythVsrt/fEAktc9Ksz2uFycxoeSxbIRtahyNnmKjFbLSBnmCDm1SJzD
 ZraraC3tgFmIhy2yj7crRM4lWCB9OCWbZ8tNJOPl0kXI36J8+b6AWsdvTcSCcq12vK
 0OTRhbVI5jGhl8yE13motXKoRKJGJJ5FnOXcBB2Q+fyC5OIEvm0KksVdHQhZoFC58Z
 WF/Yh62egun1CMvtzY28wRExlLHaxoKD58JCpZamhscvyRTyy/GgGUNrAdeaNBoa+r
 Xb94KWBJPz4AhBWsuCIwCZYeXUEW+YPSWwAVjfnM3fx0gb2WwRFVofTQoQOp4+cdF9
 esRLG7dVZVdyg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, broonie@kernel.org
In-Reply-To: <20220420193454.2647908-1-broonie@kernel.org>
References: <20220420193454.2647908-1-broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Reject invalid values in custom
 control put()
Message-Id: <165090241595.345430.5261147356575989564.b4-ty@kernel.org>
Date: Mon, 25 Apr 2022 17:00:15 +0100
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

On Wed, 20 Apr 2022 20:34:53 +0100, Mark Brown wrote:
> The max98090 driver has a custom put function for some controls which can
> only be updated in certain circumstances which makes no effort to validate
> that input is suitable for the control, allowing out of spec values to be
> written to the hardware and presented to userspace. Fix this by returning
> an error when invalid values are written.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98090: Reject invalid values in custom control put()
      commit: 2fbe467bcbfc760a08f08475eea6bbd4c2874319
[2/2] ASoC: max98090: Generate notifications on changes for custom control
      commit: 13fcf676d9e102594effc686d98521ff5c90b925

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
