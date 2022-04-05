Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2656AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Apr 2022 09:37:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C23251849;
	Tue,  5 Apr 2022 11:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C23251849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649151417;
	bh=mqQMPpdvSIuK+HXY7W3i3YXX6X8QtgNDppwNROx5WtM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hofAJvhxwEqwSg5GPGetzBIfd9sYFh9RWYlIAJ5eTBb0jJMDkpaqZlbgUJn2PlBjD
	 nJauazydGgOu71jet6/mJStncFYmLOFgPCKAcB/HixAiRgCPgLnyKZ47n0z3J9VlpW
	 NljqiNV3X8ejiGN0paMsrYWcymQiGsT6AMzI9bdw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0174F805AF;
	Tue,  5 Apr 2022 11:31:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE9B5F805A8; Tue,  5 Apr 2022 11:31:48 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC7F3F8057B
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2022 11:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC7F3F8057B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bQpZ07EO"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7467A616C1;
 Tue,  5 Apr 2022 09:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7923AC385A0;
 Tue,  5 Apr 2022 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649151103;
 bh=mqQMPpdvSIuK+HXY7W3i3YXX6X8QtgNDppwNROx5WtM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bQpZ07EOTDnLYHeg8swQitU4OfO8ua5qrOjL8WG7DRHiKKzefidrJPLwtThpyHcZu
 j6ucQB0Pg6ah/Mpa+s8n/Vlzjti7HwMGgTcxh8hswTB4uu8QVUVIF9ACIFti+CXt3v
 DXoW6eYc3GOYdhoevnZBntoo/wVkpk6jpQWtGEJssqy+KRPVVhcu+Y4PP2VboUhkRT
 nDNTjPOQlgrOJGqQzf105U63/vA8JhU71BHOQiMD3XSmmGhhxZfbqIUUokqIc4RLlP
 1P41/0rTY77HnJB49jBy87KtM1tvkfR4vMJKFhVCVZJtUrE0Hg2nJK/qAHbtSO8/Hx
 LmEorPBaTg1qQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 peter.ujfalusi@linux.intel.com
In-Reply-To: <20220331114845.32747-1-peter.ujfalusi@linux.intel.com>
References: <20220331114845.32747-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: Fix memory leak of scontrol->name
Message-Id: <164915110221.276574.16446486593569553560.b4-ty@kernel.org>
Date: Tue, 05 Apr 2022 10:31:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

On Thu, 31 Mar 2022 14:48:45 +0300, Peter Ujfalusi wrote:
> The scontrol->name is allocated with kstrdup, it must be freed before the
> scontrol is freed to avoid leaking memory.
> 
> The constant leaking happens via sof_widget_unload() path on every module
> removal.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: Fix memory leak of scontrol->name
      commit: 5708cc2f4b50c7bf27234eee77e1d9487533bbd3

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
