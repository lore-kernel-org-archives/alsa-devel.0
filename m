Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF46CA5FFE
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:17:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8874A601CA;
	Mon,  5 Oct 2026 16:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8874A601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791209820;
	bh=wK0A0cpLoG3IU3lnSYBzHWB3+DFPzCo2M39LNQgCXTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MW4lTHnwEn8FTDkK+gD4IEFTKijZMLSEn+x6ZYvejmgPNZxDH4Uy4SAuMSI3/nqJQ
	 A8KBnB7eMkXwruArXCQ3XZVD9VBr1BlG15XZMC9eyhCk4pK99X4HHYcMfj8VKm3YRJ
	 DlVACTihcdaPR93dNDKZKLmF87VjaFNADMXuY+qs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7E2BF805FF; Mon,  5 Oct 2026 16:16:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC339F805FA;
	Mon,  5 Oct 2026 16:16:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B6AFF80588; Mon,  5 Oct 2026 16:16:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791209779;
	b=rKs/aD9krkUC5hmOVnPOUCbQ2rsmmAxRVk46E28YyuemfYjU2169k+vo4OCIoFJztHWS
	 t7caru8rFCXgyecyOppMIjI5R2XOEbWcmEtQrRtJMROwRwqvasyJB9+RQnp0kOFPJ6mTW
	 AaZdhg/G0mxHlzAKTJqC56c0mWOr7pr0f8oS2XKnY4+iZuOCMoZh7II0l+lG26Qkn7qLY
	 HQjaaHHw9iUFgpjxB6VLuXd+ZO3dvpMXSs85xjyijyP5qlwX9L568kD4WjUDXJY4LCw6C
	 vmM5uFY1riDED2aYMwQsjcoZCv28cfneMY8s4dCnP8uUZ4SEmdY9m5lZQyR9MraXWQA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791209779;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=wK0A0cpLoG3IU3lnSYBzHWB3+DFPzCo2M39LNQgCXTI=;
	b=aNabZih4wFHUF7hB7AUvxDCjdhr+fdOTbeFjDHPLMM9zD5u0TCAl31In9a8I2lb/H4MY
	 xNUzNvhx4mGp+gJM4WwoFOnjUyGeT7bGqwjMjXR5wkg+ppbiM3m3b8OsBRYLMJwKYucxi
	 W/w5AKsO7xuNOK6PUWwn4N9VG07r5KEmxmuTLb9vqJZFOjIx0FRpI6L0jlbr7YHFWC0Xz
	 ua7NHrPY2Skd6FvdVBmhChJZWkW4h27n2kDdhfwzOKrl8SvbGufz15nYLkSnDKAaNF0R2
	 l8khX2zEk9VFC1vPdvhFUtzxrErZi3UMXI+IiOnNxdC6prSUq9/nWkAGs89eMM+U9Uw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ML6WOWbM;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B9925F8024C
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2026 16:16:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9925F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ML6WOWbM
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BE45543B6E;
	Mon,  5 Oct 2026 14:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9321F000FF;
	Mon,  5 Oct 2026 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209775;
	bh=Orxl5FHyGCiXhqHy4B1KJ3UbH0y2AdI/WwZXcl51m1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ML6WOWbMGz/g1SgyDpJFjO+/6V07sm4uGfIH7ZLyNBFEp/y1pYWcJdK7zu+6EL7uP
	 zTHvjPPm4OFJI7BeYgvEH25AROcetvieeqmIQvfem9lt0POKinHGISorSixixIuqwc
	 Tn49oPxoLGmPEysWDmtlle9w9aIcBTuOLFFSfeYv+dEqdR0nr5YkQkkzLs5tjgsWuO
	 J4OVubZMIY2D67nSrS+pYFvQ0AvWDGP6uwWRcpzxjlj45igTwPdXEmgExwLFTLZqjQ
	 D1FyYDj87OaHXN1tMcdA9BAE29J+/pJlliVMtMutwX2XHKP56474Acl7oQm5pLXOTa
	 EywluThTSU7tA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Fan Wu <fanwu01@zju.edu.cn>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vijendar.Mukunda@amd.com,
 Syed.SabaKareem@amd.com, stable@vger.kernel.org, songl@zju.edu.cn
In-Reply-To: <20260929061349.3879-1-fanwu01@zju.edu.cn>
References: <20260929061349.3879-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH v2] ASoC: amd: ps: fix snd_acp63_remove() teardown
 ordering
Message-Id: <179114604475.150114.3693851033489195230.b4-ty@b4>
Date: Sun, 04 Oct 2026 22:34:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wK0A0cpLoG3IU3lnSYBzHWB3+DFPzCo2M39LNQgCXTI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw7EpUGK0ktjHpDtsCihtgiTi+wKpbeLBrSM93
 GOEOANBOZGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOxKQAKCRAk1otyXVSH
 0FI6B/wJBTNJz3VNjPypiTv/eID1us4GrijLEjeSI8KMKxVgGcKWpGpYE/hHQ1haQwR2wYW4dxR
 IwmADfUPefqCdlHJbHv2AQoHnea6FmDRt1gr0JYEa87GTlvb9dfOzy+MObTFokarR3o8NeaDupb
 M4tFEChmgX/B+uKyID/D0fBkjqrMWZr/xPiuMPXkQk+OXSDTM5uGWOd8t2XYXjnwUj7dQKYR/Us
 EYb97mQlyA+N/24HHyW09hZAC+3804bhJGaBzA0gy5M/vYYoqxE4QvjFNLd4RZhWRh/QR7ymPka
 hA30ztj9mBDlcOFbh//lISQ2WtTgeWGVSeQMJYNSrHaQnVaz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: OIXE46D34BFHDZORVEJOKNPAFO4L4RZ7
X-Message-ID-Hash: OIXE46D34BFHDZORVEJOKNPAFO4L4RZ7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OIXE46D34BFHDZORVEJOKNPAFO4L4RZ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 29 Sep 2026 06:13:49 +0000, Fan Wu wrote:
> ASoC: amd: ps: fix snd_acp63_remove() teardown ordering

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
      https://git.kernel.org/broonie/sound/c/c53791d673ed

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

