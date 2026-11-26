Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB8606A680
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Utz9UoRh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=li+Igiae
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75AC960210;
	Thu, 26 Nov 2026 18:21:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75AC960210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795713692;
	bh=5yOjnzlFbAMLdCfFAmdAJ8dDdT1ZTjDyJj1f2pSw/bs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Utz9UoRh9+WvnTjQeRw7gOPXszfC6tD0f+s+3Kc1gsdhx47S972dFXCqFfWDaOiaA
	 OAMy7TdI+E2lwab+M0sG2ToUajJflL3l2GyktQl/ItGhh0AcGf7V7N34JWFZuNq6ch
	 GLYJVdiIzgyGbZg9gNmeaxJRer8SnweqymOyXnX4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9B3DF805FF; Thu, 26 Nov 2026 18:20:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 64265F805FF;
	Thu, 26 Nov 2026 18:20:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 427F4F8051E; Thu, 26 Nov 2026 18:20:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795713652;
	b=rQvqIF1gBuUbISe1lFTP+1yN9YB6sqo4K2cFzyKQUDl2qivPzMIu0pV8BzfLVqmi649s
	 PLml8tZDu5cReMExnLX0IcirkSjhRhNA3R7NtBb6fWrqtg8AoURmCvIy1vunVRZPn/PW6
	 7iXJGUYLH5FraqRMuXrx+DcWVNwI7Dy4uBXXkhrbyMZsoPLG1QYTJspKRlUL1QZHHxsl8
	 j4SsbJDN5PNCTdbWcZUFFq35vY8PMU2VYUMasiPc9iiFEnhEXxahiF706XyVfL4ql15cj
	 VsOt/i6onNqHFIORoM0vrcU8o5uU/WULb2hactQwzBwewQFU7421H2XMwVS9O8jCzUA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795713652;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=5yOjnzlFbAMLdCfFAmdAJ8dDdT1ZTjDyJj1f2pSw/bs=;
	b=I9uCC2E7zRC+kFdKmMOs5cYi3N3SYR2r2IlSju4w8Uk8GdBHnqNmNiO4zDfgMjYiv0La
	 0pJVPHoUjBuS6CFKWzxV609BsnOSLeUFYZ4jDAGtZEGiLdGPRkLnEQQRe/6r8B4Kt93bE
	 +HzgSo/ouubjnFX/WUG3uBSWPjQ1S2LVNDIVCiQqqymTNsvpFc76W9ssUPcxR6bWN54C5
	 ShlQM9xGAHyPf7aucdKHeDcZh4S9c33EGLZtcAoWqPTRWgOtLvmBHyhE6PX4ReRwSnpIy
	 w0iACh1G79/0vEyyWq3xs246lAFthqVVJnnZLxiDurkzx77QmqaCXJxLw2Go9VtXkEQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=li+Igiae;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4445AF80100
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2026 18:20:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4445AF80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=li+Igiae
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E6457405DA;
	Thu, 26 Nov 2026 17:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D831F000C6;
	Thu, 26 Nov 2026 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713647;
	bh=b2C1CVimNes2c9yCOhSsSfuW6qBdbjlb3OJoRytVRmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=li+Igiae12ds35r2S6u6F+QPetBcDPHZ8KqyLNqVNFs7hk4ZLRPECWt2VJ6HAgtSP
	 oS+4CizKj5Zay/9W2aNjpz260r3me1h7N8ZXIDIlXPSdr2E4Yyvj7TDJtsDavZ5hk3
	 3kX0gGxLG8bLaKuZkU8AzFcFxZPwB68M550SgHT5+MSmezqAYgXybnF2j/blAaBR9C
	 siKMs/oiHH4Nf8q2nOraXX6+IhwDCoIKaP8efRA3DJICVEG1StQtjNYOjFw2+GTTeg
	 1d2HmWGFe30QfSMtZYjB4jxqliwgTEhwIj7tn5NvoxAZqZ7C1B68aUT+chzHXPS9qM
	 fkjn15dXM6C3g==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 linux-sound@vger.kernel.org,
 =?utf-8?q?Alen_Ti=C5=A1ljar?= <alen.tisljar@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
In-Reply-To: <20261124182329.20428-1-alen.tisljar@gmail.com>
References: <20261124182329.20428-1-alen.tisljar@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board
 8D22)
Message-Id: <179570533321.142532.15788602041527539127.b4-ty@b4>
Date: Thu, 26 Nov 2026 15:02:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5yOjnzlFbAMLdCfFAmdAJ8dDdT1ZTjDyJj1f2pSw/bs=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGsIamyjfqKjYMmF79kGEoEhmC46agAZ+8kdK3WDV0RlL1Ep7
 oh1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmsIamwACgkQL+9zsLPQOIk64gEAwEol
 eks75YRTX2e5D2o0nP0hK8F2A/g4uVOAu2b29voA/RJFqm9E3ZBv8HfiRPNvjKCEbNUNIq1cUOF
 was+VcEoO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: JQRXRXZG6WY77U4JVWVDZIYYHLTSJM57
X-Message-ID-Hash: JQRXRXZG6WY77U4JVWVDZIYYHLTSJM57
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JQRXRXZG6WY77U4JVWVDZIYYHLTSJM57/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 24 Nov 2026 19:23:29 +0100, Alen Tišljar wrote:
> ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board 8D22)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board 8D22)
      https://git.kernel.org/broonie/sound/c/b4378764a589

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

