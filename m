Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A7C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:02:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7989E206FB
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HaqBQdkR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmq2Q4GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7989E206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 848891794;
	Wed, 23 Sep 2020 21:01:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 848891794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600887739;
	bh=tTgpbuHqphH8gDOT55yTuud4yYT4Y2Ub9P91maO1ALs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaqBQdkRFPGf1ZM7FUIbx45gD3Z2hiUgOMfxueJo1izS9WGcB38nwelOEaXU/kpl2
	 QKANui6qw0Kdt8adNw3YcVKluwRRK7U8Pp0rZMS2Fh1RN0e7Al13OEaoHUkth2qUF4
	 eXv/psCJi8VjjdJa1ftp498WIWkF/dRAebbndcEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9345F80162;
	Wed, 23 Sep 2020 21:01:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 850D4F801EC; Wed, 23 Sep 2020 21:01:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47335F8010A
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 21:01:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47335F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Nmq2Q4GU"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C90AB206FB;
 Wed, 23 Sep 2020 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600887673;
 bh=tTgpbuHqphH8gDOT55yTuud4yYT4Y2Ub9P91maO1ALs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Nmq2Q4GU+BGP11Zq+67R41jaw4tQ5E+UZQeQPQVEVGwy5+X0qMnq43zsaLpfRo2Y7
 cDCPGvN3Hvk9He6N5fo5R68uk7a91BeXqd5oA01wdsBdt8tGAv/0a6gUeGBaZpufVw
 MU66MANFRR4smXZu/F3mL3HHrRkWhTxIBTpU2M7w=
Date: Wed, 23 Sep 2020 20:00:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200923072939.3100468-1-kai.vehmanen@linux.intel.com>
References: <20200923072939.3100468-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hda_dsp_common: use static function in
 conditional block
Message-Id: <160088761879.35939.9765842507672115316.b4-ty@kernel.org>
Cc: lgirdwood@gmail.com, Jaska Uimonen <jaska.uimonen@intel.com>,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
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

On Wed, 23 Sep 2020 10:29:39 +0300, Kai Vehmanen wrote:
> cppcheck reports the following warning:
> 
> sound/soc/intel/boards/hda_dsp_common.c:17:0: style: The function
> 'hda_dsp_hdmi_pcm_handle' is never used. [unusedFunction]
> 
> Fix by moving to static inside compilation block.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: hda_dsp_common: use static function in conditional block
      commit: a3f18f82a2baf7b4fe434b96ad644a541e6c8c12

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
