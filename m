Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC19CC4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Nov 2023 13:05:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6578828;
	Mon,  6 Nov 2023 14:04:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6578828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699275928;
	bh=c2QlOKGHQKRqJ8EHXE6QadmeF5FbUeU59kjhrGvz5yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WTbeVdgHkF3R37NSaCqvQHOFle8+iPawmsNxG9A6pdqJ24FmS5IrTlllYtNhQYVeR
	 QxqqV5a0RtbQ6z7Rd+RyU6j57IwYTCRR8dtAY4aNb70pz0t2XPy3v32wnR06QMeCqc
	 8SMjFpIrcJ/84KAaDmAApoQ7vpB4Jnt8BwZtZ0sE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9FE00F80579; Mon,  6 Nov 2023 14:03:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23433F8055A;
	Mon,  6 Nov 2023 14:03:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C1BCF801F5; Mon,  6 Nov 2023 14:03:43 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7288F80100
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2023 14:03:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7288F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=V2L8VwqF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 90F01B810A8;
	Mon,  6 Nov 2023 13:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA393C433C9;
	Mon,  6 Nov 2023 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699275813;
	bh=c2QlOKGHQKRqJ8EHXE6QadmeF5FbUeU59kjhrGvz5yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V2L8VwqFv/HrOK4xFKDjH29GWomWmFlUcCZcQMYqb1rlKaBtBZ+D1M//7VlYGOqG+
	 rqNp3CJvqGVoIzCopKDshQvznXDQKbtmTk1EEJ7rRXF8wWbY/KUcOu43OVhHPyMZlI
	 mke7Qyza5Ggc830Zcz/tUOQAE0Hu+OnMvfEwzU7l2noHWTU7DpAX1n7YhVoEZltqyw
	 GhnUnb44SP/MvFtediHFQIE2rRWdbprGGIIEDzv1EaPpSDKfb78O34hgY3v9Zp65y1
	 VqqeHVNFZQfdnqrSPCkpxbhysCYtlKr+RzsH2ImpPw9jrlF59oKfGFO0RNI6vmu/XS
	 LHFvp60OyLaxg==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231106103712.703962-1-jbrunet@baylibre.com>
References: <20231106103712.703962-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: dapm: fix clock get name
Message-Id: <169927581117.3037292.10632201210620631466.b4-ty@kernel.org>
Date: Mon, 06 Nov 2023 13:03:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: MH5JVVA5QDNHYRSOWBBARMLPNSSDFK6T
X-Message-ID-Hash: MH5JVVA5QDNHYRSOWBBARMLPNSSDFK6T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MH5JVVA5QDNHYRSOWBBARMLPNSSDFK6T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Nov 2023 11:37:09 +0100, Jerome Brunet wrote:
> The name currently used to get the clock includes the dapm prefix.
> It should use the name as provided to the widget, without the prefix.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm: fix clock get name
      commit: 4bdcbc31ad2112385ad525b28972c45015e6ad70

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

