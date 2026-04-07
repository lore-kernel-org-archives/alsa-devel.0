Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A1EFF512E
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 18:29:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 725AD601F5;
	Tue,  7 Apr 2026 20:28:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 725AD601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775586546;
	bh=43J8STDVX9JU3+BDaKBt7Xg+JLv+ta//NsSTwVpqv+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FUUsu3yk1rlIEC3v392xG/ZXmh0jBvlFH0qduAaPe+6jVING48Mr8pJvx9xDiadQ3
	 myAIRYA8d0nGNV3OFAe5VG/4LG5DFOCt5gcJeyVLjWL11dAAqVLtZglK3Xzd0t3snK
	 HyBx0aogQV4ypNUC9fdj0ttePAoL8/LrSXfsnzd4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1616F80553; Tue,  7 Apr 2026 20:28:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57AADF805EE;
	Tue,  7 Apr 2026 20:28:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B47ECF80548; Tue,  7 Apr 2026 20:28:22 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CBB10F80154
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 20:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBB10F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Hey1G3Fs
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 50674600AC;
	Tue,  7 Apr 2026 18:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B7C2BC9E;
	Tue,  7 Apr 2026 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775586498;
	bh=43J8STDVX9JU3+BDaKBt7Xg+JLv+ta//NsSTwVpqv+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Hey1G3FsOS70B5eXaJ28vnKyCffxFHdTB+1eTgBwLopnTWoBUdUXitUbNTGnGQ/Bf
	 b1HqExFJ9oqMkZ6apsYkEmVRl600Aih1ragxyRdbmlFYcu1RQzXsXsHDTK1geDlKU+
	 U+FozQSONej8xcSDd9WwtKfeW60KOUYKSZxXpzKRVGABhT6Io30+rBj93jIem63ZaV
	 UzPowbotzricAOos4Lv5PGNYQ5OWIiP9lG0iBr+FBZOuiNPIMc+B+XW10AGbJq/Xer
	 RrIKsDQyCcxTUy3NLcDn7zDuXw8ic1gn7FeVnc0YxzNHoenaHk7CHEpTkYR75YEvnN
	 Qa+ZhsVShnw/Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20260403100624.676953-1-syed.sabakareem@amd.com>
References: <20260403100624.676953-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH V2] ASoC: amd: ps: fix the pcm device numbering for acp
 pdm dmic
Message-Id: <177558247965.125930.4964395587549968833.b4-ty@b4>
Date: Tue, 07 Apr 2026 18:21:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-7a3e7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=43J8STDVX9JU3+BDaKBt7Xg+JLv+ta//NsSTwVpqv+8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1Uy+Pke35rx75xNhhBVv+BDQVFWlRlsc/hnmj
 henuP40a8SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadVMvgAKCRAk1otyXVSH
 0CUYB/oDjdaaMVvAaOixH3FzZp70YI40VpA0JTSgKTv/yq12golWpwFEqsJ9nJFrBy23I/0cjv9
 Maw2lwVdfBC44XF4FUGetk/RmvCfmTdZMfodoR7ExZlIrpHbB9lGtQml3Yw5o9+RCssDqYnsawl
 Lfzr/wzq/VgwRN4t2YGci4dYodiiL69f8gBH1zWqadIS8m9HXq/ckgJOnaKe/97EWPqEK6+0xo2
 J7U5iOedkcFPL9pzhcj6KNd5IYwhyWyaKPHabzBMoBe8GrtXafk4+1RXXUXI323Y7l7lOK2T4tr
 D1H/SpFpoebr9qj25dLeSX/Alv7c07MZB4dsp4vVHv8JeWme
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: MX4X5AA45CZISZC5WIECBVDHH2LHNGAR
X-Message-ID-Hash: MX4X5AA45CZISZC5WIECBVDHH2LHNGAR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MX4X5AA45CZISZC5WIECBVDHH2LHNGAR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 03 Apr 2026 15:36:17 +0530, Syed Saba Kareem wrote:
> ASoC: amd: ps: fix the pcm device numbering for acp pdm dmic

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: amd: ps: fix the pcm device numbering for acp pdm dmic
      https://git.kernel.org/broonie/sound/c/3666dc0c47c3

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

