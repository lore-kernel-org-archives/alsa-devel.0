Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DC3C4345F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Apr 2024 02:34:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3046914DC;
	Mon, 15 Apr 2024 04:34:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3046914DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713148469;
	bh=hUWeATT5T38ifea+Zzg6D9nVoCaVH8jly3lg55fWlfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oIP668bYTKb3E0mXOS4xOGUKfOjo80J9OnzQazlTnaTUSb1ACr7IsOa/fHi4Pvh8c
	 vV6zhnHLA7+dlt2hxCOCIhFX5+gkn/bNCceqITT/Y/DDEji8xMOmatSpnxYx03zDmO
	 5EQ+EezKyIZcvdV7H4KAz1uTvcnJaQauO/4v5fL0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31F64F805B4; Mon, 15 Apr 2024 04:33:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AC7DF80423;
	Mon, 15 Apr 2024 04:33:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B759F8013D; Mon, 15 Apr 2024 04:29:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FD4BF8025A
	for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2024 04:26:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FD4BF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qAdTu9dg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A2FEB60B9C;
	Mon, 15 Apr 2024 02:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA5C072AA;
	Mon, 15 Apr 2024 02:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713147980;
	bh=hUWeATT5T38ifea+Zzg6D9nVoCaVH8jly3lg55fWlfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qAdTu9dgBuem59jTd3F3Gx8fheDpdt8MKMiYlbQPxZFRdOi9ui8/8H9deYgOuJ8us
	 r00FM8GMmh0piXphsvPr7YHnLKdbS41j3YnhDMppfFz/AldYj5wzSHN5tM+Xrz/UcF
	 cZm1NGHm4H0ZDEAvKx0u7lEtxzcayr2Re5OiLOI6lTJfLdNt4Z9bYI9Jw3njTIv0cK
	 ow0hajo/8GFt/bMc5ly6/gf90E3hym1p7Vzb6QFqEpVqTMBzWjGY+BqWDRwkCXbeBu
	 Dc98+JJooRVBJ/wzMoWRs0Yj9v8P0meI9S6sLXTmTyUsgcSzB561+Y4S04KEgRC6nZ
	 3QXflrCNEpKDA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
In-Reply-To: <8734rrcewo.wl-kuninori.morimoto.gx@renesas.com>
References: <8734rrcewo.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rsnd: add missing
 renesas,rcar_sound-gen4
Message-Id: <171314797915.1649319.14493145148801179743.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 11:26:19 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: 6BAQFABRZ2COOQK2GRYCUY4Y2MBU6QKI
X-Message-ID-Hash: 6BAQFABRZ2COOQK2GRYCUY4Y2MBU6QKI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6BAQFABRZ2COOQK2GRYCUY4Y2MBU6QKI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 12 Apr 2024 05:45:43 +0000, Kuninori Morimoto wrote:
> It is missing generic compatible for R-Car Gen4
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas,rsnd: add missing renesas,rcar_sound-gen4
      commit: f284b23809bf54f8189f82f822f099e43d6a0a35

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

