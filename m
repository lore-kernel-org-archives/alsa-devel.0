Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3B2C4345F
	for <alsa-devel@archiver.kernel.org>; Sun,  5 May 2024 15:05:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B97320C;
	Sun,  5 May 2024 17:05:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B97320C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714921536;
	bh=oPE8LDuukrepCZDNBL3OUxIxwDD30ihJBAhHLx9X8t4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SytkrC+/GopoFS5xVmH4E8rnJU0E6eXLXX8gMck1y4cByDGGa+xIMEZFvF2SjTVaO
	 IaJ/b2zFJdF08bbXiBpJR9NTLdX2d+fMP95CithtmZGAIBr3ilmLO1XwM38AMNi8Fb
	 PW+57hgPXXh+CtTYSdPaz6o/kQu/B4oPj6MqP1t0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57817F80570; Sun,  5 May 2024 17:05:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CBABF805A9;
	Sun,  5 May 2024 17:05:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A20B0F8049C; Sun,  5 May 2024 17:03:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D4F5EF800E2
	for <alsa-devel@alsa-project.org>; Sun,  5 May 2024 17:03:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4F5EF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lsPiD4mE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F256560C90;
	Sun,  5 May 2024 15:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01065C4AF67;
	Sun,  5 May 2024 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921395;
	bh=oPE8LDuukrepCZDNBL3OUxIxwDD30ihJBAhHLx9X8t4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lsPiD4mEIK71p5yF+C4j4SpIWv7eIH7svdqYO9zD03Ks/sAQvupfnwWcXA0njDKdH
	 yNWYMrm/ON4piogM26WUP3466UZDkuTN9aJhLYYpSxsEuMUAHLx5CMJWk0EH6WlB9e
	 +852GDSY1dLJmnTnQXXgHPTo1ZHGEUrtv1QegJ30kH4XQvggtq4M0sVpxPpLFQezuj
	 kjb3ttQU4WT17yoZCvgL4rpUxjbOJDRkoF5XDwLtXyJeauWc/lPFU7ODmnK7ZRVSTl
	 Ig2e42fgDtXOfKT9PSIblf06jmf6ZogVP4jkXLI1fMSE0yFlmzpcx3I4EjJGnotyNd
	 HynQPdrq34aMg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
References: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: acp: fix for acp platform device
 creation failure
Message-Id: <171492139176.1933443.4741403457538760265.b4-ty@kernel.org>
Date: Mon, 06 May 2024 00:03:11 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: FH5TVADXZ3YUIJVH3D3H4Z6LDVO5EJJB
X-Message-ID-Hash: FH5TVADXZ3YUIJVH3D3H4Z6LDVO5EJJB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FH5TVADXZ3YUIJVH3D3H4Z6LDVO5EJJB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 02 May 2024 19:33:25 +0530, Vijendar Mukunda wrote:
> ACP pin configuration varies based on acp version.
> ACP PCI driver should read the ACP PIN config value and based on config
> value, it has to create a platform device in below two conditions.
> 1) If ACP PDM configuration is selected from BIOS and ACP PDM controller
> exists.
> 2) If ACP I2S configuration is selected from BIOS.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: acp: fix for acp platform device creation failure
      commit: 09068d624c490c0e89f33f963c402f1859964467
[2/2] ASoC: amd: acp: move chip->flag variable assignment
      (no commit info)

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

