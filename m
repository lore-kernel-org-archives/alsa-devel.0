Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B95C9830E
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:15:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C18F601EA;
	Fri, 25 Sep 2026 12:15:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C18F601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790331349;
	bh=UIbX8sE71CNO3QHetSKjRNnf431f2UIk1CPHYiezPaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ga8DuiOsF4cirGNXy+X84RPTk081+jftFl+RPPtD9apvmJQyqqga+Ypymw1vJMJqC
	 pxELIBCKep3JY/mI7QxRTTlQrNl6i4kjcG9CC+cD3/tYom1eHVXXeyblkSlgZPEJ4b
	 J4tjBUGjkq6rTt5tOnigq1JDO4eKSPrAVaLX3iBk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5216FF805F3; Fri, 25 Sep 2026 12:15:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2970F805F1;
	Fri, 25 Sep 2026 12:15:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 832E3F80553; Fri, 25 Sep 2026 12:15:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790331304;
	b=CxtM7TgCheQCoQRWmfHMG8REdCO4muThCopVt7jWKvYvGRkAEgQcRaTiYF18TleIi+7F
	 R3GJMW4iiJn/6epJ4iCTTRvLGdMppFHfEyp4njacARSoQXLnnIjeNP9/aUUlRngA+nstO
	 1NUnwUy+feFa1YK/zYmz+hlX8fGEEwvwX6elZZ2zmK/tW67MVthuwF96mBtT+neAlFraL
	 ANOFR0Ll/LJ96q+ORDzrj2KA6/2xag7aJi//iEuDnB0vJU1En3Ia/Urb5oZ1P6OjYX+5B
	 Hhn+8le7uA+A5lx3G5mxOo7vV4EZHRSDQpIUgQdCOIpQUlO76HFaSdqeFXGG1Do+pYA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790331304;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=UIbX8sE71CNO3QHetSKjRNnf431f2UIk1CPHYiezPaU=;
	b=JG94hVAdIoIwDB/g+JgYg1rlxKI2AN3+w+C0LxcMc64uLJdzIJYPZREXHuanTFC2bNjt
	 J/Yq79l6r7t0HaxyfBRnnFad8oIUwkGDkIYAUybGBzyByWt9vj2QOlOSGrbJlyAUPQY/0
	 u+MRN6tqLqiE+ARj4L2/OWT41BDn7vvVLtZEtytAOTqGQ3I99paM3Gybhd8Hr6wr5bzGU
	 j7CbRQbF1Gc2kQFDTN7wLhBUPtdZEsPaHEsDOvnLg42i+2OSVXNZofiPiwF1At6iJni5U
	 gCCKwj8UsbaVeQOwWYMyeAwJCk3WB1FpdKPoARDM96PNcnfpUEIcY5Mo6VAJ4yjZbbg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q77Fk2u9;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8133DF8014B
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2026 12:15:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8133DF8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q77Fk2u9
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4198960136;
	Fri, 25 Sep 2026 10:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCE61F000FF;
	Fri, 25 Sep 2026 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331301;
	bh=Luzxda0LMTwI+lNnOaEuam6CW6l68AEeAnvFnRbtWUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q77Fk2u9O0xNWUlImGgOgRCgiDtvA6RdIYjdgMAgLHsFQw1M/4qiSWbPJhGl8MLWs
	 tOqpZyEV5OXR0QZt/QXdGsct5Eqaoxxn8IVCOmRk60dZwmOVKssPVk6dwbU+zG24qC
	 +GMBowFSVwnCGFYGsaYoanFlNwK8Nzb8ZdZqucQCjoj4OF0sEi7i/6DpC1rN0gNpy+
	 qwREfVvrZfHvFd9AasxP6cuRtvFzSYLCSx+Z31esz1a1Wi2MTaCXCE6Xu/J613vwkz
	 reLYrB3oxu5BOKhfBpXQoUihGfry1ycIi2EH/JgRymxk4yWJgIyNcABC30iFfGlAZn
	 QX7y/Xfl/TlNA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar.Mukunda@amd.com, anson.tsao@amd.com,
 Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 kernel test robot <lkp@intel.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20260924124205.3376083-1-syed.sabakareem@amd.com>
References: <20260924124205.3376083-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: fix TAS2783 SoundWire codec unmet
 dependencies
Message-Id: <179027616368.149798.2746642245159861526.b4-ty@b4>
Date: Thu, 24 Sep 2026 19:56:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UIbX8sE71CNO3QHetSKjRNnf431f2UIk1CPHYiezPaU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtkmfj86nWNpG1r4tDdxgcxVYyT26zpJmZ0Uqk
 D8Qa/qtyQqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarZJnwAKCRAk1otyXVSH
 0IqFB/9Ys8JHtgW0C7Y2iTh5Ad7UV6jYSEk6X0kofBMTfNnKRurOin8MgSGlrYFatkilgxJ7dtR
 f503TTieFLvqAgaRKbjG4V6fa/0UgqtV8TdJZRB2pEXTi6R7d1T0HoIu/Ri0uaklpLIkjGiu14F
 FomdWS42V4u71FYcuRNk74LtWqllocnvbi58Z5HKNEvDiOlPdwv0v7WDj+vS7FSbczO69BkItxA
 tgyx31+Y29yHsnM9utJaI5qVQYlW6o0t4iMpPw7lLK3AhImAq9S54Bi7k7g+BRfUWY+t+CZDZyN
 Ybznsfxhtec8+x0C5U129OwlBRWQ+5yT6VMrcovVA3m/jx1p
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 7WYCJ2MVLVHMPQRL7ARBDHZPWRGO3JI7
X-Message-ID-Hash: 7WYCJ2MVLVHMPQRL7ARBDHZPWRGO3JI7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WYCJ2MVLVHMPQRL7ARBDHZPWRGO3JI7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 24 Sep 2026 18:11:52 +0530, Syed Saba Kareem wrote:
> ASoC: amd: acp: fix TAS2783 SoundWire codec unmet dependencies

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: acp: fix TAS2783 SoundWire codec unmet dependencies
      https://git.kernel.org/broonie/sound/c/d06607bafb36

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

