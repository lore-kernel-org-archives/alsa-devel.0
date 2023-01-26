Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE87C52D11
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 17:11:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA1C1EA0;
	Thu, 26 Jan 2023 18:10:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA1C1EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674753109;
	bh=jTbGFoPfo25hRqx1ZCzHGIrxhtUHBDBBhH41wY0atkg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QAbzshMUnXng0w8KOkl27O6BJMmwXn52Upv4AbSZeyjwPH/Cf6bBil3aso1YSzXt7
	 vaKiyHITOzUsEmI5X5TBSgHIs50LZeZqsFUw28zcTZWGHU8kVF/CzbXMiQQ6RKple5
	 +Fv50x0ddoH3/+3TCqeIfxKdKEycY71MJUmJtlRA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8753F80553;
	Thu, 26 Jan 2023 18:10:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE07CF80557; Thu, 26 Jan 2023 18:10:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C13ADF80552
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 18:09:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C13ADF80552
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y0DdeS0s
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E043B618D1;
 Thu, 26 Jan 2023 17:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9C8C4339C;
 Thu, 26 Jan 2023 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674752997;
 bh=jTbGFoPfo25hRqx1ZCzHGIrxhtUHBDBBhH41wY0atkg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Y0DdeS0sGiG6hy/rfdlWk04WuQrxmzJ7Jn0bZU2t7fGDGeb9UaezNyJcIGXs+POqX
 wikkES5aUX9CJgtSHQZ0XWgmYH6rJRjtoi1CCSyu5sBPahHREwgPr22FI5wL3JJoyD
 NEmnSaxwfHYJ6QNyJeFDyGpzpgO5t99AD7c3L0Z00txQ3NeeuhdjS3CrOKGM8KlrxO
 nNwtZQyWpk7U0xSXzhg3v0S+0w/5Xrl4UuM79AMADPwHBJir7uJPxFyXBXYSYKEd0h
 k6G4Xy8eLaUSgiuzxeGg1x9kDLphUaXJONc/RnZ1OWg6nSZcLV6hfht55LEugwSvU9
 INvziIFO2geXQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230126110637.25542-1-peter.ujfalusi@linux.intel.com>
References: <20230126110637.25542-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: add buffer type support
Message-Id: <167475299515.4003145.12026179635725917344.b4-ty@kernel.org>
Date: Thu, 26 Jan 2023 17:09:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 rander.wang@intel.com, yung-chuan.liao@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 26 Jan 2023 13:06:37 +0200, Peter Ujfalusi wrote:
> The corresponding IPC4 module of snd_soc_dapm_buffer widget is module
> -to-module copier.
> The module-to-module copier is a buffer-like component with demuxing
> capabilities.
> Rename the host_token_list to common_copier_token_list since it will
> be used by host copier and module-to-module copier.
> The setup callback is almost the same as sof_ipc4_widget_setup_pcm except
> the gtw_cfg data, and the free callback is exactly the same as
> sof_ipc4_widget_free_comp_pcm. To reduce the duplication, the commit
> reuses the setup and free callbacks.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: add buffer type support
      commit: 7d573425d87642539480929e0172ad9a1917aced

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

