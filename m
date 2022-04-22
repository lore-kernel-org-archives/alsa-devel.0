Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FBFC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 23:18:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 045651732;
	Sat, 23 Apr 2022 01:18:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 045651732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650669535;
	bh=B51koVJNZuVrR+4SB2KJ6+p0wlu6GLJx3VaFc/0lp+Y=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TGYc4xmXDXLexCK3YfO0XZwVhreRV/jxjSdeoMvFQoS2SPCzP7LVsdvwCAYPLSgCd
	 rmXUSns2o8VIrYbfpMc6bguQVTWJ0Y1lP3gk9z6cfaX8XoitGAPmXA2+j88Scl4IgT
	 DaFghUR14a+q3eGQch0SEeP69uThrn6BTBy8uvuo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3594EF804C1;
	Sat, 23 Apr 2022 01:17:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AEBAF80245; Sat, 23 Apr 2022 01:17:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F626F800D1
 for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2022 01:17:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F626F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cAOKhxOF"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7978561704;
 Fri, 22 Apr 2022 23:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3670AC385AA;
 Fri, 22 Apr 2022 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650669445;
 bh=B51koVJNZuVrR+4SB2KJ6+p0wlu6GLJx3VaFc/0lp+Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=cAOKhxOFyjvbIDQIgFOt6VqBoiZYnKoWmfYLT7/kUh1HEu4gjci5HB7xppx6sDTxf
 UxHpzMZcio2DfCE2VY+dZMvZX3z2NdFsSgc9WJEL94/jeQnPnWVAJov2ZTS2yh/j2n
 6HxrZb8orbaRk8ietaK62m8z25XCgK+kg/5LgEH58K5CnJnpGwXznGwmxA4QIZGvVv
 tLBXGOYJDNXl0fMfAjly0payol172mk4XWRDelPi7ibJC5lSD3I4e5tMDiHZIFudu+
 x4fmvP+yEkUlc9w4LvYVQQUz0Cc+Vxkw6FIYggWQ18INlUpwM8hndbV9W73DaNQTtc
 muS/blB2vpnCw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220421163358.319489-1-pierre-louis.bossart@linux.intel.com>
References: <20220421163358.319489-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: SOF: pci: add quirks and PCI IDS
Message-Id: <165066944493.12937.10790951067843083658.b4-ty@kernel.org>
Date: Sat, 23 Apr 2022 00:17:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 21 Apr 2022 11:33:54 -0500, Pierre-Louis Bossart wrote:
> Add two PCI IDs and quirks for APL Chromebooks and Intel IPC4
> selection for developers.
> 
> Gongjun Song (1):
>   ASoC: SOF: Intel: pci-tgl: add RPL-P support
> 
> Muralidhar Reddy (1):
>   ASoC: SOF: Intel: pci-tgl: add ADL-PS support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: sof-pci-dev: don't use the community key on APL Chromebooks
      commit: d81e4ba5ef1c1033b6c720b22fc99feeb71e71a0
[2/4] ASOC: SOF: pci: add ipc_type override for Intel IPC4 tests
      commit: 4bfbbb76e82e5f1e0e114e0831356656b4169c80
[3/4] ASoC: SOF: Intel: pci-tgl: add ADL-PS support
      commit: 6c84dae212747d0c82057c48785f2b1b6c53f553
[4/4] ASoC: SOF: Intel: pci-tgl: add RPL-P support
      commit: c275872107fe1b7f9d39ce642e2d8eccfe8afbb0

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
