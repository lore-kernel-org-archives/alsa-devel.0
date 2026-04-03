Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101CCE85381
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 16:54:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D47B6020D;
	Fri,  3 Apr 2026 18:54:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D47B6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775235259;
	bh=RQc3P5T8cbMkD2rpTxlnEB7bvYhglR3HFw8zfjwCBZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jO/NkzDcqIl36icxcsHZALFNRUu+p/VNqsXITOglfRIPrEPmSCnatKKxOQm1IS7Ak
	 h4oG881I9EFpvYQ+/aExzq6cLmYHKlFSsVdAI1SSdQEotQdtEQjTwuzjt1FzYc95Jr
	 ldgv5agw9zMECv5MIGQOokwtRWMlRiMAO/vBSoYA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E94EF80600; Fri,  3 Apr 2026 18:53:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 118E9F80610;
	Fri,  3 Apr 2026 18:53:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D738F8055B; Fri,  3 Apr 2026 18:53:26 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F01ACF800EE
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 18:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F01ACF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rzH0Mi+F
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BFC42433AB;
	Fri,  3 Apr 2026 16:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4691DC2BCB1;
	Fri,  3 Apr 2026 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775235202;
	bh=RQc3P5T8cbMkD2rpTxlnEB7bvYhglR3HFw8zfjwCBZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rzH0Mi+FbDS+5XAPc/d4hehMhAypPZOAmFokbgrvueZbwuJSdYxtBaZX2fGw6Cc1i
	 9sLr3qzwTbhzHlfYbDhZgljvaR52cN2t7NMHGItCoFX5aP0RdhnGl5O6uZu5T7bak3
	 2rXlbs8V8DlOGkODwRBKktvYj/zRUpaPruhikCEZOnTHrO8vIihsQ8W0lhspQpYYTp
	 da7z1M8B0Y9Eyx2rgxofu79HMAfm0xR5JZvpFXfRSqmi4wEsQVBVNCkvURjO/83zlO
	 UEANrni/Z5K4ft9FaKnM104ci/t+xG/SVH/6SHPnxpu1wveE8O0fZKisEhlKDRH5IF
	 dZZVJ+sg90raQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, tiwai@suse.de, 13916275206@139.com,
 krzk@kernel.org, alsa-devel@alsa-project.org, baojun.xu@ti.com
In-Reply-To: <20260403054449.177-1-shenghao-ding@ti.com>
References: <20260403054449.177-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Explicit association of Device,
 Device Name, and Device ID
Message-Id: <177522045575.52946.11290216468644376814.b4-ty@b4>
Date: Fri, 03 Apr 2026 13:47:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-67696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RQc3P5T8cbMkD2rpTxlnEB7bvYhglR3HFw8zfjwCBZ0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpz/CAjQV4XjACumE64bwPTtO678UQ22eB9uwkB
 inH6QknW5CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCac/wgAAKCRAk1otyXVSH
 0DkLB/9T6nCmK12WNjNBfCXX+dcid9UtVTmG83FiCALDe3jk16ltaO6VLIRfJfZ/ora7O5kGaKr
 5ar4j3dkk7bZmk4zUX6t+88u1h1plvMtATVjEDGRn/0dsUMiMvWZwhfJgR5JQSfesws/isGixb/
 XgdYIpXMtFlv1qEjId2Nz2BrKAgaWTROd7EVL3tiz6CcG2MqV6AuIoA0Y8ysOebqvk/yrk042E1
 bSZQLuATAXz3E8Eqjkp2Mp+CGqzMlTYbV9szxkW4PakQQmywpTyps4Emo3TTbM+1LRgeS+dW1on
 qkto3BUFQ5anqvpHhnptDjuKI1n15fMLSvM9N+uUKeUUlRLV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: EFCKDFR7C7OT2YKMEA2OPF6FACYQV2B5
X-Message-ID-Hash: EFCKDFR7C7OT2YKMEA2OPF6FACYQV2B5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EFCKDFR7C7OT2YKMEA2OPF6FACYQV2B5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 03 Apr 2026 13:44:49 +0800, Shenghao Ding wrote:
> ASoC: tas2781: Explicit association of Device, Device Name, and Device ID

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: tas2781: Explicit association of Device, Device Name, and Device ID
      https://git.kernel.org/broonie/sound/c/78c59297280b

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

