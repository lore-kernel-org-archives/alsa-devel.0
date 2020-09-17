Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064AFC433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:58:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834A7221EE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bfyk43Dr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtb3BzL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834A7221EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEF541676;
	Thu, 17 Sep 2020 20:57:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEF541676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600369116;
	bh=1Nm5DuMtr1PlxTTNs8gMFv0c8l9FhJlPgFCI/Q8itOU=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfyk43DrdP9Xa5ExRm/R7Ajw/Sr3uH7Y/46V8Poq2Nu+vX4tpY42LtuXTJk/m6U/c
	 Z+M+QRVUrSsC7YIe0qU4ftgHNkZSReq6oHeJ+SxAxJSQf9G3+oKVJTyZGj5lU+0+f5
	 F+5ZXW8dtZOa9XImYPXXOJX52gKq/2l4muZ2HNGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7871BF801EC;
	Thu, 17 Sep 2020 20:57:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8CCBF8025E; Thu, 17 Sep 2020 20:57:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B176EF801EC
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 20:57:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B176EF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vtb3BzL7"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A83D9221E3;
 Thu, 17 Sep 2020 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600369059;
 bh=1Nm5DuMtr1PlxTTNs8gMFv0c8l9FhJlPgFCI/Q8itOU=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Vtb3BzL7FS2QeWVT1yDylx8bPI5y/AHz7JEJ/koaMLfltNt5MdKLLUvdrydjMBqQn
 t63AecMVIazXh/+m8X4oXM7NQhPPsSq+mswHd5Dep1cxkgCAO+CjGa86njE1vtCUnX
 hicha6sdZzwXAwgdd9bjGMwPS3rpxYL59v1Z3ofM=
Date: Thu, 17 Sep 2020 19:56:49 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20200917103912.2565907-1-kai.vehmanen@linux.intel.com>
References: <20200917103912.2565907-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: disable size checks for bytes_ext
 controls if needed
Message-Id: <160036900933.20113.2386576080734363523.b4-ty@kernel.org>
Cc: Jaska Uimonen <jaska.uimonen@intel.com>, Takashi Iwai <tiwai@suse.de>,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Thu, 17 Sep 2020 13:39:12 +0300, Kai Vehmanen wrote:
> When CONFIG_SND_CTL_VALIDATION is set, accesses to extended bytes
> control generate spurious error messages when the size exceeds 512
> bytes, such as
> 
> [ 11.224223] sof_sdw sof_sdw: control 2:0:0:EQIIR5.0 eqiir_coef_5:0:
> invalid count 1024
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: disable size checks for bytes_ext controls if needed
      commit: 6788fc1a66a0c1d1cec7a0f84f94b517eae8611c

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
