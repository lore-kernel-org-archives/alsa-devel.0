Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC5DC79F99
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 23:15:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F8B1601E5;
	Tue,  8 Sep 2026 01:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F8B1601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788822927;
	bh=oQCnQEN2DfwlFjb0Pze/cADr3Ar+3Xem6XUDSpXlb5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KldtgSHN6ZBwO1cqR1HTd/94kScKimbFFqbd+aROHDvF7znH0m0mxOo1XKP+lOCQ+
	 bMR12JO1ndnNhQxy0+Lxg15h7JrbXUJnruIjivv/xaVPG4MDFcLBwtcmvY6frAQ267
	 Lo/OCpAO0bZ3FNgfYN0Yv62s4JfAhsn1W4HX8/DY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BB25F805F0; Tue,  8 Sep 2026 01:14:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1758F80601;
	Tue,  8 Sep 2026 01:14:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 028C6F80518; Tue,  8 Sep 2026 01:14:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788822887;
	b=oudJTPgT5HkSquTfAwfTKamyxMBMDWyu+AGeg/aaLroclX7mIIXTm1Mc5XOz8OxwIEAW
	 5vvkNmXrKR3gWrBut7p8EElwf4FV/dMtr8Q/0dZZFTZUXT6K4fXZU8TZkIuZ/rL6BAvzc
	 Ibmn7bDPw98nnwERctlC4NX6hcPsjwzuFcy1ttqj30bzDRrZ5qWNYu2+7Ut8otCv2d1B7
	 VWtEtWAyhvyFso7OQzg0rNtZIS68KdpFQfd7E0Muk1R8RNwOKAvqUdxraPegXnj4Iilv6
	 0inaX4Xi73GhQ2WeELVG8+kbR5FT5fdApJF5f0V1DymjpnjcO05PRDvdDxIznT6eBHQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788822887;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=oQCnQEN2DfwlFjb0Pze/cADr3Ar+3Xem6XUDSpXlb5Y=;
	b=HqAqgCjFoXeQcEF8FsLJagzz541iebD5mpdxN3VbAz38mwL5QuX/dglOMJ+WnnMM70js
	 yCq9Obxv+NwciT4y3un3N5VmBVC+fQ+5voyAKqvuX2KcYdI+3lOESQAqt5ewv4lWJNQtJ
	 YMzDqcZ0m0bAytpYctpvUmcFeQiFw2e9gTMjosYBJMV9ePwyAZ2Gmg3t8UB4s9AoTSj5h
	 kNif6PE5Vmk7CVpYnqqFulAMFiT6a8K2c8nEBQvHeZtsjePsRzEXUiO+bYn5+u+qNfEPf
	 9B3YYm2J2rd+SJoN2a35XDTe8Bky2JdiRPOsMfmyjsbV253AMu7rLI/3huK3OtrA8hw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RUDD6UY1;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 345F4F800FA
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 01:14:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 345F4F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RUDD6UY1
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6007640274;
	Mon,  7 Sep 2026 23:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F601F00A3A;
	Mon,  7 Sep 2026 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788822882;
	bh=QIqKqWiMn7M+90S1KP8NGtWC+CfwTYwmJbjpL66AuKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RUDD6UY1FnGc7jMdPEOpQZ5CPgJSNClEa9YwWsU/x+yKakpj3mzk7he/HPSzSPXWr
	 L7XC1vQrfcFbX0H/GHTWE6VwqZhXDTg2ffMsh+FeCImojGDT1YHJvZnIK1aeAZEPk3
	 FimnmXUIUPXtUTMfh2pRTpxVjl9MZmehZpG9IdlcqXvLksG2zs9ozP/Bu5Wnz81fSm
	 mDxFHcGHmjniu2KzVwFjaBik73AYmMmlKlxHEl0onSd32UFvHRfkq1GVYvjnoucTpF
	 mGoOalol1ZTLFX3CKuLMcKYSXwsptbilNt0uWIXxozKhJQsw0PNOUjrDgzxsx/j9Ja
	 dOoAVOFSnx7ZA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Aaron Welwood <abwelwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260907031738.17257-1-abwelwood@gmail.com>
References: <20260907031738.17257-1-abwelwood@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: add quirk for Acer Nitro AN17-41
 internal mic
Message-Id: <178881485689.118202.6975212680087714192.b4-ty@b4>
Date: Mon, 07 Sep 2026 22:00:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oQCnQEN2DfwlFjb0Pze/cADr3Ar+3Xem6XUDSpXlb5Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqn0Vegs4PfOv+yugdaBfJZzk6+S5RwTdWcJgYe
 FbtjLWmp/SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCap9FXgAKCRAk1otyXVSH
 0KgYB/40A/VZL6b0uNHjYZwwbSsJ+MPH4Y3QfztLZvhtjwKCNKcKl7h7PwukOeXbton2DdEmNDi
 8FdTifqCBQDJ9ovthsgU9hi6BgQDrVSus3J8RWfwYLX7Voze/r+jJ/2a+s/LxxyBTq7XwEdMgXM
 0lsDaA0NxCa3bFHIf3YrtKzrSSzNBZcHWPCT9+1JE+K6Jg25IBuOsj3bmfZJ//wlN9ej/BMCxcX
 Jdo0yemntNE1xzgtSXJo4T+/i2DbAPKHmh3/EgHYk2Pf5LexdHMy58TAP6vpkOE1C/NjUfimpTX
 vbrbMYU700U3QZ/sPODIrPfC/IeAkkwiUufdAEYIKL0E7DnF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 35JHW4KFKDSEYZQN7IIDQX4GANBDHMXI
X-Message-ID-Hash: 35JHW4KFKDSEYZQN7IIDQX4GANBDHMXI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/35JHW4KFKDSEYZQN7IIDQX4GANBDHMXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 06 Sep 2026 21:17:38 -0600, Aaron Welwood wrote:
> ASoC: amd: yc: add quirk for Acer Nitro AN17-41 internal mic

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: amd: yc: add quirk for Acer Nitro AN17-41 internal mic
      https://git.kernel.org/broonie/sound/c/22728415a9cc

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

