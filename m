Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B19E74AC4
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:57:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A206414DC;
	Tue,  3 Dec 2024 17:57:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A206414DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733245043;
	bh=5qlOCX3NRndsJ1AfUpcbpR7q1IvZ0cncYwXCKI1Y+ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZieJSbZzAz3YvunvHjdR6b02HWTita1YF0QihUR2xdx9CuHr9ee4hbgJc7BHsNats
	 7FmrP5dQ1xcBc/LFzH4a5iA53gP4HvVszR8W3OJ1Oln0QhvWx+90iiRsVnMxve1aWr
	 hfGrTVQfzjBEHi+qVlJU3kH6l88we2qFUnKvolWQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B9D8F805C2; Tue,  3 Dec 2024 17:56:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1D7FF805B2;
	Tue,  3 Dec 2024 17:56:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32390F80272; Tue,  3 Dec 2024 17:56:45 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01501F80116
	for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2024 17:56:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01501F80116
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sl4nkRz1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A655F5C5FCA;
	Tue,  3 Dec 2024 16:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457DCC4CED6;
	Tue,  3 Dec 2024 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733245000;
	bh=5qlOCX3NRndsJ1AfUpcbpR7q1IvZ0cncYwXCKI1Y+ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sl4nkRz1sJq33HeOKbgQcqbU1atoBz5tpEW3RG3gjdzceDRNlqhNsXnRD3o3zxVDr
	 zdoed0PqeAHejH3Nbyan5qRlf3OMvUnvdIJZhun46CRwF1cDg0XQnWfEb1amLV+p99
	 4MDLf3rQHNq0qS7A99L8xCeR0KVca7x860lN+KBOuSp5JbdqmvTJLDkthmyeg7jHr8
	 EB3QpJqMR1c9VU67c4EtFDirv1tmmFjG3p8uFS2gCaZ1iR58W7VXJKfcCUpgKOzXB+
	 q3hfaIEUuJZGa/P0qIbL8R39SgLDrk2o39FmHU/J4nHR2ukw+pJAqzLROPVPWk7R9R
	 KNIrSirfITqHA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Mario.Limonciello@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241203081940.3390281-1-Vijendar.Mukunda@amd.com>
References: <20241203081940.3390281-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: ps: update mach params subsystem_rev
 variable
Message-Id: <173324499801.445589.12273018696416224205.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 16:56:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: RV7X7WNZJLBI2YQ5TGZUYZ6IDBB5I32S
X-Message-ID-Hash: RV7X7WNZJLBI2YQ5TGZUYZ6IDBB5I32S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RV7X7WNZJLBI2YQ5TGZUYZ6IDBB5I32S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 03 Dec 2024 13:49:39 +0530, Vijendar Mukunda wrote:
> Update mach_params subsystem_rev with acp_rev variable for ACP6.3
> platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: ps: update mach params subsystem_rev variable
      commit: bcbf421d2190bc4f7d3fd2cc61caf748779ee69e
[2/2] ASoC: amd: ps: add ZSC control register programming sequence
      commit: 25cd677636d316669871947639430615ff564890

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

