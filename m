Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBBDC25B67
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 17:11:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C9D185D;
	Thu, 26 Oct 2023 19:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C9D185D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698340316;
	bh=pqvW/M9c/cJz4WisDsMscjILqHNcIrUv585K29I0jkg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vjcWCaVSgSYPazDLDigQr6AhPOw55MnrPIqUAwKDy63e+EiyWzUXWs4Ow4a5yup1F
	 xHfIkN5vo3exo5/HxhFNsTpN5Q7HZ+zQQyW9z42pTCVTTv+1ECLY0Y+5KjtZ7uxfwT
	 qrGNrrMK+OezTxW6ZHuH0MvJgQ6b0ACxofucZvIU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD525F80564; Thu, 26 Oct 2023 19:10:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DDFFBF8019B;
	Thu, 26 Oct 2023 19:10:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7D23F8020D; Thu, 26 Oct 2023 19:10:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 67481F80152
	for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2023 19:10:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67481F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=d/xlOY2A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C73356356A;
	Thu, 26 Oct 2023 17:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B130C433C7;
	Thu, 26 Oct 2023 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698340207;
	bh=pqvW/M9c/cJz4WisDsMscjILqHNcIrUv585K29I0jkg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=d/xlOY2AhSft2kmrsSnKiDZ/wg6TIZNY1bZnh9BJSrJE1AUj7RcQVO8qPkprWkB1l
	 v6Va+mYta1jKeAKkscFHTrBBZ+Fqs0QtU+KO7N1NLU12YAE1fCpAH9kqN/CNZZ96Sn
	 rT0twpAoojmMpTonQVJJvF3+vVYFLngZ1oJhbEHFvuUfcnwx+btLYfQK32v+UlLRlL
	 FVVZbd6PYCtKqGE4YyrDEq6MmmrA1slmZVCoGSFK+/OtXSqCfwqur1yEF+ZfzSJEzU
	 Al4Sk5Uh++Bu+eFs9rS9nTaegZfkFkxY1ir8x+VdEXJMwKbIRa+ffdTAI8ZitKARGM
	 Kgsn7OKjJTanA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, perex@perex.cz,
 tiwai@suse.com, herve.codina@bootlin.com, shumingf@realtek.com,
 rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
 ryans.lee@analog.com, linus.walleij@linaro.org,
 ckeepax@opensource.cirrus.com, ajye_huang@compal.corp-partner.google.com,
 fido_max@inbox.ru, liweilei@awinic.com, yijiangtao@awinic.com,
 trix@redhat.com, colin.i.king@gmail.com, dan.carpenter@linaro.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
In-Reply-To: <20231025112625.959587-1-wangweidong.a@awinic.com>
References: <20231025112625.959587-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V3 0/3] ASoC: codecs: Add aw88399 amplifier driver
Message-Id: <169834020032.149939.13328235446947300369.b4-ty@kernel.org>
Date: Thu, 26 Oct 2023 18:10:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: S2DMFSNFXR4ZCBGQEBEAFZILDHEZPYLI
X-Message-ID-Hash: S2DMFSNFXR4ZCBGQEBEAFZILDHEZPYLI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2DMFSNFXR4ZCBGQEBEAFZILDHEZPYLI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 25 Oct 2023 19:26:22 +0800, wangweidong.a@awinic.com wrote:
> Add the awinic,aw88399 property to the awinic,aw88395.yaml file.
> 
> Add i2c and amplifier registration for
> aw88399 and their associated operation functions.
> 
> v2 -> v3: Generate patch based against for-6.7 of sound tree
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Add schema for "awinic,aw88399"
      commit: debd9fa7bf17251c44a01ac1536d97566df45ca6
[2/3] ASoC: codecs: Add code for bin parsing compatible with aw88399
      commit: 725f3b967a507c515c5b14b4103840d22c217ef7
[3/3] ASoC: codecs: Add aw88399 amplifier driver
      commit: 926f192f005fe957ea1bfe4635af10219ba363a2

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

