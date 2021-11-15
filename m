Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D7C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:38:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FB261AA9
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0FB261AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDED616A6;
	Tue, 16 Nov 2021 00:37:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDED616A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019529;
	bh=dNbrA5B4b4+Ag9RO7dz3zsWBu6pH2mX1Z0iPeM2m728=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aEaGcFdet/pH1rtf/tRrP3g4/Bxx7qkqb/iEsdshE9tfomWiPfE/NvSPYL1vjY0tw
	 yzoI0h/T9mjMiqE0BuccXQKXuS1MoEXQV2JiDGPxgEAkJqMM7levbCqF9gkd51XIPd
	 j5RmAS+BV04VJuB92nId3/M0MwoiKLrG7btTBfTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2813F80519;
	Tue, 16 Nov 2021 00:35:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94E45F80506; Tue, 16 Nov 2021 00:35:19 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01A52F804EC
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:35:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01A52F804EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uq1lwOsY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8055663259;
 Mon, 15 Nov 2021 23:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019313;
 bh=dNbrA5B4b4+Ag9RO7dz3zsWBu6pH2mX1Z0iPeM2m728=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=uq1lwOsYHobSBucnRjy5gceiucdb4P2mGgvCC+sUBHLHxUCsL3Z0pg4KxXhSGpgZQ
 KRRtm0dCl6qV6aEGUeEoO0vv1/QGRvl/XPjDQTaRna9EOhQG7dUeRJ3bvdIrAzmEex
 FfPZT8PV5sfBfGKsAS4zWojUucqzjzZ1AF3QlBe2dZuumBifV/DnpJLAnoqE+dyvpK
 l1zLnbP3JS3cbHVAzvC4Xs0wQJEYOFN7IiSxj7oyMscuyOMWRiajb/35OsBjqoNxL3
 9BTt5R4XKGRfyZuCFXdzZAzrjHOGmpfEzc27M0++mTkdINwHOsUA7b66JRw23hYxXr
 NH0Bm0+oVhcSg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Mac Chiang <mac.chiang@intel.com>
In-Reply-To: <20211109133808.8729-1-mac.chiang@intel.com>
References: <20211109133808.8729-1-mac.chiang@intel.com>
Subject: Re: [PATCH] [RESEND,v2] ASoC: Intel: add sof-nau8825 machine driver
Message-Id: <163701931125.675370.7511732416848901928.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:35:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, CTLIN0@nuvoton.com, bard.liao@intel.com,
 sathya.prakash.m.r@intel.com, vamshi.krishna.gopal@intel.com
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

On Tue, 9 Nov 2021 08:38:08 -0500, Mac Chiang wrote:
> The machine driver is a generic machine driver for SOF with nau8825
> codec w or w/o speaker additionally. Depending on the SOC
> HDMI, DMIC, Bluetooth offload support are added dynamically.
> 
> Only add information related to SOF since the machine driver was
> only tested with SOF.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: add sof-nau8825 machine driver
      commit: 8d0872f6239f9d067d538d8368bdec643bb0d255

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
