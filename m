Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E8606A32D
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=GR7Owk1j;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Skv3xcFQ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5388601DC;
	Fri,  6 Nov 2026 19:39:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5388601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793990366;
	bh=fgeNflnNSnXr65iR6WIzFIwWrawCrsV5fmeh7u+k+Ww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GR7Owk1jooKeKLbTj7KFYma1KRof6yXVv/baqidih0Ol6y1kUh1NXIYqtueTke4RK
	 snr/ZfxJGGlaioTGmm6mahtUkZG8UVKa8nKhsVz/Ujk6rqNtsSe9Zwmoe7tbCeBfgK
	 m1PqY5Dbrt/TFQ5eLqELE/fEmrB6CzbUno+/Y9kQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B13BF80601; Fri,  6 Nov 2026 19:38:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EC0DF80600;
	Fri,  6 Nov 2026 19:38:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9710AF80510; Fri,  6 Nov 2026 19:38:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793990327;
	b=P4GfROSQQ8L2pRTR5Pp8c0UrXOIgn2b78zm0DZrpo7n/V2sEiguAhRLAW9B8xjQChbLh
	 anjkMJpuFOn0Sx1ZuMQVSeiRiGi8aYUpj8tGceqn5FjHaTLwryinF7xNvLy4H5EGrKTiR
	 9LLUYHGgYt+ohrx/uQOJcV0gdWMOrcVmBT2lAJJ83A10DHpTvQ2bOxKAR3/rE5KfpVyxb
	 tNcZzY99c3J7QtVYN7G7c25hIesyTl5HFicozmoajTVSDryweqTeKS2PUnrh745B2ec+t
	 9lzi7bUmMRTs/klj5E0M0QA2SsV95NXwZlL4xv6SNukR0UOX+9TAszJjpEqzHwsKAVA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793990327;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=fgeNflnNSnXr65iR6WIzFIwWrawCrsV5fmeh7u+k+Ww=;
	b=lQCZtGL587wXu/dXiqMuyySZSFXa3v5gR1gTP0UlH0odMrmQUddgl/LTqTW5hrcxhYRO
	 xwc8vUMGiO4Y9e3kR+GbwCv8oJaDdFYyprO2BJ8S/XBMXQVMC5N/GSURtp5QEuK06JcVz
	 UH3n5bK639JY1s+7NfFu7F7yVkNstIDKyPzodguA7fe2i2uJW9pP1HRMRQc1W3W7RSh2W
	 94Q3bhQwdbJNiAvEPgoMOzu+wOxWvIGbUiLiFfeqtLZho9N7z/tF2jdDlzk0j+TY9grT+
	 8xO0aLv7oQh7g7xGkfSM+SPbTnEHkYTPYO7cF48xY9KdG10fj30wjV+MQNjYsjrmT9A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Skv3xcFQ;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD909F8016D
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 19:38:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD909F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Skv3xcFQ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DD51B601F8;
	Fri,  6 Nov 2026 18:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC041F0089F;
	Fri,  6 Nov 2026 18:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990324;
	bh=siSMWyKHYtT430AcTInkTgvpD6BqnxvGGKiwRvbegts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Skv3xcFQMsomd32AWfrZDOwtwAUNlKsLQdXa78uo+AzHpdwYqoqqegKDaydbuCCDI
	 euectr0mwJBFjHRDOsF8QtG1VlDL/29PbbU/eKEwN6aBWKE3ZN69CbwJsU6Dq9NfQ6
	 rNuqKsm5vabNh86Zzfxewnvk4z0kb7CHaIHkmcj0Mh8yBIAjXp7+QQSIKYhp01Equ5
	 MlqnXS5DgC01frooG2jw8H2hsoc8mOiq+Y7s9I2MBaE5TTp3l1EN/FtQwakCJnsT+v
	 BjZPdYp7pg3fEYck5oBPa8EYb8iiVPRrQfpo6QGKEpnMRettlt7dcT4GTnuJENHInC
	 pZHPNiR7CnB6w==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id B954428D0FC5;
	Fri, 06 Nov 2026 18:38:42 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, pierre-louis.bossart@linux.dev,
 yung-chuan.liao@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Syed.SabaKareem@amd.com, Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 Poojitha.N@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261106130801.506026-1-Vijendar.Mukunda@amd.com>
References: <20261106130801.506026-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/2] ASoC: amd: acp: supplement patches for ACP7.B/7.F
 SoundWire machine driver series
Message-Id: <179397480411.3073895.2848070891789031303.b4-ty@b4>
Date: Fri, 06 Nov 2026 14:20:04 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fgeNflnNSnXr65iR6WIzFIwWrawCrsV5fmeh7u+k+Ww=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeyW16VtUst/JTtajhpsD4Tauma3m+5vvGw9F2N1bwi
 93NM4ZVHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIwT5Ghtvtb+pfHkr/0rR8
 5hepDZssPSrTbc4piV44ZHjq+5Um23MM/wsCjt4w5t8TnpFR1LljgVHH3JebcxPm7gkVzXdbxLF
 tKi8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 2JCBYKUG4722IWG2LUCIQLQUY3ABPPH7
X-Message-ID-Hash: 2JCBYKUG4722IWG2LUCIQLQUY3ABPPH7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2JCBYKUG4722IWG2LUCIQLQUY3ABPPH7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Fri, 06 Nov 2026 18:37:27 +0530, Vijendar Mukunda wrote:
> ASoC: amd: acp: supplement patches for ACP7.B/7.F SoundWire machine driver series
> 
> These two patches address nit-picks raised in review of the ACP7.B/7.F
> SoundWire machine driver series posted at:
> 
>   https://lore.kernel.org/all/20261030094714.1123396-1-Vijendar.Mukunda@amd.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/2] ASoC: amd: acp: fix adr_device naming in ACP7.x ACPI match table
      https://git.kernel.org/broonie/sound/c/2e2f6b2a7cd4
[2/2] ASoC: amd: acp: document PDM controller topology for ACP7.B/7.F
      https://git.kernel.org/broonie/sound/c/a9a7c22d3e67

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

