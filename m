Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163A21061B22
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:43:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A1A46019D;
	Tue, 31 Mar 2026 00:43:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A1A46019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774910622;
	bh=GqpzoDCFTJfoLnaHO7wXjnorLWXqzpoJWjBhaAG/Ka8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y2zBFwQdrrNXa2g31xguu/XMNDWyPoxKRsd2uSoxEYEU0oAfH81od85kqjTfaxNiF
	 rJuRRFYC9ts0I2ZK2ndMF3rR6e17zFObccRWoBzA4GGnQ18T339gKlaoi7XGWJGrt4
	 3Dm+8ZGs7I7HQ70B0ihV5uucR2WHLo40Kz3aeNk8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B227F805F7; Tue, 31 Mar 2026 00:43:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F487F805E4;
	Tue, 31 Mar 2026 00:43:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D493F80524; Tue, 31 Mar 2026 00:42:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AD762F80524
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 00:42:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD762F80524
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RQ7s+DEt
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A9B7A441DD;
	Mon, 30 Mar 2026 22:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8781DC2BCB2;
	Mon, 30 Mar 2026 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910574;
	bh=GqpzoDCFTJfoLnaHO7wXjnorLWXqzpoJWjBhaAG/Ka8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RQ7s+DEtVImbc6UC+lmIWawtOk8YclIx/J+CJPIjCIO/DbOVToD2p3l6L7y6VzXFS
	 Qe43Hkj31XIapeKVhjEPN+3w+UZN+2uKwmrL68a0v0QA8DHYj3uiUaeF5wnlplYfCB
	 lPSe9i/uVIqj5GsG/jPuRcZo6EUMhIkxbOhEuxtHrTUN/u8dNbe/BBA4Fl2hckc73G
	 bne7E1UjBEQqJN0BjKyMGiTYWOgUEUMTrxInF8X1SEz823qS58mK3x/0YCsWC8KScN
	 Z9dUN6ZB+2XCZkED58o9saKDOY8efKbW84RtzDrW5aAIYUESth21QxYthvq3iM8m3e
	 aT9tZuYmwyeeQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, superm1@kernel.org,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
References: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/2] ASoC: amd: acp: update dmic_num logic for acp pdm
 dmic
Message-Id: <177489805339.241608.457985521728695060.b4-ty@b4>
Date: Mon, 30 Mar 2026 20:14:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GqpzoDCFTJfoLnaHO7wXjnorLWXqzpoJWjBhaAG/Ka8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpyvxrvnKwYZKb/FYJByGw+1cECrBgjCaBtd8N3
 AYqJvA4B7yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacr8awAKCRAk1otyXVSH
 0J2CB/9y9dTQDHVYPXL12ZUub+LiJHmnIdvOPAzGLG+j0pWfXiNXXkw9YsNFO0DWYVPI7wvlvBP
 FRm83qZKYLPtl21q7po1fpNyo1O7JU8zj3KNaqr29hVyUmzRlfBIMF42wTvvxyw7vMBNtwL4uT3
 PpVbx9gJVYrG8VQWzNTr7Yce22MQ0kqg1PmSy1jy1KeHLQkpNw132GrlBQvVfWGEQ5DteaeimnJ
 fo4ADFQyA4B0aMUtwXFxh7sW2ocP3gcHTHchsdMPIi3UMzfgrq1/s9iP4bSHbD0/JPklKH3vhLr
 AhR4a8rSYwdJUM0i74g6w0zcWo131+SbENRZdVGvpNTxjne7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 5YCXFXLMFJPB5UUOPH22Q4Z4PYSEEBGD
X-Message-ID-Hash: 5YCXFXLMFJPB5UUOPH22Q4Z4PYSEEBGD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5YCXFXLMFJPB5UUOPH22Q4Z4PYSEEBGD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 30 Mar 2026 12:50:26 +0530, Vijendar Mukunda wrote:
> ASoC: amd: acp: update dmic_num logic for acp pdm dmic
> 
> This patch series updates the dmic_num logic for acp pdm dmic and
> renames the dmic component name in acp soundwire legacy machine driver.
> 
> Vijendar Mukunda (2):
>   ASoC: amd: acp: update dmic_num logic for acp pdm dmic
>   ASoC: amd: acp-sdw-legacy: rename the dmic component name
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/2] ASoC: amd: acp: update dmic_num logic for acp pdm dmic
      https://git.kernel.org/broonie/sound/c/5902e1f3c501
[2/2] ASoC: amd: acp-sdw-legacy: rename the dmic component name
      https://git.kernel.org/broonie/sound/c/371f6a1d2a97

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

