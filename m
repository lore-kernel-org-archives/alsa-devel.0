Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA02EC55164
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:51:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46D9360201;
	Thu, 30 Jul 2026 17:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46D9360201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785426667;
	bh=83xITAXQ91kREEsbx1ZWhKwXTEchfvmdou2PK3e9Jqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i3inO2LpPsgqQD1fE5v75z9CTbrKh8eS0nyHR0kx7v/CmdW7N5J61nR1cB+PwYScO
	 EcYGhFZn+bsDCRQZufMQw4yb03Fh2rFkP0NvKq7C83HWN4yunyXR62tdUPic6YIy0v
	 iqsmF4TW44Ax+i8Yv6KxB/uYM+AGvXD2x9PsaMHo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B503F805FC; Thu, 30 Jul 2026 17:50:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C998F805FE;
	Thu, 30 Jul 2026 17:50:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B608F80496; Thu, 30 Jul 2026 17:50:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785426627;
	b=NhPs9zJs0BLUXBaxh8/b4bcxa72HvcGmwk07bumTsYQa7hv7depIod6QMqSl69JMn5ww
	 dpuq8axlyBjZjXWGZk0GFc483wlMTx3mb2sEW3YRgzzjjrb2ohrkeeiGCNmQXT6t8peZ/
	 8/HorjYI0FBfEmBtnDI0FZ1PHlbVmuyrjFuPkkvcBefZg1kbmJOmwkcqoTkY5ET2sPmph
	 nXhv81ltNu/EbBQFuIQpAogYYaqHWszmK2Lh1RFHBRJnbeXQDQEiphb23eWKrZnAEJ1Nf
	 JWaRxNIoLyAg7DsGPd+uwo4dBaqrl60ZfVd98xSTQhVCad/jdg2cvq4NhenJp/LJ7SQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785426627;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=83xITAXQ91kREEsbx1ZWhKwXTEchfvmdou2PK3e9Jqs=;
	b=jQc+moH5aSED59xfg6uVGnDGqL8mTSgakxzjUbcwGfcac/ZwCIovwwwKq1j/PeqGxfSF
	 UYk9eC1JhV7jHblXd8+tHBBG429aa+OJbj7Oze9pR1ynkPguuBnMI9fhI/fRl++XYceYz
	 amh0fCXoI7ksP4jrViWKdoCLWNWtelGWYySJ+zSiFVCfRu7RXSsjRBKPCHDmvzkxrpUqm
	 3/TjHH7mhUMZlqD1kf15E4AndeujwiL0CPtzaaeCSd5FbBhXfF2X/kdpOjqzPNti81JUs
	 hLsxMDbZjKOU1WAwJtRw4R70h7cbhyuO78Qe+A51GhBgg7NZFt/KVzxZC/IRz52fefA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TFYSFuMk;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81058F800F3
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 17:50:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81058F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TFYSFuMk
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 195C844009;
	Thu, 30 Jul 2026 15:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC31F00A3A;
	Thu, 30 Jul 2026 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426623;
	bh=qjtjnpzQ+qXTAK96z6qUK8wKFR3p8dQ7z7C1iHFqqs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TFYSFuMkI60iJXFXbWWNhayfbBc08pYuq7NNUvEuD8aY6ajK/Fmcqp8jF+DjhwqKF
	 dE/X9pstJNae9t0CEwgmtEKvFLahr/C0DFCVuepaUq64AtukUN+iy1k5P22gQzLDYh
	 yRSW9fBxOEGhW6T1nAqsg3bSb7IRSpZh9tyw043Q7kbCcu8WsXbzJKJdht0kQUXxVV
	 +KvC6DInMT3HG8abja+fQjZxlMpsiU7h2fWBcaE+QKb9YijF+jiYt/gbeH/A9Rsf17
	 wUOhVRkVc9+q0DX9rb3FiUtBq6fCHtWlf7o/ngyjsmPb7o3uz1FRajBgYTOQEhWGLH
	 EmIwoKjSTQ/zg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com,
 Trevor.Wu@mediatek.com
In-Reply-To: <20260716061536.1563252-1-jack.yu@realtek.com>
References: <20260716061536.1563252-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1320-sdw: Add settings to support more base
 clock frequency
Message-Id: <178541458926.81171.5032262419676959271.b4-ty@b4>
Date: Thu, 30 Jul 2026 13:29:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
Message-ID-Hash: ZSGCBFNRI73ZPJQGPFPJAF5CIBXMDWWO
X-Message-ID-Hash: ZSGCBFNRI73ZPJQGPFPJAF5CIBXMDWWO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZSGCBFNRI73ZPJQGPFPJAF5CIBXMDWWO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 16 Jul 2026 14:15:36 +0800, jack.yu@realtek.com wrote:
> ASoC: rt1320-sdw: Add settings to support more base clock frequency

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: rt1320-sdw: Add settings to support more base clock frequency
      https://git.kernel.org/broonie/sound/c/ef9c8eb30704

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

