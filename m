Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F5FC2BA15
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:55:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDA26847;
	Wed, 19 Jun 2024 12:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDA26847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718794531;
	bh=N0AaIoaI8diruOmcEr/EmRanq5T/ngLihO0rujTQU78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZzD+WXWRkOJ4nhcC1Hcfg5A6rWWMF83v9l4k1Pnx86nHJ+M0AIH2j4Y2FIMd6T10T
	 r/jjeR+HUeOjjap102iHyMPO9G2yN589RrlLxy3W1qqozErNSBRhjBcYfThqW6eUd6
	 sWyg4mzACfSZtz2xnABNsMy8qV55q2W4tkP4q/80=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C974EF805E7; Wed, 19 Jun 2024 12:54:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F24CF805E5;
	Wed, 19 Jun 2024 12:54:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 830D3F805BF; Wed, 19 Jun 2024 12:54:44 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A46FF80587
	for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2024 12:54:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A46FF80587
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=f2/oRfA8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D66E3CE0AFF;
	Wed, 19 Jun 2024 10:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9098AC2BBFC;
	Wed, 19 Jun 2024 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718794455;
	bh=N0AaIoaI8diruOmcEr/EmRanq5T/ngLihO0rujTQU78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=f2/oRfA8kROKWSq4TTqiPkVBRCclvzSMTfpEg3PfQ399JVGn2LthCJKcB36KNvJLW
	 5idm9KaPMxumoWwQXogxmR/u5ie+TjVPMk1GUJJall/UbJXUci0Js2uiOuf1ZXg8O4
	 Jz+om+pD6ghTUqgMfboeaaqEDzXdeeOZuIaWQ+GFwEEJQmJnBZotG1WWHj7gw81Kow
	 WJXDlMrzVYTaM33/0ZCoVdhQSnDa5cAXdafPkVKTmwr7ICZGaH04beD12TvsC/SPkS
	 WR4mosDtnq41UZkMraUJF6ykZhWYxnidGeJ/Nk9YlsCAeBQNkGIxaB2lVY2KvhFFnV
	 NeD4dEcuMaLqg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree@vger.kernel.org
In-Reply-To: <87jzin3yc8.wl-kuninori.morimoto.gx@renesas.com>
References: <87jzin3yc8.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: audio-graph-card2: add support for
 aux devices
Message-Id: <171879445303.57943.18127033845572445791.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 11:54:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: 6STJQIKQPLIR5MRVG4RQHD7XCSVSMGXT
X-Message-ID-Hash: 6STJQIKQPLIR5MRVG4RQHD7XCSVSMGXT
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6STJQIKQPLIR5MRVG4RQHD7XCSVSMGXT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 18 Jun 2024 00:10:15 +0000, Kuninori Morimoto wrote:
> Add device tree property to define auxiliary devices to be added to
> Audio Graph Card which is already supported on Simle Card.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: audio-graph-card2: add support for aux devices
      commit: 7109f10ca4225c4a7e47dee5eab0d8d72edbf324

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

