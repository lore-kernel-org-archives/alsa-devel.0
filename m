Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE043E9A031
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Feb 2026 19:28:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF93F60219;
	Tue, 17 Feb 2026 20:28:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF93F60219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771356488;
	bh=wIjh6yOyK9DvQrfMqC6CYjP8Xq2hI3p/QomBiTZqeDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O90GKrWG2VSak4MmJRB9idy1TBp8OJueSxcFbKlh+2xAUGm5IJ4RTLG0BMSFYPgZQ
	 G5CAhuKUxrGQpRk+PQWVfgPKMbG9S8Xwlu40rze4wuT2jLu4bKPx15deMMVWIcogE/
	 G3mL1F5Kp43AcddP+TwHlQBjC6+CHHwJ+0k9/lkY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD916F805E7; Tue, 17 Feb 2026 20:27:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6DE9F805E5;
	Tue, 17 Feb 2026 20:27:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DD1CF8016E; Tue, 17 Feb 2026 20:24:46 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B47D1F8016E
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2026 20:24:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B47D1F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZXS0WWk/
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DA0CB60053;
	Tue, 17 Feb 2026 19:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD78C4CEF7;
	Tue, 17 Feb 2026 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771356278;
	bh=wIjh6yOyK9DvQrfMqC6CYjP8Xq2hI3p/QomBiTZqeDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZXS0WWk/SEhYE2UgtiVxYfMprA0V3mTvmuBWGpsGrYButsFgpVf2A8rBlKF0ggnML
	 MFpd75tjsw3oH7r7ZBFVT/NEc5Tg/kwkMuzG6mQJ+ZKdYFM0S9UPcHueNiHHVZswbK
	 jmdQakIX/xUrxjHawla6ShbxtVSo9A5CYlW52dRP4QTO9h/Z16zeiSfUBSoULY0kOq
	 iDt3kgTYa+ovYWyjEAsFaWpNNlv4O/wgutEl+Fy01RyaMM8YX9PWykdJk9LgdEVIIy
	 L2mjK9qMWWSRJDz0Jkv+k4Xw4tOfDUye8v1EyVPZrv3zkEd+lygji7+IOYzCTcCMtU
	 okz22Y36QRCUA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Niranjan H Y <niranjan.hy@ti.com>
Cc: linux-sound@vger.kernel.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, perex@perex.cz, tiwai@suse.com,
 cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
 shenghao-ding@ti.com, v-hampiholi@ti.com, baojun.xu@ti.com,
 dan.carpenter@linaro.org, sandeepk@ti.com
In-Reply-To: <20260214104710.632-1-niranjan.hy@ti.com>
References: <20260214104710.632-1-niranjan.hy@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2783A: add explicit port prepare handling
Message-Id: <177135627519.310944.4176958928133427758.b4-ty@kernel.org>
Date: Tue, 17 Feb 2026 19:24:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
Message-ID-Hash: YRFFX5G4JRNMD5TZJIRK6I2M4CZOIU7B
X-Message-ID-Hash: YRFFX5G4JRNMD5TZJIRK6I2M4CZOIU7B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YRFFX5G4JRNMD5TZJIRK6I2M4CZOIU7B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 14 Feb 2026 16:17:10 +0530, Niranjan H Y wrote:
>  TAS2783a required port prepare bits to be set during playback
> even when it is using simplified CP_SM.
> 
>  Normally, SoundWire core handles prepare sequencing automatically
> depending on the type of the device available. For simplified CP_SM
> there is no need to set the prepare bits. However, due to a hardware
> limitation in TAS2783A, the port must still be explicitly prepared and
> de-prepared by the driver to ensure reliable playback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2783A: add explicit port prepare handling
      commit: 0d68ad088e334088b031423e59886ae118c11202

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

