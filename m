Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AC0C61DA4
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Feb 2023 14:34:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37B72EAE;
	Thu, 16 Feb 2023 15:33:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37B72EAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676558070;
	bh=QqmQt/krC6S5uww76juPUBb0WAImXoL3KsjKZXWfA/0=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J+INZqaHJlDAGltGWaJr06kRsmJKV9inoQMbrhrDXt7aK8jlA2aLdBiy490j4arqz
	 XJHaOGje3LCxF7ZjeXn1t+Wohsy1eT3no98oeQC94zPBw/baZgl6ja8uf2Ic7U5xz/
	 9wSsepqjFGyBsXE+nXtpfnAPfZLrGXqNXnX4kJbo=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 887E6F80171;
	Thu, 16 Feb 2023 15:33:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 128E4F80171; Thu, 16 Feb 2023 15:33:13 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9DE5CF80083
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2023 15:33:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DE5CF80083
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ADjwh5iL
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 272B761380;
	Thu, 16 Feb 2023 14:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CB3C433D2;
	Thu, 16 Feb 2023 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676557980;
	bh=QqmQt/krC6S5uww76juPUBb0WAImXoL3KsjKZXWfA/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ADjwh5iLY63HLuZVMYO4D5VbvkVzcEIiH36I7s2fBoYZDw0WSjgdWOEWLRTH/UrJf
	 F83j9PoLNzjS8YK74bYntQ0jIk89Ae6Cd0cGkMRCOMq57jLgthe7x7XzsKtG1GumYW
	 pnxgQl66eeekB6B9eQXjE5AkQaXXQ0mGAELuo+Xutnol8o3198y/BR+hefq0QFft6a
	 CB3ZQaRdzA/XO70ucrrGXLyrHZ0QbgVND6b9qra0Czc0SHgQimWIRxNbTgVEEr//5n
	 09osxMH5cJ1w9xYh54aCgjM5MzmC57qzp6MUVbMBdvFIsSnTqPVlTRUbQveGnfZiaZ
	 RVgae3W4elUJw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: 
 <ac6365c17861d71fbc89d823089db4aafdb763ed.1676470202.git.geert+renesas@glider.be>
References: 
 <ac6365c17861d71fbc89d823089db4aafdb763ed.1676470202.git.geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: rsnd: adg: Fix BRG typos
Message-Id: <167655797866.4030382.9723735853907637449.b4-ty@kernel.org>
Date: Thu, 16 Feb 2023 14:32:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Message-ID-Hash: L5SURCLKYUV26LGDBS6XR75X7ICIHBVB
X-Message-ID-Hash: L5SURCLKYUV26LGDBS6XR75X7ICIHBVB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L5SURCLKYUV26LGDBS6XR75X7ICIHBVB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 15 Feb 2023 15:17:41 +0100, Geert Uytterhoeven wrote:
> "BRG" stands for "Baud Rate Generator", but is frequently misspelled as
> "RBG".
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: adg: Fix BRG typos
      commit: 4932b1fa61322b737dc3615a298aafdc42f97f79

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

