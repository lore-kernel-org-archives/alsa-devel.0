Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6A4F364CD
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:36:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A329A60203;
	Fri, 10 Apr 2026 00:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A329A60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775774177;
	bh=hJOXN0A1g87o4nQ0XYTlCdOiW1iqCblg5wRUvz2+2Yg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DHQcKFaVrPEaWgApHw4gGld1lVEeRmuulhjLMNUv1+7zlrQ2jelqFWLQz0d0OeYvL
	 2WTg5mNsy7vFFhy4xxLq+2KyzYMAB8b05B055zt7THGlDhejawj1Aish6vp4yhTl3+
	 CVjfTYsY72r5gAJBrAz5CDLtDOspDSUreHuDtG/A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E75DF805EF; Fri, 10 Apr 2026 00:35:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CBA0F805EF;
	Fri, 10 Apr 2026 00:35:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA5C0F8052D; Fri, 10 Apr 2026 00:35:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1B3BF8021D
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2026 00:35:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1B3BF8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LyqyU/ht
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 38041600CB;
	Thu,  9 Apr 2026 22:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF103C4CEF7;
	Thu,  9 Apr 2026 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775774126;
	bh=hJOXN0A1g87o4nQ0XYTlCdOiW1iqCblg5wRUvz2+2Yg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LyqyU/ht4MilwGCBXfhAGdRW7BQ1nrqKJpnPKD19ngxfvTcwDFwSKLjxhmh1zsOSb
	 s3ybOUmE1WTdWpYKDjtKQ/t9hzo+ginTYZw0uB+YAsLmVxlACSXw3G7sCDbNx8Z38y
	 rwDrJobS6UwC6vrguI3kqcfb7o/bRe3vT7m9dKICZ3FNH5rroF72n8I00Dy9+Zqij/
	 yZZlDWkL21vIY45wXIA/cChqE/vcSThwC3efG32Eh6onQrBgKBaQHUzQy6vs/0OPpi
	 z3E8TiTINACbLX4T2XK+kPD/+UFqRAQZCAtu4VLsKC78PVELONwvGnclQFjUzaPeXL
	 2CLAQgOXBHrWw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20260409060102.4177554-1-jack.yu@realtek.com>
References: <20260409060102.4177554-1-jack.yu@realtek.com>
Subject: Re: (subset) [PATCH v4 1/2] ASoC: rt1320-sdw: kcontrol for
 brown-out feature update
Message-Id: <177576371337.997653.13948388160791956037.b4-ty@b4>
Date: Thu, 09 Apr 2026 20:41:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hJOXN0A1g87o4nQ0XYTlCdOiW1iqCblg5wRUvz2+2Yg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2CmqKM4By88BMKZC1z4Y6CbF1uUo+Tt744mvi
 2YTYDny5k6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadgpqgAKCRAk1otyXVSH
 0AklB/9oO/bTFthB+5BqKlEGznerx2qA8C6HLSvll7dgHV2X906M2xbWM2w704OHHPHbl5s3Uhm
 9zk00GuNZRPAoaaJyfuSlWNgsWX0/0yhVTSQRxA2hXU846Y+Y4EpgJbdIeFywjgEnT/yVa3YZeN
 +klHqBV3pxGsakhfQTGl5JJPRkNBvxW2ol0HWmcXkM6H4jlH4t97rKH7eTQCN96QU0X4KQ+9YaY
 Rn3J0pQxZu60SF2GN2vCaC6HETkYCUZgG+ry6knOSqSOfz+uD+iFX1azJSP2FZV5KeGAbMc8SxQ
 h8/pcuG6s+qxC7HTnm+30a4SE4z+YUQ3EvoNUVPvEeIZgxN8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: K6OHT4H32KLSCSXTM25Y4PIGKCAEKRGV
X-Message-ID-Hash: K6OHT4H32KLSCSXTM25Y4PIGKCAEKRGV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K6OHT4H32KLSCSXTM25Y4PIGKCAEKRGV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 09 Apr 2026 14:01:01 +0800, jack.yu@realtek.com wrote:
> ASoC: rt1320-sdw: kcontrol for brown-out feature update

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature update
      https://git.kernel.org/broonie/sound/c/fbb1f8ba4e2d

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

