Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28498CF886E
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2024 03:52:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08382825;
	Sat,  5 Oct 2024 05:52:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08382825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1728100347;
	bh=bNn/QBpodekePm5KFYgxmgd7eE6ENvnHgXuWL/QoTNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aSLe5tTASMaJyfC5OFfo/mvunWA8JtlZ0R5OsDgVReYba7yxF0Sr0Rva06u6LtM52
	 JRykW+nmOv96scQ0tWgV5QRs/JWpjALlf+bkJGunc5oD3AI/2gDZIKAWxEv5CyskIx
	 v23SyiqCKkzpO8oFS8qN1XJtYOj+WM60r+QYM4Sw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B413AF805EA; Sat,  5 Oct 2024 05:51:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34DBDF805D8;
	Sat,  5 Oct 2024 05:51:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2408F80517; Sat,  5 Oct 2024 05:51:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F2E50F80107
	for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2024 05:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2E50F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=revj7i0A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1C8F25C5AFE;
	Sat,  5 Oct 2024 03:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C08C4CEC7;
	Sat,  5 Oct 2024 03:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728100282;
	bh=bNn/QBpodekePm5KFYgxmgd7eE6ENvnHgXuWL/QoTNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=revj7i0AWAhiFTx8DH+9fuMH6Xnmtzq/YoWA9dJncZLQBNvEJOo791zYqzVP7oOG1
	 0yDHpzDmOKt25CDtF7AjxHUGLJcwqDq2jFm6QUtPmJVbgOxBUqYxKgLzmOhTifsz6M
	 Ddorxqvd87VODj5TiMcU9yL0TjFXMZbQ4DgxGDz/iq98vc8YR1B7i0HvVE+W5CbheP
	 vKeTu4p4cPPYXSzwWlOLWOJUWPmVXuCvM/YsNfwYpFqshO0rx7kwerZR5hE2Ncg64c
	 3/xbs2AWZbpMrgOwnMymDzsJnh82nVD30nGWG0EZtzrWc7MS0xC0TLFPDFgoL77cXK
	 jUJcB81MpgzMg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.orgs, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com
In-Reply-To: <20241004141046.61265-1-advaitdhamorikar@gmail.com>
References: <20241004141046.61265-1-advaitdhamorikar@gmail.com>
Subject: Re: [PATCH] Fix unsigned int compared against 0
Message-Id: <172810027926.832098.9733222670620513486.b4-ty@kernel.org>
Date: Sat, 05 Oct 2024 04:51:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: M6PMGAIC5M6KCDN6M6SNCRAMDUPTVOKB
X-Message-ID-Hash: M6PMGAIC5M6KCDN6M6SNCRAMDUPTVOKB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M6PMGAIC5M6KCDN6M6SNCRAMDUPTVOKB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 04 Oct 2024 19:40:46 +0530, Advait Dhamorikar wrote:
> An unsigned value held by offset can never be
> negative, so this test will always evaluate
> the same way and is therefore redundant.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Fix unsigned int compared against 0
      commit: 40ba40fa4e054c62507026454529e3d530e10456

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

