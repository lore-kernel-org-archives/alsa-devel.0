Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B24C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 10:26:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A7BC1816;
	Tue, 14 Jun 2022 12:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A7BC1816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655202414;
	bh=99g8Fw9OTxxKNgdn/j7VfhLA6hv+UvRMsBMD01/lQGU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKGhNaQp1Sivniyqvcd8i+lbAk+1K0yOIr3xzQ6Emr8/UlOQvhdgiEQTAlW/agVZM
	 ZmdixifXGzme1/adXFsxeYpHlIr/o69lBmEKHJ6FyxkvKLGCrd1VKwwpvf11BZGqgk
	 7koFEQV1IQjkppWs9IKxFvrPafBIhS7Q1fc/UOL8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DDC7F80527;
	Tue, 14 Jun 2022 12:25:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 027F5F80528; Tue, 14 Jun 2022 12:25:16 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 090D3F80217
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 12:25:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 090D3F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fXfyjYnY"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9368CB8184C;
 Tue, 14 Jun 2022 10:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE77C3411E;
 Tue, 14 Jun 2022 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655202312;
 bh=99g8Fw9OTxxKNgdn/j7VfhLA6hv+UvRMsBMD01/lQGU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=fXfyjYnYl7AHJ2j63ZRJgv7gR0oF5G7JG8GbFTOexGQ3lMFYWcHCorXLTE8Hsxk3e
 /R2+Z/qN6UHRtA/QYXiFk6Q2OcTkSTC1Zy5jTiesURrbt+Sd2QhpXPpozsUjkdCUuO
 FQ8PSsa4dN1Rmcv9ZETB11jAYejH5MMln4rFlpwKuc1F0ntN1Zboj7PyGdLKZ6skwo
 4dkk1aoDJQZMbw5vJIWoEjmOHsQiPxpfDyEWKzJFnG+3LsGoYwp8/fmP9gy+xcqE3I
 KL5VT7s71Umx7d4WzgKZiTchsuLnmCG+8TXgFC0tTSuY27RvSSTndtc/bSIIyfmeMI
 3V22E8SuviEyg==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
In-Reply-To: <20220610214601.43005-1-pierre-louis.bossart@linux.intel.com>
References: <20220610214601.43005-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: reduce default verbosity of IPC logs
Message-Id: <165520231097.3607327.14936258784984745064.b4-ty@kernel.org>
Date: Tue, 14 Jun 2022 11:25:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, peter.ujfalusi@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

On Fri, 10 Jun 2022 16:46:01 -0500, Pierre-Louis Bossart wrote:
> We currently log the initiation of an IPC as well at its success.
> 
> [ 3906.106987] kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx: 0x80010000: GLB_DAI_MSG: CONFIG
> [ 3906.107189] kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx succeeded: 0x80010000: GLB_DAI_MSG: CONFIG
> 
> This is overkill in most cases, we already have a message thrown in
> case of errors and have tracepoints enabled to check for IPC
> duration. The only case where this might be useful is to check if
> there is an interleaved IPC RX. Add a flag and only print those logs
> if enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: reduce default verbosity of IPC logs
      commit: f7309dbe628d5c8653d5f3649ef05a65c9b88daf

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
