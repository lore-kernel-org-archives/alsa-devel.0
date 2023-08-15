Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FC3C0015E
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 18:11:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 119263E8;
	Tue, 15 Aug 2023 20:10:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 119263E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692123068;
	bh=8SbSTdwWAC6vlP8LelZTFJqMZ1r9EHSGHBqksxH1Eqs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lre6wey36s5/BsE3LYLHVxHDX3lMzxGAexmO+yySPxk9DwHewxwPz1p2qZIEome+G
	 XIjdM9q2Trr0yY3Oy2qZWPVO1kqpRyxmWpo/xjhAqxgwgTKY2/FLARCgUPX/BQ37Lz
	 8MPbgGcTrXrXIBTPDKIJ6t9ZxbOHr+OWRn2wLYpc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F508F80552; Tue, 15 Aug 2023 20:09:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E9D06F80536;
	Tue, 15 Aug 2023 20:09:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 399EEF8016D; Tue, 15 Aug 2023 20:09:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BFEA8F80074
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 20:09:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFEA8F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ttXtUQMw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 75455653DD;
	Tue, 15 Aug 2023 18:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA0C433C9;
	Tue, 15 Aug 2023 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692122954;
	bh=8SbSTdwWAC6vlP8LelZTFJqMZ1r9EHSGHBqksxH1Eqs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ttXtUQMwquHmisr9Wx7x340A3GrzH5J2jDQO6ZzfNQslZOlb/l88prR0HophIMWw4
	 z/Z0n2vw9En7atkB+INV9zah0xvb9R8OvO+F0/vGgDCchZcUrtFX9jFYWDrrn/uw+r
	 OXHLqZYJy8L69OopK64qMABLEhvTJZKwM6/S3LZZCAqxlRsQUDYMbgZIu0BK9onCGv
	 Jz8fRlqS1HvEvfo6ORKub0lVSzwpy7XfnURmnXnvTD5LMGsXHKaW6ukoWuQglz36fZ
	 SpuVRXLjqecpduWOE9XGrQvYUspPFYkFLtTfMDbkA5X5iVqJF5011YEOL0C5tapFho
	 yvkKr/oCkSzNA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 mnlife <mnlife@126.com>
In-Reply-To: <20230811142511.6570-1-mnlife@126.com>
References: <20230811142511.6570-1-mnlife@126.com>
Subject: Re: [PATCH] ASoC: soc-jack: calling snd_soc_jack_report causes a
 null pointer access
Message-Id: <169212295378.59295.3979482452886622652.b4-ty@kernel.org>
Date: Tue, 15 Aug 2023 19:09:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: 7LWAL7ZGW3DVU26E2KGST6QW55YK73UO
X-Message-ID-Hash: 7LWAL7ZGW3DVU26E2KGST6QW55YK73UO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7LWAL7ZGW3DVU26E2KGST6QW55YK73UO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 11 Aug 2023 22:25:11 +0800, mnlife wrote:
> When snd_soc_card_jack_new is not called or the call fails,
> calling this function causes a null pointer access
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-jack: calling snd_soc_jack_report causes a null pointer access
      commit: 62cc82e6486b9b66b340bbf5fb38b0171fb56a7f

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

