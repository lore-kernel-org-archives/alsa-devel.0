Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E725C27C7B
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jun 2024 17:26:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 266C186F;
	Wed, 12 Jun 2024 19:26:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 266C186F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718213192;
	bh=OK6qbZ0vnNzVV/sfoCYgFy2+diPsXnMq6GJhiiEBkqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=c8k0iXOPJG5pKiD/ZUFMBnvh1HmGBiHeiGDYM7be/9hB4U3GtN+lKkGKvVdaoYbYc
	 BWsekxfI0sJ7VeYSchUCqbM9MKubA3kIxKKRTHqbKA3imaSN2C7BpVzRjhMt8//vj9
	 kk5b2J+jNiqtvbLC3737a3vMnD1NYz94fWAdNwxw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 550C6F805AF; Wed, 12 Jun 2024 19:25:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3D88F805B3;
	Wed, 12 Jun 2024 19:25:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79BD1F8057A; Wed, 12 Jun 2024 19:25:51 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3693F80448
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2024 19:25:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3693F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=idsETjRo
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D15C3CE1298;
	Wed, 12 Jun 2024 17:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D82C116B1;
	Wed, 12 Jun 2024 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718213142;
	bh=OK6qbZ0vnNzVV/sfoCYgFy2+diPsXnMq6GJhiiEBkqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=idsETjRovWK/GS7qYp0LF/BUjTYnBRhnBQk+GH8O/gBjiAFb0r1Prz7f93za8/Rfb
	 8QRtIEyn0oUx6Rk8rOgwP3sYY6Cm7gfkJMihZmBX55RtTsc6sohzX8xO835Wim14lY
	 RNIaTiC+Z7iKE3OVCrnrz9t3gjR6ifFds8vNH3R9Ruqalo/nk/MQeDRabSXDDlHiMa
	 GVe1NA9vLejS+TXVm+yTxBPI+7K6cj2aJg4DPrUHsK6mSqLXzOnpuj/EUTPiyGj8XQ
	 QzCXCaMJoQYiHc6N/K9VVJb6GD8s4Ft0bfqCwiW5AbzupPvGp3DlrprM5tguPe5nmh
	 xMDgd9cRlCNPQ==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-omap@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Primoz Fiser <primoz.fiser@norik.com>
Cc: upstream@lists.phytec.de
In-Reply-To: <20240610125847.773394-1-primoz.fiser@norik.com>
References: <20240610125847.773394-1-primoz.fiser@norik.com>
Subject: Re: [PATCH v2] ASoC: ti: omap-hdmi: Fix too long driver name
Message-Id: <171821313984.235346.8948491995982488309.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 18:25:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370
Message-ID-Hash: V4NLQI5HW2NYVKJSVWONPHZTAGEDHRN6
X-Message-ID-Hash: V4NLQI5HW2NYVKJSVWONPHZTAGEDHRN6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V4NLQI5HW2NYVKJSVWONPHZTAGEDHRN6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 10 Jun 2024 14:58:47 +0200, Primoz Fiser wrote:
> Set driver name to "HDMI". This simplifies the code and gets rid of
> the following error messages:
> 
>   ASoC: driver name too long 'HDMI 58040000.encoder' -> 'HDMI_58040000_e'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: omap-hdmi: Fix too long driver name
      commit: 524d3f126362b6033e92cbe107ae2158d7fbff94

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

