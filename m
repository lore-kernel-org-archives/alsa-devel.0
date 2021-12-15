Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99382C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Dec 2021 18:15:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C65081B1E;
	Wed, 15 Dec 2021 19:15:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C65081B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639592154;
	bh=GST+AMAb3vSU4zGW1JvIWTxOwUtF4/vvjLZNi9gLugI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VaNSQNci06+/6FrcAia/Ptk/Salt47tAFzXU23ot1JAm7bHnqZA474gHdE3frNbdO
	 GbMJO1ekgb4sP7L7uaMw7p5hYKtWIRcvpN+qDRS6SAxo/42Xz37UFQbyFAOvlmlJJG
	 uM7dHUsYX5uy24lcwbNFHEBHdEEP0fk5NB0pMBKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE668F80248;
	Wed, 15 Dec 2021 19:14:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E4A6F802A0; Wed, 15 Dec 2021 19:14:24 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C6A2F80248
 for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2021 19:14:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C6A2F80248
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="up9rXDJ7"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 41B9EB82056;
 Wed, 15 Dec 2021 18:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E007C36AE3;
 Wed, 15 Dec 2021 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639592053;
 bh=GST+AMAb3vSU4zGW1JvIWTxOwUtF4/vvjLZNi9gLugI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=up9rXDJ74a9oXNw9c7C8zYmVnXnlgabKaBxW/HQ7esMkaXgi+Uls65t7GiVqSLOTi
 O6oJz5fJl877rZEEaLSOf3uK4QgIkSV8T9V8If5vEnYnvJWqT2beMb/H3dcHxbenxP
 ocAVgHOu1MyyrO4gEljsph9JsxZpzWWc82XqfKylzLUiNh6odW3eFWEx22tWF6wkVk
 vhSJBE8czqImfwf80VifpA25VAfHwTVBBzL5Bu3vGvkOOewskKmz2NDnL6Fw/rWbpU
 lXz8G/yJIC1co0eDvsCf+NAFDW8bs4QTnyhmFL0OSWDI9hi+paA2NOq2Tc8nYG6rIH
 W8cPzIxJ65keQ==
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20211215085703.137414-1-daniel.baluta@oss.nxp.com>
References: <20211215085703.137414-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: OF: Avoid reverse module dependency
Message-Id: <163959205016.2218314.2741357654083575707.b4-ty@kernel.org>
Date: Wed, 15 Dec 2021 18:14:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, daniel.baluta@gmail.com, kai.vehmanen@linux.intel.com, Péter Ujfalusi <peter.ujfalusi@linux.intel.com>, ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org, peter.ujfalusi@intel.com, lgirdwood@gmail.com, linux-mediatek@lists.infradead.org, linux-imx@nxp.com, paul.olaru@oss.nxp.com, pierre-louis.bossart@linux.intel.com, Daniel Baluta <daniel.baluta@nxp.com>
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

On Wed, 15 Dec 2021 10:57:03 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Similar with commit 8a49cd11e68ed0 ("ASoC: SOF: ACPI: avoid reverse
> module dependency") we will be having hardware specific drivers that
> link against a common "helper" framework.
> 
> sof-of-dev.c becomes a library with the interface defined in the newly
> created file sof-of-dev.h.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: OF: Avoid reverse module dependency
      commit: 28084f4a0e031a87b624ea121bd8fd782b90ff2a

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
