Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757AECD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:06:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F24A60213;
	Wed, 10 Jun 2026 01:06:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F24A60213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781046402;
	bh=k5t7aVM8QYNUoNadvs+3MSDNcEi0SoFgD+88APBIQLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=U+VRnZO+FItqa80BhyuwUi0u4+IlhpTg0JuiSK/54b6JP95yiPkKABcRsiMaZqc1S
	 ceYJGQpwGKQn7H8SQzPdM2HL7xZjVe+nPpN4NU3wqOq849947JNwH+S3gPv4hXvtDQ
	 YpnCAK1emS8DhHNpYNkfWm9TpWh0pWtXGrVhkbo0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD097F80616; Wed, 10 Jun 2026 01:06:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 003C8F80616;
	Wed, 10 Jun 2026 01:06:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9836F805B1; Wed, 10 Jun 2026 01:06:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781046369;
	b=Joli+LizHntsCKnUKVZA4ybxx0nWTAs895dJdCj00y+Zj+XMfIVwrTsjxO3/oHlKbS4I
	 yAQ6C1Cd1ZGNGdEK9kW2FSQuU4pCKUu11MeUK6k5cU1cYgY2+ola7oHFu07BpM92qSKQI
	 jF/UMvuFWs4JvwP47y5Z731ND+PPvmDunvPVkLmalhcAyX5FSjgQA44bkS+d8+PcEDIJN
	 pBZ241uvwSDuy4StICB1zyHcPuHjEubuh7LObwcj9qCCcD1dYI3beLAqZVW8gz6ZO82i+
	 PSgiKUwRKZJE0w4air1bDDM0O7EXO5Xfm8ERi+eC3Vjl8DZAqwbo3QXldIkxAmYFdLg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781046369;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=k5t7aVM8QYNUoNadvs+3MSDNcEi0SoFgD+88APBIQLY=;
	b=arrC6ucnw5pxlYWKlhEt1wEnXeNeeKl9j9TNfLc6tp/uXAOo6JsTKHqEguRagWlLyRV+
	 CTHJ8vUD0ngY6mp6Cs74Yy4qSppsvlqa82Fxjx3PMv5cqzDAGEnsLPArCRKycdfelAY9J
	 0JZ7QC92HbL649UWAtNcp+xNeKiX6vrfR1pSQ36gfiQtJldNqaTmtj7Dw5JtDr461il/q
	 0OjTWYelreMGo4dlTAeF6ubJkBxl9bS2HMihRFNhhwGspYeovucBlOJX8/pqmV5tCMQUT
	 U5sjHagM8OHef3+EBKkAy2enKsQaRsI3UQtyobvHEtMxqwvul3CGZyo0ZWnGZwIsI6g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ImdYzAD5;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4752EF805FE;
	Wed, 10 Jun 2026 01:06:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4752EF805FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ImdYzAD5
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 65692602C5;
	Tue,  9 Jun 2026 23:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACC81F00893;
	Tue,  9 Jun 2026 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046366;
	bh=aNsIRvR/phnQOsYCPUenL8Mnhm7ycJtUB5dZQ7dgL8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ImdYzAD5eCVzPO248h8ighAOiXw01OTC19KP9vg2wGFxVbzFXipDbvJQ9Shog7wJH
	 tPhTmsKMvtYe4joKyT82YiMKyNqA5PKVC/0rKrbrcsQox+iYGeJbxSkVqrqYdmzbLV
	 chp2D3dqduBzmOJ+lt7zvbDeL/nd2VGpAH1R3Klkr9AK1CafYKNq8L/VfRhfLTgo1O
	 kpV/yTeaqnbfNr7ZScj6MSQHLmTcZQ2Bd9A2eIKt0BJUiycHsVRlB3NdWCL9ZaI+Wx
	 g6YLZ9exwGGw87SDrvrf1vfX6u6emsxgGYABfbCYA9uQya7l7UqKKp05c+rOOxpLhf
	 Z7Zdf69cxhZ5Q==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.dev, perex@perex.cz, tiwai@suse.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Basavaraj.Hiregoudar@amd.com, mario.limonciello@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 uajain@igalia.com, sound-open-firmware@alsa-project.org
In-Reply-To: <20260609160938.3717513-1-Vijendar.Mukunda@amd.com>
References: <20260609160938.3717513-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: fix for ipc flags check
Message-Id: <178102626029.34323.7256614430915240162.b4-ty@b4>
Date: Tue, 09 Jun 2026 18:31:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k5t7aVM8QYNUoNadvs+3MSDNcEi0SoFgD+88APBIQLY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKJxXfpM1D3Ar36rwSOwoyXMV+gs8mWEnHEAfU
 cDxZ7K/cDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiicVwAKCRAk1otyXVSH
 0FdlB/9PF71r0mTwJKKIawGI5IrmlIZfKekoqdqYluKd6im5+cBUZx/k1UfqZoOVGQUh4RcLvOd
 n6uxfHSzV0gE3kNfkbSk9ThNPp2IN/ss1nksV8vA9xtmICTaYMVDnvZuIKhDFu1zCl9M+fgBD4z
 i8/jt5soZzpFuzv6Kuv01BqPCDu5QldnXdsldKhDFMOROHTXXQXX+5n3KLU2iQyL97XQfuG24Am
 qBibAUkFePphs96JcF7hKFOsajArpZkGt4n/ZB36QfubivDVqn7Yp0HCKS9YRYOyMe9cI72VF41
 UTbrx4werx05dUWFLSg6STKMxbRLdy8L966K1YKlXNq0yO65
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 2UTDYS2QOL76VYHJ575BFZXO7BR6HT2C
X-Message-ID-Hash: 2UTDYS2QOL76VYHJ575BFZXO7BR6HT2C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2UTDYS2QOL76VYHJ575BFZXO7BR6HT2C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 09 Jun 2026 21:38:44 +0530, Vijendar Mukunda wrote:
> ASoC: SOF: amd: fix for ipc flags check

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/2] ASoC: SOF: amd: fix for ipc flags check
      https://git.kernel.org/broonie/sound/c/6042c91df60e
[2/2] ASoC: SOF: amd: set ipc flags to zero
      https://git.kernel.org/broonie/sound/c/25b17c06040f

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

