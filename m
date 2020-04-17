Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EBC2D0EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:58:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D16A2051A
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cwMpVFGb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj//9BtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D16A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6907C1676;
	Fri, 17 Apr 2020 20:57:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6907C1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587149919;
	bh=h/i1tps21NluIrRqKtcf7r670fm1lSMpu90bOxMtNTk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwMpVFGbP91F4t70on0QUdNoacvDIICoj2ePyhzpoIj+76n2ARBqtbxjSt+T6FnXX
	 3MguByUZOpzbDPwh6to2/dvOoI2/6QEG3Tb03XkMs4wGblgLY5ocCYTrrEgPLHrl/4
	 vTh4oGrpQTcvyLBaBAT41fEl46udW2gbA/yANbH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36D4FF8028A;
	Fri, 17 Apr 2020 20:56:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C36AF8028B; Fri, 17 Apr 2020 20:56:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 159F8F800AB
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 20:56:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 159F8F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gj//9BtM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF45A206E9;
 Fri, 17 Apr 2020 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587149774;
 bh=h/i1tps21NluIrRqKtcf7r670fm1lSMpu90bOxMtNTk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=gj//9BtMqVRZhJFGT9WjtJu+DsTl09t7krVXs5BfAuKn3N2rYhZZC16Kv9gklzOCn
 sDdMoz76mMUM1WQcIvDziG7q4iDjg7U0WDVxyw4w/SVA2HI0hms49P3lNj4O3KS7LJ
 9unJSXlRyCt0YsJbWPyYa3Qswm0oCGmigNpEOVRw=
Date: Fri, 17 Apr 2020 19:56:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200330194520.13253-1-cezary.rojewski@intel.com>
References: <20200330194520.13253-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: haswell: Power transition refactor
Message-Id: <158714977176.9539.4242966753402770264.b4-ty@kernel.org>
Cc: pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
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

On Mon, 30 Mar 2020 21:45:20 +0200, Cezary Rojewski wrote:
> Update D0 <-> D3 sequence to correctly transition hardware and DSP core
> from and to D3. On top of that, set SHIM registers to their recommended
> defaults during D0 and D3 proceduces as HW does not reset registers for
> us.
> 
> Connected to:
> [alsa-devel][BUG] bdw-rt5650 DSP boot timeout
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/153098.html
> 
> [...]

Applied, thanks!

[1/1] ASoC: Intel: haswell: Power transition refactor
      commit: 8ec7d6043263ecf250b9b7c0dd8ade899487538a

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
