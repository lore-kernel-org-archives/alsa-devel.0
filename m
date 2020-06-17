Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F7CC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:00:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72AA2089D
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R+PCsTlH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="idiEN6O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72AA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E3E71615;
	Wed, 17 Jun 2020 21:59:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E3E71615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592424005;
	bh=DNCwG4y0Kw5QEMGp8suxAsvaUaP9puZTO2j2ki8x3Hg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R+PCsTlHIkNl2Rf4s9Ty9FYD0S5uXhTNVPGrluxZtsw++NJaV4akVcbtfct9D1E9V
	 AME8GIHjRrhjPHDF4GpLD+yZ/3p053ZgOCt0hJHgZS3dtWkUKDdocAYr3mWmRWWmV0
	 E6g97I+BgunAHJsKI/MNboBnuVcDLZj4rnzxr5kQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3B97F80116;
	Wed, 17 Jun 2020 21:59:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9FEF7F80171; Wed, 17 Jun 2020 21:59:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4BF9F80116
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 21:59:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4BF9F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="idiEN6O0"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 99C73208B8;
 Wed, 17 Jun 2020 19:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592423947;
 bh=DNCwG4y0Kw5QEMGp8suxAsvaUaP9puZTO2j2ki8x3Hg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=idiEN6O0VGId+/5n8ZpcA8IJj22U3gjpcnQgum5h8SezhvwCSFfdTG9ZGoCtscZcR
 hkpkMR//HAmgRqbfBiNxYO5uVdpJ3Ehh47sTcd+w32upuxyhfUuXAjoXFY49PI/NoM
 Kr+DNKXvh14r3pssPyQdmP78rKrv9J5gf4g55FfY=
Date: Wed, 17 Jun 2020 20:59:04 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200617164144.17859-1-pierre-louis.bossart@linux.intel.com>
References: <20200617164144.17859-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: hdac_hda: fix memleak with regmap not freed on
 remove
Message-Id: <159242394493.17586.8615014903058308406.b4-ty@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On Wed, 17 Jun 2020 11:41:44 -0500, Pierre-Louis Bossart wrote:
> kmemleak throws error reports on module load/unload tests, add
> snd_hdac_regmap_exit() in .remove().
> 
> While we are at it, also fix the error handling flow in .probe() to
> use snd_hdac_regmap_exit() if needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdac_hda: fix memleak with regmap not freed on remove
      commit: a94eaccefea1186947c5c5451fcae2245dd7e714

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
