Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EB1C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 19:04:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBC061350
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 19:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBC061350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 953AD167D;
	Mon, 12 Apr 2021 21:03:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 953AD167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618254261;
	bh=F4gTDTpxIjl+nx0umiKmI7BvmyGY0MWoRT3gO2/gBNg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhwN1e64r7vEY+LmdbB7fNdp0jACmkWuU3ktapEMAwFfLKxW0q2ETbw//9M94LMMN
	 R80F5pgNLuvgzK5bAq/i8/hJAP7RSzZep8fPcDqJ7EJJ3uLurTxJfxCL8rP16jqEPM
	 5cLQl0LWs5NojDYBklPQBgzYR85qGYXVrbfUFQ04=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCC01F804AB;
	Mon, 12 Apr 2021 21:01:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86FABF80482; Mon, 12 Apr 2021 21:01:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B5EBF8042F
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 21:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B5EBF8042F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vt2eUtgN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDB4A61352;
 Mon, 12 Apr 2021 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618254100;
 bh=F4gTDTpxIjl+nx0umiKmI7BvmyGY0MWoRT3gO2/gBNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vt2eUtgN5c9C+kvNXZnAVST2gP5z2QBhTJvMFqBOpvafSZh5phs2vi6ODR6Vqx+dO
 2Awo4AfKqtEHpeWGPzU8aNb1TFPA+rZ4CuS9qzk0OLlBh3VsyP6RExd7Qhs1eRwVfD
 ZAD6g6hm7sykRVwjLxxtbnGbnMf4xRZh8jx4Vep5Hcq/w6bGvdjTmwaLaTPzpK6/2U
 hzFW4n5nFBjUtM6DL49WeD6Cn4+PT/XxatmPm9K+XsWi2kLqdGPCgjepmSv9UkHJ6Q
 DRv03Jfq31EdnltgOuuktaQKyL/3WSMQzJ9a3rkAjbsWRex0JaZWtlLRayT901xLBs
 Ox3gCEuQfjiew==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/2] ASoC: SOF: Intel: descriptor corrections for TGL and
 ADL
Date: Mon, 12 Apr 2021 20:01:03 +0100
Message-Id: <161825392630.52100.4693285955114573632.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210412161519.13508-1-pierre-louis.bossart@linux.intel.com>
References: <20210412161519.13508-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>
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

On Mon, 12 Apr 2021 11:15:17 -0500, Pierre-Louis Bossart wrote:
> One missed property for TigerLake and need for separate descriptors
> between ADL-S and the other flavors.
> 
> Libin Yang (1):
>   ASoC: SOF: Intel: add missing use_acpi_target_states for TGL platforms
> 
> Sathya Prakash M R (1):
>   ASoC: SOF: Intel: Update ADL P to use its own descriptor
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: add missing use_acpi_target_states for TGL platforms
      commit: 1b9889974ce93dea50d010972a93c0eb529ac612
[2/2] ASoC: SOF: Intel: Update ADL P to use its own descriptor
      commit: 4ad03f894b3c96d77e51474f0c9731793fac412e

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
