Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F16C61D97
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Nov 2023 17:19:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 825B1AEA;
	Thu, 23 Nov 2023 18:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 825B1AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700759983;
	bh=EvzPaWl4rEWWAqN92zDuxih44+QveIo6CQqfvVtHmxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=in4xde1a9L1iBzfLHalKoy7VOv2TeRuqqkoPAz8lSEZwg0k76Twd/uIntmL+1gWye
	 QkwmROxk5agO/Og7hn0USH63dDtqg4cVnYft565uGhXJtX6DBLcZZo1Ys1RUIvGkhI
	 Yf2YjVaoMuVLVolkObAJ6MK1uTYF5uAnfgvgqETY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93037F80567; Thu, 23 Nov 2023 18:19:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB2CBF8047D;
	Thu, 23 Nov 2023 18:19:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14866F80249; Thu, 23 Nov 2023 18:05:54 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9A9CFF80249
	for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2023 18:00:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A9CFF80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ut51JJ2B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 96292CE2B3B;
	Thu, 23 Nov 2023 17:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9510EC43397;
	Thu, 23 Nov 2023 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758802;
	bh=EvzPaWl4rEWWAqN92zDuxih44+QveIo6CQqfvVtHmxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ut51JJ2B31MOyFR3mR2gsVC1yQJUTnd2mInxrcNp6lXSoTIHMr6anHzBixsognlP/
	 ATUOchYc+UKMA3zGAjkvppOWxiokiEu+uYPaPnrIONO3YRtkruLyAPzVSPfE7AbIC+
	 9lUSCrewRfLkLgcJuUdg7g/PTXgt2KrVVWoa5opbf1RM6E64gBDR7zT+JWZs5YZrhP
	 K2P4DYJMZ23yHKAv4XGHHdTH2RgRZlq58RuieGmAJDlewM/gSB95zR8oInLZOGVoco
	 ls0t1bfjcfvhoZi46iN1OJXzxbMkEhK8YevIhDGzFxvEDtJZX+2Go4raS8IAfTKBeg
	 SX/kMRMjp42TQ==
From: Mark Brown <broonie@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231123090658.10418-1-mstrozek@opensource.cirrus.com>
References: <20231123090658.10418-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v5] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-Id: <170075880043.2448402.15081787699005605640.b4-ty@kernel.org>
Date: Thu, 23 Nov 2023 17:00:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: XNYHVJMANBWHGWLV2RPKG6ZO45KJO6OU
X-Message-ID-Hash: XNYHVJMANBWHGWLV2RPKG6ZO45KJO6OU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XNYHVJMANBWHGWLV2RPKG6ZO45KJO6OU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 23 Nov 2023 09:06:58 +0000, Maciej Strozek wrote:
> Add a polling mechanism that will keep the driver operational even in
> absence of physical IRQ connection. If IRQ line is detected, the driver
> will continue working as usual, in case of missing IRQ line it will
> fallback to the polling mechanism introduced in this change.
> This will support users which choose not to connect an IRQ line as it
> is not critical to part's operation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs43130: Allow driver to work without IRQ connection
      commit: fa91703dc2e010e48a230dc92967cb5ae23f8680

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

