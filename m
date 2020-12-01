Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5467AC64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 14:00:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2704920857
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iHEAD0tS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+hGtYCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2704920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1E4017C5;
	Tue,  1 Dec 2020 14:59:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1E4017C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606831222;
	bh=9spJdPsaWRsuEQTtX75tfih8iQl2lDNEKtlnATfa8Lg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHEAD0tSGptydDkJJoBj5pgsso9mJ7OESgYeIF6OobjcBHaqsO3ZmZcJf8m/2C5uj
	 0mfyPfGABAIdFZ3pWG4zzCxzN2KymPyHE5HZy7LctmQP0cwcbJmT0cSUI+3YxsJh7g
	 nbfnBun1/fYaDsvaWbPCQLl/9QEb4TNom1OTlZm0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E0E4F80254;
	Tue,  1 Dec 2020 14:58:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3925AF80276; Tue,  1 Dec 2020 14:58:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B815EF8016C
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 14:58:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B815EF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="E+hGtYCU"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9384E2086A;
 Tue,  1 Dec 2020 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606831116;
 bh=9spJdPsaWRsuEQTtX75tfih8iQl2lDNEKtlnATfa8Lg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=E+hGtYCUDKwgMxd0PJds+It9B87EmMqYuXSoq63m4ItpQwJWbWMEPnWAcMk/+zucW
 wlDK+ZyZHNbFDOF8xFOw3OrARjld8LUTUR/KNJfgNf3eE36vZ1Rima7+RDgupeE6xM
 Rs1Uy2Dw1c+XD4flSJ/rzygom85DY26QQvNkC6AU=
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de
In-Reply-To: <20201109135543.7862-1-yung-chuan.liao@linux.intel.com>
References: <20201109135543.7862-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [RFC] ASoC: max98373: don't access volatile registers in bias
 level off
Message-Id: <160683107675.35139.2203434126118347345.b4-ty@kernel.org>
Date: Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ryans.lee@maximintegrated.com,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 vkoul@kernel.org, bard.liao@intel.com
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

On Mon, 9 Nov 2020 21:55:43 +0800, Bard Liao wrote:
> We will set regcache_cache_only true in suspend. As a result, regmap_read
> will return error when we try to read volatile registers in suspend.
> Besides, it doesn't make sense to read feedback data when codec is not
> active. To avoid the regmap_read error, this patch try to return a fake
> value when kcontrol _get is called in suspend.
> However, the question is what is the "correct" behavior when we try to
> read a volatile register when cache only is set.
> 1. return an error code to signal codec is not available as what we have
> now.
> 2. return a fake value like what this patch do.
> 3. wake-up the codec and always return a valid value.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98373: don't access volatile registers in bias level off
      (no commit info)

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
