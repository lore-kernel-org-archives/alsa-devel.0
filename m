Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A161C64ED6
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Feb 2023 18:03:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E35D0852;
	Tue, 28 Feb 2023 19:02:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E35D0852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677607405;
	bh=wRw9hM9vMLvaScT9V1h83YT0B4lwagiDI/HXF2eLlR8=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lzVPg45VWkaya+GlqknhnhODt67tUdbfqy0YG6V8jpxFco0hBOGBQjOYWrByX+XnY
	 qL+0usVQ3g85ftkOkWCGRs3kB4WRvIu9cqwQbUp1TwevkqQHpttHlIcVeh2uGTT6ec
	 xYDUA0ASzKKRDifXulHvl2jPmVbLvkzqVV+0zBJw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66901F80533;
	Tue, 28 Feb 2023 19:01:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52064F80533; Tue, 28 Feb 2023 19:01:34 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BB86EF800BA
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2023 19:00:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB86EF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iJ3yJK+e
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 49D6FB80E9B;
	Tue, 28 Feb 2023 18:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC33C4339C;
	Tue, 28 Feb 2023 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677607240;
	bh=wRw9hM9vMLvaScT9V1h83YT0B4lwagiDI/HXF2eLlR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iJ3yJK+eGkrxmdWs9v3h/bbS8W/SdybNTU+w3Ne3odOJNpFHgswE0PaQI/6rKqC0D
	 IVrnTw5+jjoetVZnehVZ4yuqHlk7YkFH70Ed2Jdv27cPLBL7jkQc/ocBKi5lYfMisP
	 xRtc2q7xSNRb/cvyIuuQBKvyLk1+8d3JLb8/xkosmHO+rBHXg1wTWBkExrcBslrSSK
	 kPNwKHitgHylZUo4PBWUqaq7oU06rTS4aRNn4W9Qni9WluH30i71XaUvO774xdDmin
	 qyWr7ASzoz3GeKaZZ/tGn1AMt1OTYoOf6bvoMpCRiV6Pa0YCKu58g4S6MOouXrj2Tp
	 nW3zT4Dj2ytxg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sven Van Asbroeck <thesven73@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20230227085850.2503725-1-arnd@kernel.org>
References: <20230227085850.2503725-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: zl38060 add gpiolib dependency
Message-Id: <167760723817.68866.9637291073477909539.b4-ty@kernel.org>
Date: Tue, 28 Feb 2023 18:00:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Message-ID-Hash: CFBMRIFGP3UHNJHJCLJ6FLFAPPU4YZZS
X-Message-ID-Hash: CFBMRIFGP3UHNJHJCLJ6FLFAPPU4YZZS
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CFBMRIFGP3UHNJHJCLJ6FLFAPPU4YZZS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 27 Feb 2023 09:58:26 +0100, Arnd Bergmann wrote:
> Without gpiolib, this driver fails to link:
> 
> arm-linux-gnueabi-ld: sound/soc/codecs/zl38060.o: in function `chip_gpio_get':
> zl38060.c:(.text+0x30): undefined reference to `gpiochip_get_data'
> arm-linux-gnueabi-ld: sound/soc/codecs/zl38060.o: in function `zl38_spi_probe':
> zl38060.c:(.text+0xa18): undefined reference to `devm_gpiochip_add_data_with_key'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: zl38060 add gpiolib dependency
      commit: 0de2cc3707b6b6e2ad40bd24ce09a5c1f65d01e1

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

