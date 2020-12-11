Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B3C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:53:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B2323EF5
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B2323EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 966241755;
	Fri, 11 Dec 2020 18:52:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 966241755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607709198;
	bh=ewUDRPTEhwuO/K2gYeplP9h+hY4gCPNb/vErM50OTP0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UEMdcqLk01TDG09TCLER4uKW4MCWcYBT3DviODiS+Qw4ZLppWPHoWbuDyqwoRwz2E
	 BuIkE80J+rdzls/yEkf8ck1T8AzREPM77e1vkrp1s4ext+iVc/rGIwwA6QEdRyal8l
	 VE1OCTkaqrZ7vXdkEkxsd9XoSZJSxyErj8L69rWU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDCAEF804E5;
	Fri, 11 Dec 2020 18:50:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FBA8F804E7; Fri, 11 Dec 2020 18:50:18 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9A41F804E2
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 18:50:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9A41F804E2
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20201211100743.3188821-1-kai.vehmanen@linux.intel.com>
References: <20201211100743.3188821-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: SOF: Intel: fix to dsp state dump trace levels
Message-Id: <160770898112.26354.12482471552908120200.b4-ty@kernel.org>
Date: Fri, 11 Dec 2020 17:49:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com
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

On Fri, 11 Dec 2020 12:07:40 +0200, Kai Vehmanen wrote:
> Small series that addresses a problem where DSP status dump
> for a failure case, ends up being printed as as debug print. This
> is important information for any bug report. While at it, the series
> contains a few cleanups to related code.
> 
> Ranjani Sridharan (3):
>   ASoC: SOF: Intel: hda: remove duplicated status dump
>   ASoC: SOF: modify the SOF_DBG flags
>   ASoC: SOF: Intel: hda: fix the condition passed to sof_dev_dbg_or_err
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: Intel: hda: remove duplicated status dump
      commit: b278fc55b47739da49ea7f95e6ad58d436091ba2
[2/3] ASoC: SOF: modify the SOF_DBG flags
      commit: fbfa22ec4b2b8a1bb1a52c56c376295c7b7e7849
[3/3] ASoC: SOF: Intel: hda: fix the condition passed to sof_dev_dbg_or_err
      commit: 8f7ef6fca0317fb217d1eef8f30010d7a9c6ae0e

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
