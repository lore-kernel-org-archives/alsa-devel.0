Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE4EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 14:38:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5526F83B;
	Wed, 21 Jun 2023 16:37:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5526F83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687358283;
	bh=JX4o4QyKFOP1BI60855iMmresR8pIjC2z94Yo8Cp9Js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vLgbsR8gh2d7kZngajH4gXKGCVlcqvqk5jyTUEoUlNu2dX3DskI0dgzwRf0WtfNjG
	 LJMThV73H2Dvp1570KNbliWFsdNlADPjT4DfndNGjDetotJdTdBcvwfAQ/ETNgCKDX
	 r73t+7ouv2awNA5/fYxfT+Qga38xAxbaMJ7nJckQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1EA9F80141; Wed, 21 Jun 2023 16:37:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DFC2F80141;
	Wed, 21 Jun 2023 16:37:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B81B4F80132; Wed, 21 Jun 2023 16:37:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0866F80132
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 16:37:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0866F80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=r6QRQ2+8
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC1B61536;
	Wed, 21 Jun 2023 14:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9EDC433C0;
	Wed, 21 Jun 2023 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687358222;
	bh=JX4o4QyKFOP1BI60855iMmresR8pIjC2z94Yo8Cp9Js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r6QRQ2+8+NfYQL2vD3OCsCM2h7aZWFMIy2ra7JNSZgp+MK55Q8Vl3xBXOHWgF/Lzh
	 Cseo29bdOiFRtzhawgQ/thAQB3/0loIVv7ZqpMiRCivjx9246sHu2KdJO+BJtmWIXJ
	 +yVB2Ac6+qE8cZfAHsuFrmpjYhW0kOcEsc/3ygFkfABpA4qVXG0tXpTAQuhWAJ6wF9
	 SEskdAEAh1m2os8qEz/YBFSwdAyk6gBDfpTEQlzLWFeZFLsYxCXOVYfqy8aIknBOtB
	 WfKRj1GCfiFs7sJnSzeV37KqTytzK5cOoFALmB7zn2mSUJtE0hMevt8XL9j7qE+78W
	 LSQqI3EJpoHqA==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@denx.de>
In-Reply-To: <20230616203913.551183-1-festevam@gmail.com>
References: <20230616203913.551183-1-festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Allow passing the number of slots
 in use
Message-Id: <168735822089.116117.14058861212525541872.b4-ty@kernel.org>
Date: Wed, 21 Jun 2023 15:37:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: K35DUTU5Z33O3YUVZBF3HR73ASS52XKU
X-Message-ID-Hash: K35DUTU5Z33O3YUVZBF3HR73ASS52XKU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K35DUTU5Z33O3YUVZBF3HR73ASS52XKU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 16 Jun 2023 17:39:13 -0300, Fabio Estevam wrote:
> Currently, fsl-asoc-card supports passing the width of the TDM slot, but
> not the number of slots in use, as it harcodes it as two slots.
> 
> Add support for passing the number of slots in use.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Allow passing the number of slots in use
      commit: 6ab11462c68499933bd9b5d52a710f4e18a9e43e

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

