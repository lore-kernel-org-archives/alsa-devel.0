Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47426CD98C7
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:19:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A23960201;
	Thu, 11 Jun 2026 20:19:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A23960201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781201951;
	bh=FgzklUGXjUNu2L4Fg+icg11qy+SobUnXK+pcyXpSyvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NKMUJj+RpNMWUCRE5DBRlWznB+jv2TZF/iiwlBNl5U6ChKZzO8y/aRuX0Qk3cwGm5
	 oizn/oztth0FjUmoTtwFNDzjnb/RSRGnE9hSPrF5W/G9X8i2vdQQA5dh0gZpOp0bIH
	 lDiaWOJZyREYZTAUbS0MsbcF+93Z0tqu2TWvyT7U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE0FFF805F5; Thu, 11 Jun 2026 20:18:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35146F805FD;
	Thu, 11 Jun 2026 20:18:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55BC0F805B1; Thu, 11 Jun 2026 20:18:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781201911;
	b=OkDcLGsAHeltiScNHdHFxN3b1rNlZJdk1IqsIvFV74fpROI26l9bFJt81mpaEOnjgGJJ
	 Zcu9gVjXQeDZsSFKyOTmUUScxeTTvUh1TNSx7jareS0pXr5g9GtdTtz6cAw44ivyNa3u4
	 1GkTS9tk8u//qZw+AF2pkekDCFX2F95l5rJu0vphFR1jOwcVyr+9pXcG7SbONHafAFdoH
	 5X7SUvhG8c2rQPQwlyYiSc9Ueur11Kd3z+kttW4eM18P5R7aZKICqs7LTC9Gus661kAC2
	 cj5AEqw/TnlLtujP6U7Rt56p3DmQiYb6Q8GoeU1UMnPGwETo48Az5ymPdqfPDCplQ/Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781201911;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=FgzklUGXjUNu2L4Fg+icg11qy+SobUnXK+pcyXpSyvM=;
	b=rXCYCseSSMzmeumC5CgTYh+33yISv6MFoYEEl5CN7OpQSwUWj3AoNSzaa+DbDBtszxtY
	 MbucH+EL+EDs+O3jSw00h/os3nqZKdJXSAWhAeTKMwQkOMjrhN5apuF3lThNSfKfFg1xz
	 F2dATpyU7vr7dFP0ftk5pHkQ2kHBoDzKQE5dYT9NUpcq1S6bYKZ8WMqjlZT9v1PZiOxWy
	 RAkjcvS8T5ojUmDDMdUV5Z1uRbMmCTb7RGMq+347Dro5zyeMCtqY3SYXEwqmC/hQBYZiU
	 8sIsQ7otHkram5vciRWkPHXyiH4vYWUuks443MbGJGO2UpW+L2xp0gnIe8VoH2CD8QQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f4FJ83ED;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9490EF801F5
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2026 20:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9490EF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f4FJ83ED
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9799B40736;
	Thu, 11 Jun 2026 18:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF421F00A3A;
	Thu, 11 Jun 2026 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201907;
	bh=QDK1kH8UHAvTtlHTiD81bPSYKlYhG1hyuzJocm9z09U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f4FJ83ED8lFAxExuoVJVWu6KCFmb19RdXiUKKS09pj8hL/CkTJZ2SvOAT6+6nHni3
	 uF8Cg4i6yT0fJD5FXtVYYsdRDeOIhgCIbe2Fr0x+Hq6gCBdv5NWp4v40hyYiG1rPOn
	 Jj78Kok8KFSPLMjxy7byCwOfDdRhMWOVHoCQz4o7LsVn/dErcu3gq+LmBokmVpuUVg
	 7/bWPOoUH7O/NVArkDwNQIRb7vXDSesHW/yQ32FebtWy9WtUnRH6fyUNXTmGdzL+fe
	 sUHVmoQANGqzRZxOH+2U6kf1RY+HT8njuAsXvfSkdDxFwt2qD3ebe9PspQblgqTODD
	 VL+Z9A2e18S0A==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com
In-Reply-To: <20260611125359.19839-1-baojun.xu@ti.com>
References: <20260611125359.19839-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: sdw_utils: Add missed component_name strings
 for TI amps
Message-Id: <178118602519.447103.397643315723566551.b4-ty@b4>
Date: Thu, 11 Jun 2026 14:53:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FgzklUGXjUNu2L4Fg+icg11qy+SobUnXK+pcyXpSyvM=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhiyt36+eTn/+3KPCU0XxrqpJWFKgWaaGC29B/L8TcayCy
 v4/k5k7GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJ/Odj/x8aYtwpnWLTf2Q/
 8/wZxdsfqZ8SfZ3aayO6woblg3rt0TP8JT/4ssuZZwUtOZY2IfBPdOZl+y9cO34tyigxLSyrOln
 cuvihzsP3vssrP/QduuITEf2nMtSrRPKh94uGktVs3ZOZEi45mjKdc7PMXiljdXyqkmNmr6iNdO
 NcZbG/3xk1PT9c+mrnkLs52dli8qLIqW9OWPh3xi3XD3Q8YvdOatWGhQldJ0v2a8+qTC+L3rNzn
 0Hk9u6EvS+8I/3X+XWaXZ2xdm5bFPOu0Oi/Pa02LdP7VjLw1d0vTRP7fcdozUP56TMLfxaou1hn
 s17h+eaYtJaZvTEyO/TdqU1n+c38XipZ35r88YTzdM+dAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: JX26DBLSAV74BDIDLZB5KVK3MKA3Q4AT
X-Message-ID-Hash: JX26DBLSAV74BDIDLZB5KVK3MKA3Q4AT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JX26DBLSAV74BDIDLZB5KVK3MKA3Q4AT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 11 Jun 2026 20:53:59 +0800, Baojun Xu wrote:
> ASoC: sdw_utils: Add missed component_name strings for TI amps

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: sdw_utils: Add missed component_name strings for TI amps
      https://git.kernel.org/broonie/sound/c/79bec4638194

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

