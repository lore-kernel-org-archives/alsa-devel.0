Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CE9C3DA7F
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:58:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 753BA2D2A;
	Wed, 31 Jul 2024 15:58:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 753BA2D2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722434294;
	bh=2MGuZRFEEO1kB1smAVjl0s8IfGp3OX6tTyo+GBf16NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P48xT8Ri1TLyxvkT2z6hEy2hGlbz/JAqaDYq+0Nk/ZMWLP4xtBWHAyYsHl8gmNADB
	 wJRLbi8rVcIqT4t4+Nz2Zy56DxqAhcxxj98WmlorqTFJuOeYrJ+ODKk5SJrU/4p6Re
	 JFKpBcQgxDrQ0eY8BPHe4PRvEwwkmAFD9L9gYPPM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62432F80448; Wed, 31 Jul 2024 15:58:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58752F80448;
	Wed, 31 Jul 2024 15:57:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29C5FF8026A; Wed, 31 Jul 2024 15:57:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13FFBF802DB
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2024 15:53:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13FFBF802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZhXMBpD2
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A42CF6242A;
	Wed, 31 Jul 2024 13:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB9C116B1;
	Wed, 31 Jul 2024 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722434011;
	bh=2MGuZRFEEO1kB1smAVjl0s8IfGp3OX6tTyo+GBf16NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZhXMBpD24kmFimLqzac/C2Qh7SIf/ozyB+RInbe8ZcyLRzxirnJ4bLlmC3wTFwceu
	 IlBFqIZmrai4jH5OxOMzoaIW9yMYUghWzG8iEid3B4opPuvztrl8plAEgUcExNuGsd
	 WyssPCFaTyCsGc+u0yyh06zj8X3E84/WmmxdoK6DlISSH1lzrY6azg2GieWCO0K547
	 ibsxXvsJB5tktzUjMoGSJX7fKBPhvYwZrw5BoMbPIWXNB3EiA9ClqjZ1k6NtH1O7Xu
	 KNWl/3bJtqyB5Jcr4zDvE7mDTHiBa4WnO1IGeU/jDVGCz3OWMoQOeAklxHWfGpV/01
	 nYzQGPhPQoyqw==
From: Mark Brown <broonie@kernel.org>
To: jonathan.downing@nautel.com, piotr.wojtaszczyk@timesys.com,
 vz@mleia.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 Yue Haibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731022949.135016-1-yuehaibing@huawei.com>
References: <20240731022949.135016-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: fsl: lpc3xxx-i2s: Remove set but not used
 variable 'savedbitclkrate'
Message-Id: <172243400901.75630.3817479503151078602.b4-ty@kernel.org>
Date: Wed, 31 Jul 2024 14:53:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: MREVDFZRUYMARQX2TFOIIQVJO3SMNU33
X-Message-ID-Hash: MREVDFZRUYMARQX2TFOIIQVJO3SMNU33
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MREVDFZRUYMARQX2TFOIIQVJO3SMNU33/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 31 Jul 2024 10:29:49 +0800, Yue Haibing wrote:
> The variable savedbitclkrate is assigned and never used, so can be removed.
> 
> sound/soc/fsl/lpc3xxx-i2s.c:42:13: warning: variable ‘savedbitclkrate’ set but not used [-Wunused-but-set-variable]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: lpc3xxx-i2s: Remove set but not used variable 'savedbitclkrate'
      commit: d5742b5d4d7b99531e352ea814506641f9fc8981

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

