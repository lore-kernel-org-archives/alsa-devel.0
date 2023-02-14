Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B25C61DA4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 18:03:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55DCEDF6;
	Tue, 14 Feb 2023 19:03:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55DCEDF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676397832;
	bh=awND0EjP9fvq4Q94FyZHVMCMXE5R653wqzWUUQcPrvU=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JRM9PTif+H12EV7hDnd2/CWsSn8i4y/ZOpRSbks7svGtLAl/xFqBew6OObzM4Hk9j
	 vs8P8DSHwnvnDdaqSqDoI++z9xV177mJ9T9tBO2s6hsTt1XK4WSL3E4jccCvBiBxfh
	 ZZ7pqMAtbUBfoU/+u//dzFVeKjwxe/ikQ/l8SKtc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC03EF80549;
	Tue, 14 Feb 2023 19:01:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BAF86F80496; Tue, 14 Feb 2023 19:01:47 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CCD1CF80496
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 19:01:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCD1CF80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OmWRfV2d
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 653E0B81EA1;
	Tue, 14 Feb 2023 18:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3351C433D2;
	Tue, 14 Feb 2023 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676397703;
	bh=awND0EjP9fvq4Q94FyZHVMCMXE5R653wqzWUUQcPrvU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OmWRfV2dbTxL/dWS2cmyjsmPHj85akQ8rTAJ7SkqXLf7ZYH/S23CTmCjuExwRGVTj
	 fIbl8QKEB6hJBE75qfnwe7mND/XRVLhVn98hvlloz5+HVbJIzGoc9LG7UlsXJdqDU1
	 0LDtlE7g6Apa8YiD6ZbEAT8PC7vnv+39ZuRBzmb6umIqwQ6MbqZ1ikjsIv/lnMg/ej
	 dbgVRB12k9eLYev4SgJOVZW9IUrG8svEVdKoBGKvGvM50sS9gzP6nx7czG+5FaOTOs
	 8aqe2itpUl56SAzbXhdGM6jDuvAu1ViOVk2dImmQX467vN90o4BiB/TApC4tlribmV
	 PTKIasa2v/tow==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
In-Reply-To: <Y+p9r5y9DPSJkPVf@ubun2204.myguest.virtualbox.org>
References: <Y+p9r5y9DPSJkPVf@ubun2204.myguest.virtualbox.org>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Remove unused variable
Message-Id: <167639769854.3067697.826075385352580657.b4-ty@kernel.org>
Date: Tue, 14 Feb 2023 18:01:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Message-ID-Hash: B7BPSYAFQAVW6Z4UDJQN3VMSA32VZW4M
X-Message-ID-Hash: B7BPSYAFQAVW6Z4UDJQN3VMSA32VZW4M
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Saurabh Singh Sengar <ssengar@microsoft.com>,
 Praveen Kumar <kumarpraveen@linux.microsoft.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B7BPSYAFQAVW6Z4UDJQN3VMSA32VZW4M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 13 Feb 2023 23:43:03 +0530, Deepak R Varma wrote:
> Variable ret is initialed but is never modified or used except for
> returning the initial value 0. The value can be directly returned
> instead and the variable definition can be dropped.
> Issue identified using returnvar.cocci Coccinelle semantic patch.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: Remove unused variable
      commit: 88541443497d47313ec4de1ecc1946288ae0ed16

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

