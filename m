Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F0CEE4993
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 16:28:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F8DE9F6;
	Wed, 23 Aug 2023 18:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F8DE9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692808117;
	bh=FnuarZnFAyUqPz7jr69MFRBMZfNtqK9XZFNFPqeSp+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FiNJ/EM4tVATdf/uwjdHM3/keD585Il0K3SagDGd/TcmfCvMIHO01ldLo3cgtZHxi
	 iMqh7qT1tgISxHb/3Yzihf9SZxCqgGpCPKu5Wg3U38VoEP5uF1YGoFlza4fY6bFTyR
	 jU07kQCrQZJtRQfo3cxtljmdJAQkzl+Ty7T/SCII=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A157F8057B; Wed, 23 Aug 2023 18:26:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D72DF8057C;
	Wed, 23 Aug 2023 18:26:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A14FF80553; Wed, 23 Aug 2023 18:26:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5202F800F5
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 18:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5202F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aK3vrOi4
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 046836463C;
	Wed, 23 Aug 2023 16:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35593C433C8;
	Wed, 23 Aug 2023 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692807978;
	bh=FnuarZnFAyUqPz7jr69MFRBMZfNtqK9XZFNFPqeSp+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aK3vrOi4K8xD9Psm4va2dwSihu6CwTQJsD5ATzCRXvDmv5wpzj3RBmUxviHiW5UEN
	 hG5pppSmtc7Tq6AT3ch0uVTakTZ5VKsDHakn/YR8rm627/TQ8QfL/XQ2Ko7VgKh/R3
	 4j/USHgKHmbCp3v3Do1FBrHDs45SSvSyUjCtp4B/rXbOD4oclvScxe6YKVP2L8JpHy
	 nRNydlkEWigrijcMe3KHurpOjS05N1c5Ttp0o4HOsH7XZyBBPvjcwy8JlaUyTPOVfs
	 6Xy0Kka+Ud6U8MwmMPb6kjpVAC8qf1lb5nK26GsnZVyOye+tetQYIXCpthr0plXo6y
	 uSmkMrsRmZDZg==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230822-delete-l3-v2-1-b3ffc07348af@linaro.org>
References: <20230822-delete-l3-v2-1-b3ffc07348af@linaro.org>
Subject: Re: [PATCH v2] ASoC: Delete UDA134x/L3 audio codec
Message-Id: <169280797694.53791.13283678720134616535.b4-ty@kernel.org>
Date: Wed, 23 Aug 2023 17:26:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: SNVWYICR7G2USYEULWEMTXNLOMVULT5O
X-Message-ID-Hash: SNVWYICR7G2USYEULWEMTXNLOMVULT5O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SNVWYICR7G2USYEULWEMTXNLOMVULT5O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 22 Aug 2023 22:55:44 +0200, Linus Walleij wrote:
> This codec was used by the deleted S3C board
> sound/soc/samsung/s3c24xx_uda134x.c.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Delete UDA134x/L3 audio codec
      commit: 6dd11b945951315ba4986844f20e83a0c27c1d38

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

