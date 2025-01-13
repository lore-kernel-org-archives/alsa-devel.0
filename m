Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CCEC02180
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2025 16:58:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21FE86024A;
	Mon, 13 Jan 2025 17:58:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21FE86024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1736787504;
	bh=6zHHYWKunh1M6enMUeVEE9Y9YBnnSAPsE4K1pjRUkcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pSEhA7t8ciLIjAr0B/2vYSkBIWvkKVhe/+RN1NFhELWgGrGeEilfoikxftOqJAEq1
	 sa1NOrN3V/1bSlFYXd55vrl0zcuev16aU1YDLrLY/0OQ9rhPgXNjIG7+5J/XU4uyl9
	 rnqb4Gowrb2JoQt79wpEzPKa6UmXWfoSG2aLDmnA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F142F805AF; Mon, 13 Jan 2025 17:58:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72B32F805BA;
	Mon, 13 Jan 2025 17:58:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D9A0F8024C; Mon, 13 Jan 2025 17:57:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 55E24F800AE
	for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2025 17:57:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55E24F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=d5HScDVV
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E8B955C3FF6;
	Mon, 13 Jan 2025 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B3AC4CED6;
	Mon, 13 Jan 2025 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736787428;
	bh=6zHHYWKunh1M6enMUeVEE9Y9YBnnSAPsE4K1pjRUkcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d5HScDVVKb+DwfnbCcV97/QF65GOYRX+jx4ie0+HUelITeYsvWlQ9cBkTCr24oE/a
	 iXauNEme1/v3qzVJDsUBM6DPgb35WmlHzAaXH2RXu3OybMl8r3oQ9gxgIcTpCVd7+3
	 8mSoMjL4yxD1Aa6QV85Al6v9YbOtTJOVwyJhDebb785CaDcVuhKxJnIIwlbQPj49NE
	 GzZMjFNxDJPkXxErwlt76ewBfR661vtAWXQMLR8DbdAKyGs0X5ys9Qq4dSXeSCQE27
	 eb64ETmhE8zLC5QZ+mwsYDlDSK5+Vct0ACPc+NkG2j/yb0c2/5jugtRMKBgBQ5uWfF
	 MP3cVr0H4NbLg==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 Maxim Kochetkov <fido_max@inbox.ru>
Cc: andy.shevchenko@gmail.com, u.kleine-koenig@pengutronix.de,
 tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241219042227.7075-1-fido_max@inbox.ru>
References: <20241219042227.7075-1-fido_max@inbox.ru>
Subject: Re: [PATCH v2 1/1] ASoC: codecs: nau8824: fix max volume for
 Speaker output
Message-Id: <173678742609.75237.6112979080454530319.b4-ty@kernel.org>
Date: Mon, 13 Jan 2025 16:57:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6
Message-ID-Hash: V6P4GNLJ7JF5G75BEJEYHMHEVFSXEBON
X-Message-ID-Hash: V6P4GNLJ7JF5G75BEJEYHMHEVFSXEBON
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V6P4GNLJ7JF5G75BEJEYHMHEVFSXEBON/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 19 Dec 2024 07:22:27 +0300, Maxim Kochetkov wrote:
> There is no audio output if Speaker volume is set above 25.
> According to datasheet Rev 2.5 maximum allowed value for the
> Speaker output is 0b11001 (25)
> 
> 0x6D CLASSD_GAIN_1/ 0x6E CLASSD_GAIN_2:
> 
> Left/Right Channel Class-D Driver Gain For DAC Left/Right
> Input
> (Step size is 1dB.)
> 00000 = Mute (DEFAULT)
> 00001 = 0dB
> 00002 = 1dB
> ...
> 11000 = 23dB
> 11001 = 24dB
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: nau8824: fix max volume for Speaker output
      commit: d5a4d7f10fcdcae952f7d5c603c61795c0abb7a7

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

