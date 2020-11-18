Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B069FC56201
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 21:02:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80392467A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 21:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JGDxOdVO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFxbt0lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80392467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CBE41726;
	Wed, 18 Nov 2020 22:02:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CBE41726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605733373;
	bh=5RWprzbLMs7k/C/+Hx17rkH3m12bB2Ubej9hmxGTPB4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGDxOdVOkMDlwWKJ0ML8e7gatezFJUXeg1SNQuGPktxpX4A88L5FcIgJRwkKUOswV
	 7ngFujgVeKawFYAfoFtDeSUJBNJuyPn6cOn9Arv7buisMebdb7VE+56r72cUniBCQc
	 YxSKMdH0De9eetN2a1qWdZTwLXJT7zD6YeyzfU8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE902F804E4;
	Wed, 18 Nov 2020 21:59:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EA64F804E5; Wed, 18 Nov 2020 21:59:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C811F804E2
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 21:59:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C811F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JFxbt0lh"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 799DD2467A;
 Wed, 18 Nov 2020 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605733187;
 bh=5RWprzbLMs7k/C/+Hx17rkH3m12bB2Ubej9hmxGTPB4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=JFxbt0lhqE33VJBveTFiwSaBwhb8YYUTKo5ZW7bgSTdJkAzGj7LP0U8gFPYzoqQ3i
 /P+oKZ/nB+Zxx6gpQFMuVwEm25fUFDIRHCT7ABKpoTTinJJCTaN/G8jsETTBQdsWVm
 +41x/hQ/1vIrwgYtKg/qa6g8/eU/+xs63Q3W0ZNw=
Date: Wed, 18 Nov 2020 20:59:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20201111205434.207610-1-linux@roeck-us.net>
References: <20201111205434.207610-1-linux@roeck-us.net>
Subject: Re: [PATCH] ASOC: Intel: kbl_rt5663_rt5514_max98927: Do not try to
 disable disabled clock
Message-Id: <160573314460.46437.5129841375589244492.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Curtis Malainey <cujomalainey@chromium.org>, Brent Lu <brent.lu@intel.com>
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

On Wed, 11 Nov 2020 12:54:34 -0800, Guenter Roeck wrote:
> In kabylake_set_bias_level(), enabling mclk may fail if the clock has
> already been enabled by the firmware. Attempts to disable that clock
> later will fail with a warning backtrace.
> 
> mclk already disabled
> WARNING: CPU: 2 PID: 108 at drivers/clk/clk.c:952 clk_core_disable+0x1b6/0x1cf
> ...
> Call Trace:
>  clk_disable+0x2d/0x3a
>  kabylake_set_bias_level+0x72/0xfd [snd_soc_kbl_rt5663_rt5514_max98927]
>  snd_soc_card_set_bias_level+0x2b/0x6f
>  snd_soc_dapm_set_bias_level+0xe1/0x209
>  dapm_pre_sequence_async+0x63/0x96
>  async_run_entry_fn+0x3d/0xd1
>  process_one_work+0x2a9/0x526
> ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASOC: Intel: kbl_rt5663_rt5514_max98927: Do not try to disable disabled clock
      commit: 879ee8b6f2bae0cc4a25536f8841db1dbc969523

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
