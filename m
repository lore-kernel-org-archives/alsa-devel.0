Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760D2C25B75
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:50:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFFF6DF9;
	Thu,  6 Jun 2024 16:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFFF6DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717685428;
	bh=oIsOBi3YR+xt6MMQIParPVbOIkxTmT9b93g53VHm6E8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VqK6qYOGB88Bx+5mL3v37Yn3curpMAVSZ+MP6HlwqEuLdL415NxcA28Mi5v2Tlue5
	 /qFGJmzuVhTTqVU4iLPisLTeaaoutS4MmIbzVJXWXi4vUX7qIpiFgJ53+hM46NH4Ij
	 Fo0fmYByY+7gldJjY5IXxgigJ8w1uXBqxdYxIKuQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A13F8F805AB; Thu,  6 Jun 2024 16:49:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9FB2F805AE;
	Thu,  6 Jun 2024 16:49:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABC8CF804E5; Thu,  6 Jun 2024 16:49:38 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 32BEDF80171
	for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2024 16:49:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32BEDF80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JszW8j6N
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C9065CE1BA3;
	Thu,  6 Jun 2024 14:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71569C2BD10;
	Thu,  6 Jun 2024 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685345;
	bh=oIsOBi3YR+xt6MMQIParPVbOIkxTmT9b93g53VHm6E8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JszW8j6N+zTB16PXUB8fTcXyXCnTYis0sjPAsRu2jibrMA4xFXHdWj+hkW+EV6NW+
	 +r799vIpjVSgNJ47hO3z7Frnf13eety5sF/rNJZF5KX4FbSnhfiLQKUPpSn1Ircl5w
	 1gIgDPT8A7nsVszi09+EraAK2ElIujyVrLwPXI760R1iCe1aNjHAz+1zhRE1jKI7+Y
	 4Fbda/oGDCej5GlSJOs0pEylDlnisoP7pf0ryTPI6GsFDwsMW8muXaNyJUkpeGy2BO
	 bQ6XIxkTC9olQ9y9dKYANo6AI1uTZ/ynvMAgC7EUw4PH0JfR+qqP/fosZTV363w/v8
	 OpDRbMCMNcUuQ==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 kuninori.morimoto.gx@renesas.com,
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240604101030.237792-1-andrei.simion@microchip.com>
References: <20240604101030.237792-1-andrei.simion@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform
 to fix card init
Message-Id: <171768534216.1578869.5370523933497005788.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 15:49:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: TFKQ2YLRTFXCLL6UO6SFUQ6DTOLD72DD
X-Message-ID-Hash: TFKQ2YLRTFXCLL6UO6SFUQ6DTOLD72DD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TFKQ2YLRTFXCLL6UO6SFUQ6DTOLD72DD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 04 Jun 2024 13:10:30 +0300, Andrei Simion wrote:
> The removed dai_link->platform component cause a fail which
> is exposed at runtime. (ex: when a sound tool is used)
> This patch re-adds the dai_link->platform component to have
> a full card registered.
> 
> Before this patch:
> :~$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: CLASSD [CLASSD], device 0: CLASSD PCM snd-soc-dummy-dai-0 []
>     Subdevices: 1/1
>     Subdevice #0: subdevice #0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init
      commit: 2ed22161b19b11239aa742804549f63edd7c91e3

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

