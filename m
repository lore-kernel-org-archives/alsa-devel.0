Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5EA1090240
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:22:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 450D36016C;
	Thu, 19 Mar 2026 16:21:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 450D36016C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773933722;
	bh=he34+0wizSFfqRiO9194UtqQsSk6XC+EjEbGeqPyUg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FfdV7hKbldmSHRLw89IpBwYBMDrDZsLpKR3k1DWauBzOvnEaWWT2O9vAe7v52Lljn
	 OSGcr0Ko9n99cjmBSt4ziP1LXcVGcclm4qYpmMPyDlDeRLhtSVL/PaY3mGldpgPxfx
	 Wi1CWNLZbCes4erF5ztUB2C7HSS19z77x/63NnAU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B872DF805F7; Thu, 19 Mar 2026 16:21:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50685F805F3;
	Thu, 19 Mar 2026 16:21:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71BB4F8056F; Thu, 19 Mar 2026 16:21:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A1C1DF80071
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2026 16:21:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1C1DF80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FV286Fqw
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 568E3600AD;
	Thu, 19 Mar 2026 15:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46378C19424;
	Thu, 19 Mar 2026 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773933675;
	bh=he34+0wizSFfqRiO9194UtqQsSk6XC+EjEbGeqPyUg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FV286FqwTmAbInFmmGb5ZsTqLhk2z2nPeit3LuwW4Kz8fZ8q25blEnd4mfE3aAZ/+
	 uSlMTZcZzpsqRpGX8m61obtXVuk06BMvWYlCk4hWQIrRwKZiAdhsMLIezJnMVXBO/b
	 Txl7vP4qRKBA2UpvgU2gg2gMnCISqD0KNLh03qc8o/f6ItqEJ8DVJLqmaAGtilC0lV
	 Q05pV+UK8qADp3J56E8nY1ofEDmn+qDRxnqdltNPrNMsCTX4zoRICMKvV6UIGC+ukY
	 +xncu4Jnm1aiZnhL7BS4Oe4YOUkCipXs+mHuaWLGdAUmODbCqvXFYzgu6cEuKNOGU+
	 BBk57diBEIWDA==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 webmaster@raspii.tech
In-Reply-To: <20260319090747.2090-1-baojun.xu@ti.com>
References: <20260319090747.2090-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Add null check for calibration data
Message-Id: <177392478513.62583.10628320822573233875.b4-ty@b4>
Date: Thu, 19 Mar 2026 12:53:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9787
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=broonie@kernel.org;
 h=from:subject:message-id; bh=he34+0wizSFfqRiO9194UtqQsSk6XC+EjEbGeqPyUg8=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhsw9IhmZy28c6yoLeqLId7GseLZ94yv9rnfsF1de03T59
 WjtmzbbTkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIjeb2P+nXTO73acXVnpR
 fu0liSLuhZsP3Xzv/njp94t3MhdPPLLVnPn41mNrpkdMi/Z7nZD+lvF6bNaGTfxfu8QqimYmr28
 tsPPPPWters82+dI/tabG+/qGUjeWGHuZlh2wzPadL+6X1tLDHerIXv2kSDZQuCH2ufKkDsfyQB
 FebddvnyWK9uZ2nbxVdZOz3TLq78I5mdFP6n3EVC7sFM+WKf/pYXpfN3+1xK29rMrpl4NWZTpqs
 3Sm69vJa0fnMDbfLD+vWeeYkZYjtLLw0Geh21x75wk1uz9VFqsvyE344riU4/TpSVVPnkwozzvG
 y3163mGFHVZeCitYdT7l5D14mL8poKW5LKRtr9L5T065AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 7AVECVYQO6A2IT3TQOM3TOOABKEZPGSC
X-Message-ID-Hash: 7AVECVYQO6A2IT3TQOM3TOOABKEZPGSC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7AVECVYQO6A2IT3TQOM3TOOABKEZPGSC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 19 Mar 2026 17:07:47 +0800, Baojun Xu wrote:
> ASoC: tas2781: Add null check for calibration data

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.0

Thanks!

[1/1] ASoC: tas2781: Add null check for calibration data
      https://git.kernel.org/broonie/sound/c/a437601a0a13

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

