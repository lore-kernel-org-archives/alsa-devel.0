Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870A6C43602
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:25:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4648A60224;
	Wed,  8 Jul 2026 12:24:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4648A60224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783506295;
	bh=d62TZ5pLxwSDG3+Jbc+zLSYfCLCpYi3Uhpl/0FXiCW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=h7W9MgF8aNagI64VEW5BkC/HOQ7/qpFd33AbxYANMENHk5D7MuG5lhtXy7LKufkr8
	 8dtRpb2GtVZXAFmD3+3+UtgIwF6cOLhKhxyxguUFXCBPf7LmOHtacatDgUFj03arSn
	 c+16IdnGV4rjEl2nkQdPXPESx9WYjbTweA5OBtC0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A984AF805F9; Wed,  8 Jul 2026 12:24:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6913AF805EE;
	Wed,  8 Jul 2026 12:24:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6165FF8055B; Wed,  8 Jul 2026 12:24:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783506254;
	b=dy/2Cd4oT7kTzg1ylENKDCHLay+/LJgbxpEPQYYDXPtYWP6b5FGCu2RsiqUaHB1+rYdD
	 o5wRIqK/+eade1dWOU6yivsYVEPCp4RY4jbUmza0eCqJ7z3YKc2V8pL8+CwVP30jqPArW
	 sc1fLsg8Sgs3J3B9xE18/yxlGsfAQJePoeZbtKTX24g1lDa0TEiS6PT6egq2wHR80sREa
	 o823N7Iw6kixqDX3NIdsW4mivEw25izkgI17lCVPWpIWJPmrcYgX3qiqV9EVxrKvBzLMg
	 rZb67cEhYSFNRPMmcS92jFUW305oEMWgMPGxkPwESJn0+dgESfotAZld1UWzXRtlD9A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783506254;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=d62TZ5pLxwSDG3+Jbc+zLSYfCLCpYi3Uhpl/0FXiCW0=;
	b=W9pv+oUbmataageEEsid1EIxo0Zw6RksUJSxmuiulKjL0C6o4YgUragfwSnhKnW/o1O2
	 rlhwjheOjxIU1BxWIdMStc/1BgsAoqr5XnkD9Vrgj+TAgipQ45hpVmaV+MT9YsX5U1JAx
	 GqO7pWVoT0frhfDp2L0NnR7CBZ3GjOMKh1q4Jl9YA+LHO1dZqlbeNj1MqRfqisniikWY0
	 mjEPvGwu47lq6zT7Wm5oOXaNWMc8YXC0FBxmfeJlKXI6ukeqYUefZe3Q4jriv+Su4xTtP
	 D4/G0XWQF/TSFBAdh0CTvUQl3SDmovThWTPVAHDTrbhMJmM0USNRca+SZrAuGu2kZBw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=h9VuvtWV;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 77E56F800C1
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 12:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77E56F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=h9VuvtWV
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B2386001D;
	Wed,  8 Jul 2026 10:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1EE1F000E9;
	Wed,  8 Jul 2026 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506250;
	bh=5UIDUGZjZpGYdAWIaQyNtkAD0KXTkokKI+9eQZvBWw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=h9VuvtWVCf5LakpWWsYXYa1n7Vkldx939k06HESNrmkX8WbrTl23Z3GQIywhzGNU0
	 F6gzQgGh+1QOK8zc2m1VghhvfelaGLqO6iaqmaXkKsWhFWDInhUPw4yMc/sC7U7wVJ
	 P/lAyiy4MN27lRJaPd/SIzNXWwbNGuJPr7f9uICzdnREjKEwkAb3m0OL98EwXrt/io
	 VLt7ySj7ZPAdjjnNrbLYmIdVxt+LgLMlGyGGKmoDywvfSQWRCHbfn25VUp4J4ZKfLZ
	 sH46v0+f0gQwHRxZ8cOsZ7BycbFW1VyRrfHbBUpSMeqsTjg/sm9P6/BPDIFK7VWslJ
	 +3VE4Ygr+PXCQ==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
 Syed.SabaKareem@amd.com
In-Reply-To: <20260702104429.1157-1-baojun.xu@ti.com>
References: <20260702104429.1157-1-baojun.xu@ti.com>
Subject: Re: [PATCH v3] ASoC: amd: acp: amd-acp70-acpi-match: Add tas2783
 support
Message-Id: <178346193054.59892.11215584955508242339.b4-ty@b4>
Date: Tue, 07 Jul 2026 23:05:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d62TZ5pLxwSDG3+Jbc+zLSYfCLCpYi3Uhpl/0FXiCW0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqTiVH6/EKYycDj4Ky0pBnaMIRIBZ5bdQiBvjzc
 39hr/m4vMqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCak4lRwAKCRAk1otyXVSH
 0OFcB/4w3uHlGHjC4yRr2KF5OrKhQQ6JjOoZGo2TltPzzp1SYk1OU1HNeTIjcJwqTH4Z7H4ej13
 cYmMOFizMCb0+xQLKMXDG1ru9af9J+fytWiMCyPehJjr7ENPjhpv66TFW5Vhq7O2EdORWqZDHPe
 Br4O7R8M6Qe9vNkcrbHKfXrg8aUz/7alUWLFtN2zv7LBM8r7jmRs5S5+AOF1WeJL0JMPdK4OAFm
 AqS1IKqWrwY1BlRAKI3u/RcaK3NHoiIbHyBFIGGpGsOQffTL08YhxdWEfe8e94QB+BeZ+TXtRLB
 0Z8e2i2UAHI08XjCicCROfug9oBAXJMNS4JnkTdOTylWTj/S
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: BSNF2KSKN63374M7WAGA3WDLB3TXBTPG
X-Message-ID-Hash: BSNF2KSKN63374M7WAGA3WDLB3TXBTPG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BSNF2KSKN63374M7WAGA3WDLB3TXBTPG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 02 Jul 2026 18:44:29 +0800, Baojun Xu wrote:
> ASoC: amd: acp: amd-acp70-acpi-match: Add tas2783 support

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: amd: acp: amd-acp70-acpi-match: Add tas2783 support
      https://git.kernel.org/broonie/sound/c/dedf4ccbcbd2

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

