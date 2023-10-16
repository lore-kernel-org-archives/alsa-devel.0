Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE36CDB482
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Oct 2023 15:35:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D05CD82B;
	Mon, 16 Oct 2023 17:34:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D05CD82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697470536;
	bh=iafXWt7V9IPqM10GE1vGARg468BFy6oj+6v1ELEAsUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=f30CpyGYTQnKOuhHupghaJIiwOh/dRz5+JzqapQrjfEiFe5YZOwpReV19sB4Vt+1p
	 uJn5qkK8DOn8z36UbmZxABxQYB9Ll/tdEqKhLl+PUua5Enb1hCdWLEomBbriK9U6sh
	 VQONo11ECz1B1T26zo2/eRvkH8YHVUXqSzzZ6ri4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF5D2F80579; Mon, 16 Oct 2023 17:33:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5682DF80579;
	Mon, 16 Oct 2023 17:33:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25966F8025F; Mon, 16 Oct 2023 17:33:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30A6BF8019B
	for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2023 17:33:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30A6BF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NviQlzra
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B817560FF9;
	Mon, 16 Oct 2023 15:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944CFC433CA;
	Mon, 16 Oct 2023 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697470408;
	bh=iafXWt7V9IPqM10GE1vGARg468BFy6oj+6v1ELEAsUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NviQlzrahSuWSK69arwyv+u4tgOuNr9HbCBbZHERiV58UGgtz9q6vn40MqeiXlJZU
	 s73VGVmzapMOZUtWF8XoMoaNmvT8+NmIWUHmgGbmKt4sZfPcJj+EXHbxvPLuoS6hk+
	 rMGrhXRMIda899B1DUgYjBNnNIutoWjQClSlvz28ROuJ7oSz5HV2GxCe8gZCd+lSUE
	 ASxlE8lHgN1Lpt4FDGr5IKV0qRM5lF0d1+Q0jhgiOpZEvz1QHT67cE3uh0A+DhDPbB
	 EJvI+2a15XvI5ESjiU6f1ZnjB+Ar2sejhcof4AOc0TTpbML9RhRUDYTWdRXRQ7eY68
	 wG4mnX0XoKd9Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de
In-Reply-To: <20231012191850.147140-1-pierre-louis.bossart@linux.intel.com>
References: <20231012191850.147140-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: SOF: misc updates for 6.7
Message-Id: <169747040730.42352.15383367335561890399.b4-ty@kernel.org>
Date: Mon, 16 Oct 2023 16:33:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: XGAWAYUNBJ2SCLHRDJRJNC4NQR5AGEZX
X-Message-ID-Hash: XGAWAYUNBJ2SCLHRDJRJNC4NQR5AGEZX
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XGAWAYUNBJ2SCLHRDJRJNC4NQR5AGEZX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 12 Oct 2023 15:18:46 -0400, Pierre-Louis Bossart wrote:
> New PCI ID, one fix for a delayed IRQ thread causing issues, one
> update for debug and one follow-up cleanup for the .remove callback.
> 
> Arun T (1):
>   ASoC: SOF: Intel: pci-mtl: use ARL specific firmware definitions
> 
> Peter Ujfalusi (2):
>   ASoC: SOF: Intel: hda-dsp: Make sure that no irq handler is pending
>     before suspend
>   ASoC: SOF: ipc4: Dump the notification payload
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: Intel: pci-mtl: use ARL specific firmware definitions
      commit: 3851831f529ec3d7b2c7708b2579bfc00d43733c
[2/4] ASoC: SOF: Intel: hda-dsp: Make sure that no irq handler is pending before suspend
      commit: 576a0b71b5b479008dacb3047a346625040f5ac6
[3/4] ASoC: SOF: ipc4: Dump the notification payload
      commit: a2d952ba90de2197a27e1443b783265a91760507
[4/4] ASoC: SOF: make .remove callback return void
      commit: e4d09de3919bb0ed5327acb238e849f3287f2706

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

