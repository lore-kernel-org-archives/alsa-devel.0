Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52311C2BD09
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:08:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59CC2DFA;
	Wed,  3 Jul 2024 16:08:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59CC2DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720015696;
	bh=cg4oQWa4mAvOE44mdOlcpdj6cbZ+HMPUwfv7SHiAbQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qcWo/5MtOMgTHgexPkODlj6Tsol9OxuLPgapJ/2lGMs6mf41WjsNqOuI+VeyurOvo
	 HgaS1Aapsrrod2mJSliI0qiLy5SOOQCCS0jMHYcYs20jCxhZaCgFQgRnr7cJOgvtAn
	 UYi4nPvoHJzuJZCcBij+WODPDVrP5abzUYT7tyic=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD730F800F8; Wed,  3 Jul 2024 16:07:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B78DF805AC;
	Wed,  3 Jul 2024 16:07:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D94EF8025E; Wed,  3 Jul 2024 16:07:32 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 276E5F800F8
	for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2024 16:07:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 276E5F800F8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pozSQlOP
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0966CCE2B48;
	Wed,  3 Jul 2024 14:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C45C4AF07;
	Wed,  3 Jul 2024 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015632;
	bh=cg4oQWa4mAvOE44mdOlcpdj6cbZ+HMPUwfv7SHiAbQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pozSQlOP0sdfd+dpy5AHIdtEZc2q59DrIN3Ite/3XX7RzlDpnJ0Zp8o4ocQSD1fWp
	 5Vgp2/jRIfWDsgm9HsK2G1f8krds1YE8j4PCvvEqPSE7aEGyrT094SkcyPALUhHABc
	 EC46aHoU3H6cft9nY3M6P+uN6NVuQGu6DpLttyw/q0gfWt90yllorgQKaEfSs5XlMg
	 f1mKGCZi6Pj6Rk0DmnwSMaQaFxPIYdX41Y0/rcXI5nwLZm2ZXegGRAA6Yb9sRvVjgr
	 657oKwd+BTXoxDK5TnzX8SV//1M6GHKg2ox9QJ9muwltAeUxaxsd7WDesk1TmVB1Yx
	 Wc6S2OYm97T0g==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240702215402.839673-1-robh@kernel.org>
References: <20240702215402.839673-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: tas2781: Use of_property_read_reg()
Message-Id: <172001563047.37877.18071249071920971995.b4-ty@kernel.org>
Date: Wed, 03 Jul 2024 15:07:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: FCWWL5UUKZK4YJU3KUEK6P3PHF6XT5NI
X-Message-ID-Hash: FCWWL5UUKZK4YJU3KUEK6P3PHF6XT5NI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FCWWL5UUKZK4YJU3KUEK6P3PHF6XT5NI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 02 Jul 2024 15:54:01 -0600, Rob Herring (Arm) wrote:
> Replace the open-coded parsing of "reg" with of_property_read_reg().
> The #ifdef is also easily replaced with IS_ENABLED().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Use of_property_read_reg()
      commit: 31a45f9190b5b4f5cd8cdec8471babd5215eee04

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

