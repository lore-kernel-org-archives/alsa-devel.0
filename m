Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B3DC4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Nov 2023 17:36:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1DB7844;
	Wed,  8 Nov 2023 18:35:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1DB7844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699464959;
	bh=WVjrzXqJLudtxWgaeLcLM1LVeTcE9G9//8/KcgJOvBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uBVTKzK99U1aC42GUzMHhcqJx//VLAZ43Wk2dq0lWsM+Wowhk4FhJbPp022e/nBzJ
	 BKd7dEEHvqz1dLqwdK+fowDHdZEX/JBKBORsRnYu8Jgi7utnozS4KL9HkjhR6aEXvd
	 STx0wh8D7Mw7Xb+jFfPU21til5XMf77NVltvTM48=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C540DF804DA; Wed,  8 Nov 2023 18:34:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF5B2F8016D;
	Wed,  8 Nov 2023 18:34:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D5F3F8016D; Wed,  8 Nov 2023 18:34:34 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 39313F80152
	for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2023 18:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39313F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=scWV/cKQ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0FE78B81B98;
	Wed,  8 Nov 2023 17:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C17AC433C7;
	Wed,  8 Nov 2023 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699464853;
	bh=WVjrzXqJLudtxWgaeLcLM1LVeTcE9G9//8/KcgJOvBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=scWV/cKQKKO2jeioGQY+V03CFFm4omKygU2ME89SjHmhuw2SKQLRyzwdCRmv4+xRN
	 Jdc3lIKJqTgBBsSLhL5wlyDTKTAebrYT4jzmirONpnhixkACyDWUQgf+W0BO/PBLa7
	 gZz+LO1ZZ16CM7ItQEzNupPadeIGzDh+e2MEBqBoZ1NQ14+s8xh20E98B3KJ0423NW
	 WOMJv4Use9ru3NbNh0bOVPAxzIKsT4T7HD9hggPud/NhgRsRFner2FaQOvi0j+Irp+
	 t34rbe6lVsozw0JZXKRXbCSfHjzsblzfw0qc9KozMNcDmB0SiAJc+JPOKJSicbkIf5
	 p0HTC/eSXENqg==
From: Mark Brown <broonie@kernel.org>
To: David Lin <CTLIN0@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
 ctlin0.linux@gmail.com
In-Reply-To: <20231108061658.1265065-1-CTLIN0@nuvoton.com>
References: <20231108061658.1265065-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8540: Add self recovery to improve capture
 quility
Message-Id: <169946485065.3168969.6961240941016323720.b4-ty@kernel.org>
Date: Wed, 08 Nov 2023 17:34:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: FI55RVPBOVCWMKDJOBVEOYIEBA435L4O
X-Message-ID-Hash: FI55RVPBOVCWMKDJOBVEOYIEBA435L4O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FI55RVPBOVCWMKDJOBVEOYIEBA435L4O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Nov 2023 14:16:59 +0800, David Lin wrote:
> Reading the peak data to detect abnormal data in the ADC channel.
> If abnormal data occurs, the driver takes recovery actions to
> refresh the ADC channel.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8540: Add self recovery to improve capture quility
      commit: a60a609b7f548050d1e84c7aa1c0a57d5d7e22d5

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

