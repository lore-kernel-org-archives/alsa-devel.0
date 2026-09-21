Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBAAC982F1
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:10:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9930601E4;
	Tue, 22 Sep 2026 10:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9930601E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790064621;
	bh=PE3GG0Zq5GHW1YBmDAj2j/TtiioAoG1QPWaJakB70KI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YaOyrNmOVLq2NlvaJn5wxMsv/jHKnZ2VNnzbsdf4vWQBAwtrxvRMD69ewflk4m1ih
	 1qpnLT447TF3pee5/araWBQ7rFVVcwG/QcCS30Vr66ghKB8vhFPztCqxCO8xxv41wA
	 EnfBdFHH3feW8Fx/6aDoOzupe0qLH8rpU0wIan+8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8413F805FF; Tue, 22 Sep 2026 10:09:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EB00F80602;
	Tue, 22 Sep 2026 10:09:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB68EF8051F; Tue, 22 Sep 2026 10:09:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790064576;
	b=WH12xHGElpv0FV2j3qmLL250pP/3jXlfcvHWfr9pX5ZEji5dgrwdNnLAWd0+L3ZgvTn7
	 is2vycY3ltCstzF3eFZCLGxHPeAz1PCJjTXjW9WyCoUW0yqxYynW7IUwxJRWvihqU3czn
	 AJGTJ6gqfznnp0jYpS7NoHeF+lKjfCqpSRfYFohke6Vd9ntofjB4eae2VT1bY+NE0XIbw
	 s/X+TKmqiYBoW7eAGvTobCDmHVc8nzxUYQoM+mHlceB0Eyy/Mqvl0RVLQnOYBxDhnsm5S
	 Ebv6X8TByg6dijYaZae20yykOhVxS6YGnotCeSPmTiXY+A3N+rLTolu+jpf2OMYY+Vg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790064576;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=PE3GG0Zq5GHW1YBmDAj2j/TtiioAoG1QPWaJakB70KI=;
	b=WRXBDGz1iBM3u7R/MJrnaqVrNU3eNazavOxUNDhHN6p75rFNuK0bKKjZWJ37vJBM+ikA
	 sVCjwwAgvcXqdPi4L7sVjGnNfaTWEAbehTU40xU8EH3sHMTvHnjBZ6OGDTJKFbsTWrNFR
	 AUoboMeq3qfUobNDyXpDKtGSH3iJO4X3EFsL70dRNLC/Dfu++Bh7RIuh0YRHEbEWS/OTq
	 pvdREbVpaiHPTkifVaTUoDdG62V1dMG4FgfjKFk7cvkr/3NWJVkFMKU+AfPTIZ7iDyeIi
	 i4L7pUM0PFMXzyFoEOA4FNFLovb3q7kAyWDk4AgotO18Fwu4YKr8FDwoxV7t3ykfWlQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=evuoaw48;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 70FA3F800FA
	for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2026 10:09:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70FA3F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=evuoaw48
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E9BFA60DE9;
	Tue, 22 Sep 2026 08:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0831F00893;
	Tue, 22 Sep 2026 08:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790064571;
	bh=yuzBlTjpEw8mcDMgWo8yHHOE5R9PctYKJSKemWLS04M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=evuoaw48sjHqCwQlD3Ol7VFjPdSkgHkxnFzwDxdm1YXsK3pFPs8S+y0NBfcCOCnt4
	 g98JL90GICOz+PQbNClb9/Os6k7Jl5lXE1YaTY5+8bnREdDYY9tTDn1ts+nSaVU75I
	 WCx9oqNk+L97vTImmWGpUfvCMgXynB9BZb5n2b2mJuFAe0OfjUQEfP+hzf4GBNeONv
	 Tx7yNqS85gVL86bxjz/IrfIkj1PwrTQSmeHsSlito38v7N8bBdLr2SfefUpGxw7KVW
	 pTm7iM2d922r/BpOwsOivVO9+sg8mKTXr0Z8BF0v4O500WxfDOXaJ3KkdGQK5ATzmd
	 UXZvtUHJBn6ew==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com, pin-hao.huang@hp.com,
 Syed.SabaKareem@amd.com
In-Reply-To: <20260921111930.1040-1-baojun.xu@ti.com>
References: <20260921111930.1040-1-baojun.xu@ti.com>
Subject: Re: [PATCH v7] ASoC: tas2783-sdw: add firmware download status
 check
Message-Id: <178999389109.228132.12605131138902969199.b4-ty@b4>
Date: Mon, 21 Sep 2026 14:31:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PE3GG0Zq5GHW1YBmDAj2j/TtiioAoG1QPWaJakB70KI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqsje0e7FPCt+5+tqc+eXlGl4kmMsdq3TR96zFC
 LXnjfICPyGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarI3tAAKCRAk1otyXVSH
 0MJvB/4uPQyONX2riqUi9iJZDL6jxuXRvigUM1Qpsul9XOf20m8Fpvt1NWd36oHNLZUANXhjg1V
 cQsFnpJcDfbL8mNZjj32Pmw4xoU17ubgWzCDtDsWP5VOWXUYSDdXlgYreN6uTCK8SwWEVd8Rsbk
 zrs56ZJamOE/AXQGLtm+dL5/rXTJpSbT5yNMLhS0fgYGMVH6M7EkhvSNj/PEj6JnGQ6pZZNWwZ8
 yaOLKEtY+ZVnRr3BgurwCLzZgU22n34+as4Pa5M8mP8AOVWOGlrDKQnigrfJG3Fa9iVw3cqos7c
 Ad1ucXsfcRo6QJo3rEAbx8jE7z1Mcd+vEsTyGLEJDY2oQV6a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: NWHUNJITB4SHWJ32DGGHAWNGJU6XVPVZ
X-Message-ID-Hash: NWHUNJITB4SHWJ32DGGHAWNGJU6XVPVZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NWHUNJITB4SHWJ32DGGHAWNGJU6XVPVZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 21 Sep 2026 19:19:30 +0800, Baojun Xu wrote:
> ASoC: tas2783-sdw: add firmware download status check

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: tas2783-sdw: add firmware download status check
      https://git.kernel.org/broonie/sound/c/f42fbd560cd8

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

