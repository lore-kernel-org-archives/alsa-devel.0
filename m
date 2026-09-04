Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFBEC79F82
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:11:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AAE660201;
	Fri,  4 Sep 2026 22:11:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AAE660201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788552685;
	bh=KouETztfN/mGp7RZFdrBAOhN3ydprk2sioBxfEDIYD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rMcmjd6uMhRqd+k2KcNRjIsdLHIjGInwQzf1/Opn0p8Lx3BSaQG1KzkmgEqqL5YIi
	 f/ErCVXz8R8QY4kgbrqiezxwJC9zRbq9Qjquki27xLz09cXRX17jxgF6aO3GB9gs96
	 ZWEgYMZZZ/8pyg8Td3LrIu7cuYVGeyKNJbYaUss4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7176F805F2; Fri,  4 Sep 2026 22:10:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 699B5F80601;
	Fri,  4 Sep 2026 22:10:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8245F8049C; Fri,  4 Sep 2026 22:10:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788552643;
	b=e6PpI5mU/6ojPEslU7G9YH2T6fIwt5otCW3sk4cghrO8ZtoqJwxOU5Pr8MxjP06NgWFH
	 d0dxeceAwBgUAXBsKZC3ZoFmK2/qj4TBwhPMI+DRlu2SHZbxrhILkOG/6GIkt7D2evT1r
	 k3DYw98JBMNNbWY4R9A2zQMBRe2nx2VPAzs36PUM/MCQPv4M67yZ49iw9kI1eRqvyIzUP
	 jcalCwf+boILY2voFlpA/13Xy17sl6UX34eN+j/99VB1o6dy036nfj0hESHMVcdcbEphK
	 sU7imFNhJU6zTDE2XFV4OsnJo8eJRK47aedo2BTwlPvPRJRdWd/G3SGSLHwtUxbmUmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788552643;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=KouETztfN/mGp7RZFdrBAOhN3ydprk2sioBxfEDIYD4=;
	b=nJuUwyAWFXfuSlL6wMM/cRbQGJhxBr082OJdf/GdnS17krr31W8JqlrVvBZkXZlaX6hb
	 YSUZcZGbdBBM9/7rTi16KjSgF/6hWm7ryp8wbpmIQ/mMkgOJnljvb15t+/B7WzceUado+
	 qPlsNrFwlN26Kr3CaVSjOmOdZD1NhwW80CgqicmxY0XwKZznXgmTdHNHlayisPbGPkEeS
	 LBBKyUecOgiYRq7zOXnM+AG++JbiuHUo/HWm6PzCAiFtWxiFJXBf5T2naKsD1Sv8bFaxZ
	 YlNgXvJbBFBdRfw7KbFaG08fs7AExbboPF9moV5VHtszE/X7x3teSW+RAgNea8jdsfg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="lr/LjaDW";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BCF15F8027B
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 22:10:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCF15F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lr/LjaDW
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 551CC4093A;
	Fri,  4 Sep 2026 20:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B9E1F00A3E;
	Fri,  4 Sep 2026 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552639;
	bh=I0S92nhD9viTVQZ6laHD4KPftAfxERiYP7FmJsp8UL0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lr/LjaDW9N6Bpe/6cdL6479zwR2fKj4TLug/1eyCWqUfcclqevAIZ5kcqowSt8oYJ
	 urSBoNxg9ySbEw9hwAwbFlQaIXAMYJDynQlWi2xaj4nfZXcGREngec1iHofhr0BUWe
	 Se3ta08NFhjQeR/sy7fhFB26Di5nepT1+xMI4+cTf5o7CP0LRe7NfgyUSRuxW7BkAI
	 9Q4KoP7lCs8G0B07bnNXQvt4SrH+sJdc357G21AR6we+oVcbm5rI2kZxe0uUWISBUa
	 fydK9xzQoG04RxqsebCNSmPdr+OtPAZj9aqcVCuv9hrEFpIo8MklgoLGpQNJWmyQDJ
	 iYHvHzc6JoKOQ==
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
In-Reply-To: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
References: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
Subject: Re: (subset) [PATCH v2 0/2] ASoC: codecs: nau8360: Add DSP
 fallback and PEQ band initialization
Message-Id: <178854413324.632048.16181974298837410103.b4-ty@b4>
Date: Fri, 04 Sep 2026 18:48:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KouETztfN/mGp7RZFdrBAOhN3ydprk2sioBxfEDIYD4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqmyW5CHmZIsfH0bYXLbLvUKZjoXrYrgwByweJm
 PS0zWEb0ymJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapsluQAKCRAk1otyXVSH
 0LraB/99GK8X9AY197m83eozpYp3bH/07Zj1zJ7HutcI6x/+jfzHZIuooo7nbVcm7CFXKd6YazL
 z5OY4DOdb7pOTMXii25qnQF1XsGcpJ/BZUicm6UxBdy8EUaPutIdjJRejCcT52JyhpjXvcWNVea
 +scGexE52CDAnzbNTXEZl5zeFaC4AnMnNBrFkaQOvgyqpUvDDCSOoxmikar6f/pMQ1/KuDIH+Iy
 5OABQDCOrHv03OUQooTcSjhahGkIKObxM/TXB7oDZXjO6SYClLzMxHGMFESuADMy4zgc9Omkd+E
 sKMZGVviwi5VayKcULvv8ieFV0ecGzD+Qj4HL9HH/NgXUppi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 7HLYTQAF5IHT3IT3EGYMCUJ2BG7EKJQT
X-Message-ID-Hash: 7HLYTQAF5IHT3IT3EGYMCUJ2BG7EKJQT
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7HLYTQAF5IHT3IT3EGYMCUJ2BG7EKJQT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 04 Sep 2026 14:00:33 +0800, Neo Chang wrote:
> ASoC: codecs: nau8360: Add DSP fallback and PEQ band initialization
> 
> This patch series adds a fallback mechanism for the NAU8360 DSP during
> firmware load failure and ensures proper initialization for PEQ bands.
> 
> It includes the following changes:
> - Fallback to bypass mode automatically when DSP firmware fails to load,
>   ensuring basic audio playback remains functional.
> - Set a default PEQ band number during DSP initialization to prevent
>   invalid state or uninitialized parameters before user configuration
>   is applied.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[2/2] ASoC: codecs: nau8360: Add default PEQ band number for DSP init
      https://git.kernel.org/broonie/sound/c/366e4d4f0ca8

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

