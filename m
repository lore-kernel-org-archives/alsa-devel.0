Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E2C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jun 2023 11:46:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59CA5836;
	Wed,  7 Jun 2023 13:45:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59CA5836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686138396;
	bh=AP8M9wi8/0wgXneuC9vS7oTfSWLOqVNSNtJq580KdG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WGWRWagumVuM47kzibZrYvFSNtTGKplzVVhqTZnttz1oS6FSzzwJ9RGbFSSA0i8Cp
	 bQPdez5YDUHhT4ICoSzWOs7q4d/Lo+xRlpwJFuYInXIKzouE6H2G8kX4P8g/QzvNfY
	 bG29EH6QKD+BZsYsFCnDhacGapVZhM9YHNemHWsw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F9AEF80494; Wed,  7 Jun 2023 13:45:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9C1CF800C8;
	Wed,  7 Jun 2023 13:45:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E252F80254; Wed,  7 Jun 2023 13:45:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 70604F80199
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 13:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70604F80199
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OjywscnI
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3FE4761579;
	Wed,  7 Jun 2023 11:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E25C433EF;
	Wed,  7 Jun 2023 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686138333;
	bh=AP8M9wi8/0wgXneuC9vS7oTfSWLOqVNSNtJq580KdG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OjywscnIT2AfAPVvXtoxiWDnWSMm2YNoPuu0e0b7YeiQSXoX23L/nrYjsx82affwR
	 4hEHOOlCcs0aYgWZNhnTZcdZ7A3pZE0AcRFYe073u0OyELOUyRw30bri5OyDajVSd0
	 DUGJTsVQKZut88B4y9yQWJmAUgCfO4rVfhUfwtMVsg+OHMrUw2u7Z0jLcXgv7VNzyQ
	 7lsrnYnzWT2KTx7DafO6MyTrijywJ6kyCc68vp5hoCup9te28L1vEH6oE70vcxKOzw
	 ZKLKfpKGqZEbdf3BjVa2sHPXrZ0x9fZEzVRdQIjqM3T03E/gUl/UO381+iYqT+5/jN
	 /3HOATOZxZExA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
In-Reply-To: <87fs7cj9mf.wl-kuninori.morimoto.gx@renesas.com>
References: <87fs7cj9mf.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: add snd_soc_get_stream_cpu()
Message-Id: <168613833286.21852.17123169582801771391.b4-ty@kernel.org>
Date: Wed, 07 Jun 2023 12:45:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: SJKNUJVGB5PAYL7O2ONM6IN3JAPHI54T
X-Message-ID-Hash: SJKNUJVGB5PAYL7O2ONM6IN3JAPHI54T
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SJKNUJVGB5PAYL7O2ONM6IN3JAPHI54T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 01 Jun 2023 00:42:49 +0000, Kuninori Morimoto wrote:
> We are using get_stream_cpu() to get CPU stream which cares
> Codec2Codec. But it is static function for now, and we want to use it
> from other files. This patch makes it global function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: add snd_soc_get_stream_cpu()
      commit: 1c943f60e830d0b959c765df09d4c4b254de0481

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

