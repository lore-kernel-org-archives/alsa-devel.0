Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE5AC43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:25:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFDBB60241;
	Wed,  8 Jul 2026 12:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFDBB60241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783506311;
	bh=ECKbbGtOp2x2gZp57R3hKGO+84VF39ZZfu1QVItVje0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FRb4msT81patkqK5N2PD27zwwR2Al/JFSBtRvQjR8J9wnOHsEk0VVIjO/F7j0kumW
	 uxAY3NVIZperFluoz82j3x1lFhZcQntIw0V6XUNsGa+rbLbshHbwPK9PCHKiCf6etq
	 5mIK+6C+giQ5y9FsxW1egPwjcueHDu1k9L3jN5dI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DA42F8060A; Wed,  8 Jul 2026 12:24:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88E51F8061D;
	Wed,  8 Jul 2026 12:24:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3B70F805FC; Wed,  8 Jul 2026 12:24:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783506259;
	b=fogc4QRCox1js8RX4+c/5l2U1t4wm7WpKORPOsw9LRDd7UiaZ7UP8xL2DgtRwy2UE4aM
	 K2aqgsYuTSOjn5GF0VCZVHjP71ya8Bh04pXCDRnGUYga+St+LJ6WjNgfSIP6iGZpb7KOp
	 cuBs/HE2T4bGJxCEij8ZLUWj+NYlFMxRkaG2Ij9+XFUwbig/ihe2QivQQ+SeRZ2CeuTzs
	 VNwF2lExv9EzXVFt8QuogRLKPxZ0lmxGfMkbVUKN5gRXS1uVkWO1sKsFGSttpqHwkbbqn
	 njutevloCIV6AW8gQyb4xu6nQ9ajUPLnaovNA38F1aGH5LUva4PzWldiUded8/mCYoA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783506259;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=ECKbbGtOp2x2gZp57R3hKGO+84VF39ZZfu1QVItVje0=;
	b=P8R5CC+YVXqIUmuiCttJZ3gm8GwePH5aQaFEsOVVSYHLDjgobQoSzFceqcd3QWqEJwGj
	 +Qsy21KCXEUj4gBbbWmHXneSiWkcNzgkn/OhEMNsBbz3WNPx8OnsMqZH8A9SXVJ27/M9A
	 0S9XDgDNnm1FcJ7a3b/1IxhXuiW+1Hr4HP9yIoHN1+tlQZABBwptv1+hfkDw0cghmft9S
	 p1NF0X0PTwQ6Tze97mx7hS59ImIoikOqUve6MMH0fX+tWbTsFTwjJiSut5rIgtYVCARMK
	 PDj9nD5asP5pJWqIYGKqZaZAXXTzBGs1YJi6FvmRe4qGVZVpuOYpRajk9ZGS6wA1PbA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PRM4zf3v;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5BF5F80224;
	Wed,  8 Jul 2026 12:24:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5BF5F80224
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PRM4zf3v
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BF0646001A;
	Wed,  8 Jul 2026 10:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAB11F00ADE;
	Wed,  8 Jul 2026 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506256;
	bh=q+Ff13ruJmFjf/Yku53IBSfQz543yzS9YWFafB1ADmc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PRM4zf3vF2xU7AkFfh+PjQsricrUGUvdRq/apiSnP3OcPo3uFWRMmiQsRqOqX92rb
	 fWzbJrUJ2fwHnWPvEHamMP1vKZAXqcmMuUshClk6GupoCQaVR9Bb17FUeSPXJytjj7
	 cisa782pGJujuXuelIs0uGwZ6BxQUDSDGwJDUgr7eWNLbSRgp3jD3j/hvAYpHDryh5
	 Slza0p97BMwUv7N73Tz/QJm30jol68p8sErTeu9qOVgO3z3usSG+te+psHqwpMpeDl
	 c/mo1NTnVyx8W4D5bzNefiYfPXaca/0YJhIXo3COslBqnpuunMZtM3Sm5BgUZEw2zh
	 ylyAbcvgz5DkQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Basavaraj.Hiregoudar@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, julianbraha@gmail.com,
 sound-open-firmware@alsa-project.org
In-Reply-To: <20260707060918.2535962-1-Vijendar.Mukunda@amd.com>
References: <20260707060918.2535962-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: add missing blank line between Kconfig
 entries
Message-Id: <178343923986.59892.13581171863866923036.b4-ty@b4>
Date: Tue, 07 Jul 2026 16:47:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ECKbbGtOp2x2gZp57R3hKGO+84VF39ZZfu1QVItVje0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqTiVMClTpAtGxH5RSOUyhSEEUI9X9TeFI8ShWZ
 JZUfLt+YWWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCak4lTAAKCRAk1otyXVSH
 0HqvB/9GKUnj451BgezhqHm7MDlhJZRaqx5xxww/+l0jAsc8EXdDXGN3AGzDf+l0z+TBrIHoetY
 7teZAubLi+L8DHeXOg9yeY4v7TwUUNnjYenPym/MoTYNdDJ+bpU5xiVzF4/rBfSrWKTXXsc9JwF
 b8yLjIQS4NWe2jjoIVFy3I32tVinNyX5YBTFxnLW9nnYz09UTobvnQyhWQAHpcoSdAlTSptpIg6
 +UDH9AGEwQyhudpGVD1o1A7lEww81ZK178KA310KrfzbdAGZ2kkxtR4MxjVpfuounQE2E/HmoBJ
 Qd2UCtDOUs7bac345p5t3NIUUNelUjQm7iql+8QLuXFboSy6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: ES77S5TV4QULUDV3V7KIVBK2ZPUUZSWN
X-Message-ID-Hash: ES77S5TV4QULUDV3V7KIVBK2ZPUUZSWN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ES77S5TV4QULUDV3V7KIVBK2ZPUUZSWN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Jul 2026 11:39:00 +0530, Vijendar Mukunda wrote:
> ASoC: SOF: amd: add missing blank line between Kconfig entries

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: SOF: amd: add missing blank line between Kconfig entries
      https://git.kernel.org/broonie/sound/c/6943ea99422e

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

