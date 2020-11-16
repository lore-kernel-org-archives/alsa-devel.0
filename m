Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D8C388F9
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 23:35:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E81524198
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 23:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ssc5LoC+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyMntYXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E81524198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBC4B1766;
	Tue, 17 Nov 2020 00:34:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBC4B1766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605569701;
	bh=W4iJDW29qaYIvsy6pPudjqFsYGbUiXej+ClOVk6wkbE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ssc5LoC+80bmHUuFGbPCMQK5ldEwHFoXClcpb2hCr7WFk/g+lpRXij0c06Vx+NY+B
	 Se4+NyGE5BHrdZhJzE1lC4l9qVoW0x2PF7u06xH5Q1U6sIeIx+7YAK/S2jhEGvPzPy
	 mbq/qwmej5iyl9jsFzJVJRcsGe23SakFKOo1a3xg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44239F802A9;
	Tue, 17 Nov 2020 00:33:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FE4BF8016C; Tue, 17 Nov 2020 00:33:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 519FDF8016C
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 00:33:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 519FDF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uyMntYXI"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20CB02224B;
 Mon, 16 Nov 2020 23:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605569595;
 bh=W4iJDW29qaYIvsy6pPudjqFsYGbUiXej+ClOVk6wkbE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=uyMntYXIAHZCuB2k0gyDph9z4nbpMEFfvhFwqbzmppERcIXSzZrTYQiJ3bDKKWWR2
 Kgkavfj80xQPfypABwXMougZwGNm0R9c5LDP/75xIHcxg3/3EYTHxkPRqWovjZf+CI
 C25tAWg1uuECCySkCFc+otv8CtXXXJkmPeZZnRKs=
Date: Mon, 16 Nov 2020 23:32:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Kirill Marinushkin <kmarinushkin@birdec.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20201115122306.18164-1-kmarinushkin@birdec.com>
References: <20201115122306.18164-1-kmarinushkin@birdec.com>
Subject: Re: [PATCH v3 0/4] ASoC: pcm512x: Patch series to set fmt from
 `set_fmt()`
Message-Id: <160556956526.29683.6599781233206972727.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Matthias Reichl <hias@horus.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Sun, 15 Nov 2020 13:23:02 +0100, Kirill Marinushkin wrote:
> Set format from `set_fmt()` func instead of `hw_params()`, plus supportive
> commits
> 
> Kirill Marinushkin (4):
>   ASoC: pcm512x: Fix not setting word length if DAIFMT_CBS_CFS
>   ASoC: pcm512x: Rearrange operations in `hw_params()`
>   ASoC: pcm512x: Move format check into `set_fmt()`
>   ASoC: pcm512x: Add support for more data formats
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: pcm512x: Fix not setting word length if DAIFMT_CBS_CFS
      commit: 6feaaa7c19bde25595e03bf883953f85711e4ac8
[2/4] ASoC: pcm512x: Rearrange operations in `hw_params()`
      commit: 798714b6121d833c8abe4161761a94fdd1e73a90
[3/4] ASoC: pcm512x: Move format check into `set_fmt()`
      commit: 26b97d95a05d0346e1ad6096deedac3f24a4607b
[4/4] ASoC: pcm512x: Add support for more data formats
      commit: 25d27c4f68d2040c4772d586be3e02ee99eb71af

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
