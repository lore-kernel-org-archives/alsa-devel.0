Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9863C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 17:00:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E39C6845;
	Mon, 31 Jul 2023 19:00:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E39C6845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690822851;
	bh=CJXv5LTyvEZlFSDwEZHeU4bYBpFsz8Qe4FlzBgpaJXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vEnkS5JU2cPyFPA3jVG/68BY1Df0pOX27ByKQin4paYpax05ohQHDT6MFYw7AoQAs
	 uiEpsT4Y2C/Ubac3AGO+FWMR6q1A7rMxg4Hpk6+k1jE7DavT8BfH2vwRZVj/ESdi9i
	 +Ui7YE9dvRnGMdBAdTnd8YJo7cfaN0OYlUK/6zXY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3627BF80544; Mon, 31 Jul 2023 18:58:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DF784F80553;
	Mon, 31 Jul 2023 18:58:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 896D9F805C5; Mon, 31 Jul 2023 18:58:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 449D7F80548
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 18:58:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 449D7F80548
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mWdHtK6e
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDDC6123E;
	Mon, 31 Jul 2023 16:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906BFC433C8;
	Mon, 31 Jul 2023 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690822689;
	bh=CJXv5LTyvEZlFSDwEZHeU4bYBpFsz8Qe4FlzBgpaJXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mWdHtK6eRA+JGRP2MaoMMo72/BqzlMnoO3Lw2tx+VUmXmUqh9S4hFR5Ea8ZvkEGOY
	 C0oYF8sOZK+mJnTMZKuq+kbmOf5KUMHgL/q8xop5dztVOQv3Z0VZdP5iIqiS20pFaq
	 M1HYrWt+F+PcRxU8wUb0t6yidzC3aDeHSfZ/ltN3IIvi0TkAmEdGO0KWUAkMI8qvX7
	 GXlbm5/f8tzOo4K8e98bPZEmWHZR/m1JEVw2EMZZxVOPIYdbSY4eiOJS+wFoV2FouU
	 8TlomChhqc638ExpmF+ZMLnoXANOp9YXh7UNRkyOxttco2r3GwAbAiNHe31R57tkGV
	 aIC9Ep10U0SLA==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree@vger.kernel.org
In-Reply-To: <87y1j6b1ne.wl-kuninori.morimoto.gx@renesas.com>
References: <87y1j6b1ne.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] ASoC: rsnd: add multi Component support
Message-Id: <169082268827.169960.7424993017597355804.b4-ty@kernel.org>
Date: Mon, 31 Jul 2023 17:58:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: X3KOA3XD2OTLHP5R4QWKCIN6LI4O66V4
X-Message-ID-Hash: X3KOA3XD2OTLHP5R4QWKCIN6LI4O66V4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X3KOA3XD2OTLHP5R4QWKCIN6LI4O66V4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 24 Jul 2023 00:20:54 +0000, Kuninori Morimoto wrote:
> These are part of "ASoC: add multi Component support" patch-set.
> The patch-set supports below case as "2 Cards".
> 
> 	+-- basic board --------+
> 	|+--------+             |
> 	|| CPU ch0| <--> CodecA |
> 	||     ch1| <-+         |
> 	|+--------+   |         |
> 	+-------------|---------+
> 	+-- expansion board ----+
> 	|             |         |
> 	|             +-> CodecB|
> 	+-----------------------+
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: rsnd: use DAI driver ID instead of DAI ID
      commit: 8897a1475f278eb36d76df9684466b17b8dd4cab
[2/5] ASoC: rsnd: cleanup rsnd_dai_of_node()
      commit: 6328489c135b60380b9e12b4d23854433e96a8b0
[3/5] ASoC: rsnd: enable multi Component support for Audio Graph Card/Card2
      commit: 547b02f74e4ac1e7d295a6266d5bc93a647cd4ac
[4/5] ASoC: dt-bindings: renesas,rsnd.yaml: add common port-def
      commit: 289f6e3bdc3f3cf752794be3820b0e5c394b2733
[5/5] ASoC: dt-bindings: renesas,rsnd.yaml: enable multi ports for multi Component support
      commit: 1638290414bd68a87acae125e9fe3e419267bd01

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

