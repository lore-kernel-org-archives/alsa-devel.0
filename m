Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E3C52D7F
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:01:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FAF0279C;
	Tue, 13 Aug 2024 18:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FAF0279C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723564859;
	bh=l92DpSo2C7PT4PTRh0Gd47GHy1fmn3ge34So7cjSvLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SrRT10l/GdMD2Xdly0TJ7mlIlXB5P4hbIfXZkvgSy7fvPX0juaXh1F06JDZK/IH8u
	 Nv9YnfN5xk059oPt1KgCAXUaoOBbgeswgR8sKm/naOvOSh8muTncZ3py+N0R1Bv/iI
	 EDew5i9VyzP3YlgU7G1FRLfueA8liOeTJIYyytcs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4FDDF8061F; Tue, 13 Aug 2024 17:59:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94159F8063E;
	Tue, 13 Aug 2024 17:59:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5B5DF80423; Tue, 13 Aug 2024 17:59:07 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 22207F8016E
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2024 17:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22207F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Pi9lkKR2
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 036CACE1178;
	Tue, 13 Aug 2024 14:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A115C4AF09;
	Tue, 13 Aug 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560236;
	bh=l92DpSo2C7PT4PTRh0Gd47GHy1fmn3ge34So7cjSvLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pi9lkKR2+k/XOgNlIpO67yV8X20vQLRSJgesFuzF1eZBB6a8kht3H7et4PE1BVved
	 7jPcqWPqrGfM4dWqmswmu/BBINl8rwhRQul1gNxdflQh8qmoNgxzAXI58hV2NNlEKM
	 LJ8lsaZqKvhNvchHaK7jsD1pjqKKRsFSZcV0Eh2uHSvr/4wt9kZecgoKtW7vVEqXMP
	 QLrhB2Exy8LSZTvka1KV5OHPKcJNjCenFMJM6eOCuKhR+u0H6j3N7NVP9GLK0iZCNI
	 CxvLy+bKrJoyawp3xcPFCFEQl8oKDKKI9g2nzC6nfZJtW1n/lW7/5wLKEcvbYzJcP9
	 YdNT17KMqijxA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20240806102707.3825703-1-jbrunet@baylibre.com>
References: <20240806102707.3825703-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-Id: <172356023429.57695.4053614993109219592.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 15:43:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: XKQI7WYSFVPDDUDZFRSTSYHE3JV54FIP
X-Message-ID-Hash: XKQI7WYSFVPDDUDZFRSTSYHE3JV54FIP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XKQI7WYSFVPDDUDZFRSTSYHE3JV54FIP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 06 Aug 2024 12:27:03 +0200, Jerome Brunet wrote:
> With PREEMPT_RT enabled, spinlocks become preemptible.
> This is usually not a problem with spinlocks used in IRQ context since
> IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the upper half
> of a threaded irq handler won't be threaded and this causes scheduling
> problems if spinlocks are used in the upper half, like with regmap when
> '.fast_io' is set.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
      commit: 5003d0ce5c7da3a02c0aff771f516f99731e7390

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

