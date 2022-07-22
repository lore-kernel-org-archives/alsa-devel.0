Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFE1C43334
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jul 2022 22:07:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB65018D3;
	Sat, 23 Jul 2022 00:06:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB65018D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658527634;
	bh=oU/aXEm4nJoyqONNRlbDnt9H4TtoyZTFmxF9qtTL25w=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EscphjnIjaOtlp9jFmVeZf5XuG/q5rVAwDJuq/vtgVugEQBUulsaQPytIHmxtcdOz
	 I4Ir/mcy+ByslBpiTrSPNDc0VCCj+CFfm85HTeXRDeOlM04UsaSj0fCv+XgUeg7JQq
	 SecB/ymH0yUZVaqdqM2GJ051gfudFc2n8U0hkahc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66D10F80279;
	Sat, 23 Jul 2022 00:05:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C193F80279; Sat, 23 Jul 2022 00:05:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A6E7F80246
 for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2022 00:05:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A6E7F80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D/cuEjPr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 251F8621E2;
 Fri, 22 Jul 2022 22:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B925C341CE;
 Fri, 22 Jul 2022 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658527548;
 bh=oU/aXEm4nJoyqONNRlbDnt9H4TtoyZTFmxF9qtTL25w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=D/cuEjPr3ARaTBbeeLJyFTN981UU44GqLg/VbzfQWmk5sdYSjMxvejQxyKg9aBQTW
 DZganrXGblOtY6BFf3ahqTgSDcZzmA5h0iAclGx0rpIUJxHYQmVVzuf+I9Fd1JCFVz
 PGurpeKaJSBpFamkef1HElOFijqpJ97p5Va32Pi4CwTiJhIWypaUTtRCDa5JSfYdhq
 ANtbL/9LICjXxTeWi41X6F+41IxyZtU6bhYIRl33aHZk3H7QFO+PG+6TwGwfdQAV8w
 xXzYFyx7Nxvjyxe5dIb+zclOh/jnhB6oOQcjHgdl87vqoAVEkfKpOcgjB4fl0hcEUu
 koUNRNe3o8Pew==
From: Mark Brown <broonie@kernel.org>
To: syed sabakareem <Syed.SabaKareem@amd.com>, alsa-devel@alsa-project.org
In-Reply-To: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
References: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Update DMI table entries
Message-Id: <165852754583.1234289.15095760330208840152.b4-ty@kernel.org>
Date: Fri, 22 Jul 2022 23:05:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
Cc: Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 open list <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com,
 markpearson@lenovo.com
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

On Fri, 22 Jul 2022 19:15:32 +0530, syed sabakareem wrote:
> Removed intel DMI product id's 21AW/21AX/21D8/21D9/21BN/21BQ
> in DMI table and updated DMI entry for AMD platform X13 Gen 3
> platform 21CM/21CN.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216267
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Update DMI table entries
      commit: be0aa8d4b0fcb4532bf7973141e911998ab39508

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
