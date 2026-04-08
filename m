Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8959E10F9963
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:06:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0C7A60207;
	Wed,  8 Apr 2026 20:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0C7A60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775671596;
	bh=q6poiG03PKI9t7tptkcqJ55P4qKM6z6IO9aXIWvOiE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qKAXq+B2xWlLfa8zpmAfee4qRJuvv+e9X5oTKcDPXJv1iWk4tF0+tSw42UnFX6Q9M
	 /OB4FmouZSk2twkVzhU5CPJ3PWtj2StP7V2CoSc8sDdzZ7SM0l+Rown/EoL1UpcpkH
	 ibhnQJqQ5I8xr1lz0bzV3a4BqE1yiSmLvFxyb+NE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F948F805F2; Wed,  8 Apr 2026 20:06:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCA56F805E4;
	Wed,  8 Apr 2026 20:06:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EECFF804CF; Wed,  8 Apr 2026 20:05:54 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3493F8012B
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 20:05:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3493F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Zmn1uvRc
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9EEB0402DB;
	Wed,  8 Apr 2026 18:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708B5C19421;
	Wed,  8 Apr 2026 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671548;
	bh=q6poiG03PKI9t7tptkcqJ55P4qKM6z6IO9aXIWvOiE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zmn1uvRcPuEcF7VmRSjWw0d8OAP/2E5mBEppeIsmp6sQH9zu29kq+ZEFZhOwA1yGK
	 h0hjflXzZGKhghiVL0nOhmGSrsF7JiWe8Ax/TIyK6DObxMyu4npCK0so3/ZnOoPsPy
	 FtZP0kO7/NBE0VjXPT492ZiR2lS3VK+pc+2lx0KRcuYLlllos9QU6sJ2MjERhXdfdP
	 2i7AaVBZY07gDJoEVYvxhYuVcjm3DRKl1+ShQHwYXgE7zRYxtKtHUoO3SMjDuNRfPU
	 5hfKPMQaOKKimX9YBG72k0tAlBCDfxhluZIeIVJPFICwRomJ+8//qME91iMlupTTXt
	 224PJY9WAgqRg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar.Mukunda@amd.com, Sunil-kumar.Dommati@amd.com,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Hasun Park <hasunpark@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Kees Cook <kees@kernel.org>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20260408133029.1368317-1-syed.sabakareem@amd.com>
References: <20260408133029.1368317-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: update DMI quirk and add ACP DMIC
 for Lenovo platforms
Message-Id: <177566433584.101848.15145372021041613833.b4-ty@b4>
Date: Wed, 08 Apr 2026 17:05:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q6poiG03PKI9t7tptkcqJ55P4qKM6z6IO9aXIWvOiE8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1pj4HVtRR5+itJX/UFYoLoTLLJvUvLR3Wlv+F
 s9BUUPjmx6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadaY+AAKCRAk1otyXVSH
 0P9SB/9zcU/9WD/k6gGjltmxt26TLwvyzT7KSjhfbdJMiN7aTpf8jphCavXmy0ZgsWLwbi1Lxje
 b5maM6N9mVr4U4COl2ogE87JCkqEipCWDOlKKla1oHEnme9sFBtMT9ywjWBdHQnkaegdjxs0c+M
 fCCFqxu29BBlwdKhSiDtSxoliVfZIEqkTfeQjHNLXfv8FlQ1kwPFNlp8PTAEEqpLWS6OoyjnE4u
 8Vd6irbmnZ8Gzyf8OKbYIVOTfjSUVECxdZDSRXiooPNmNqPTSf1Du4UGLD0IWegX01VBUceB5WK
 lcWaBwT7fElELALpGZNCM6sF7lwAF/n5JCizqe1xXgQA03cJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 454FV27YS2GHUUA3HS5VYRM6MXZPYOVP
X-Message-ID-Hash: 454FV27YS2GHUUA3HS5VYRM6MXZPYOVP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/454FV27YS2GHUUA3HS5VYRM6MXZPYOVP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Apr 2026 19:00:06 +0530, Syed Saba Kareem wrote:
> ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.0

Thanks!

[1/1] ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms
      https://git.kernel.org/broonie/sound/c/6b6f7263d626

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

