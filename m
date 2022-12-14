Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A123C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 13:33:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 019A22A38;
	Wed, 14 Dec 2022 14:32:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 019A22A38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671024805;
	bh=YVfiy90k8tilTVTQpjmd0hDs1DlPV8FDiwz4/TOEKi8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=r2RfG9TvRIDr8c532zd+mlkhBsAC2P4G9JMU6Shf8E14FaoUWgR7tv0PYaBDY/x+H
	 xLcdaFCPR0wzHGjfsiiQ2mXngqhZH+pESu7S52oeEpjavTdwkmCSNnJVrvlYCCnLfV
	 uwBbSTzjeSGMWPUFEc40iPyQPyhEpT5G2v/FJRMM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BFE9F80538;
	Wed, 14 Dec 2022 14:32:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADB1AF80536; Wed, 14 Dec 2022 14:32:07 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EB44F80533
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 14:32:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EB44F80533
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fPe9URLn
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D4A98B818B1;
 Wed, 14 Dec 2022 13:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE63C433D2;
 Wed, 14 Dec 2022 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671024724;
 bh=YVfiy90k8tilTVTQpjmd0hDs1DlPV8FDiwz4/TOEKi8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=fPe9URLnFiUphM4bVUXbQrxLZ2rCoC2XjRu3Xx0eGjhJJn0BH/RDnOiioNxAJOezM
 3/oiaWYbzHcTXxEw2qy7IC/ANLl41B9vfGrcbzEMVk9iPG04G5d9OSn4h3K0O5mWEi
 wyS+GzPdwutyh68aRa0EN5CqXVGzZdyIdznLTqtau0sPav76rzAo0aVlGjXoWh3xtZ
 w7M+DfePWuf+TmiVkbvh6NUDuyRk7N5OPaQoxcfKsaBYkOU0sllCCRq+XzVDSdDWaw
 qW8WTKxm2El+Gt3OgIW7dDtWHpM8uDNpiqbZELtL0RX8vkPIuCisgda8iMc+VqADiU
 gAz9S9HQvl8Lw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20221209114529.3909192-1-kai.vehmanen@linux.intel.com>
References: <20221209114529.3909192-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: remove unregister calls from shutdown
Message-Id: <167102472177.27755.10161077455234852195.b4-ty@kernel.org>
Date: Wed, 14 Dec 2022 13:32:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: yung-chuan.liao@linux.intel.com, tiwai@suse.de, daniel.baluta@nxp.com,
 Oliver Neukum <oneukum@suse.com>, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, Zhen Ni <nizhen@uniontech.com>,
 ranjani.sridharan@linux.intel.com, Ricardo Ribalda <ribalda@chromium.org>,
 Archana Patni <archana.patni@intel.com>, peter.ujfalusi@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 09 Dec 2022 13:45:27 +0200, Kai Vehmanen wrote:
> This patchset is an alternative solution to problems
> reported by Ricardo Ribalda <ribalda@chromium.org> and
> Zhen Ni <nizhen@uniontech.com>, as discussed in
> 
> - "[PATCH] ALSA: core: Fix deadlock when shutdown a frozen userspace"
>  https://mailman.alsa-project.org/pipermail/alsa-devel/2022-November/209248.html
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: pci-tgl: unblock S5 entry if DMA stop has failed"
      commit: 2aa2a5ead0ee0a358bf80a2984a641d1bf2adc2a
[2/2] ASoC: SOF: Revert: "core: unregister clients and machine drivers in .shutdown"
      commit: 44fda61d2bcfb74a942df93959e083a4e8eff75f

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
