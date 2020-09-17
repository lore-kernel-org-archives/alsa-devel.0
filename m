Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F2C2BBD1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:00:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3778B21973
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q253OYUz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18GS+sSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3778B21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF9A6165D;
	Thu, 17 Sep 2020 20:59:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF9A6165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600369216;
	bh=u9mh+AijHpIErfNJNMJUrUaC6C9FZk2VizltieCw06o=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q253OYUzh4FFAjyZCVhFM/d7rOg8bD6SRGLbgGW6CAGNr7booy08CyoCwXSKgBJ51
	 Ak1mZcUt8L+PlByK2JDihvwdqGhnLMwV7rKXiwafBw7KZhTa1H1MRR/W4L2B6G28el
	 tQTKYEquW+JzCa9KuTFKt0WpWuCAjZn/CvsfX48Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE6E3F8027C;
	Thu, 17 Sep 2020 20:57:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74ADEF802C3; Thu, 17 Sep 2020 20:57:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C257DF8027C
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 20:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C257DF8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="18GS+sSR"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA57C2072E;
 Thu, 17 Sep 2020 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600369069;
 bh=u9mh+AijHpIErfNJNMJUrUaC6C9FZk2VizltieCw06o=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=18GS+sSRmXkfQPQoq0QI1aSD0JTO4Nn8ExBaxdDJWZEbO+AKnxDHV/GgRGLQ1zVqf
 iiprAp+e9ZUc6oHr0OTbwarnFysovMP+n8njdmlL5HAC5mj4PFHrMPNpdHKP0PqIm4
 jdLl+WcLQ8kCDw+efrXm5NUbdQZGpFYsynBRMbKU=
Date: Thu, 17 Sep 2020 19:56:59 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20200917103609.2559916-1-kai.vehmanen@linux.intel.com>
References: <20200917103609.2559916-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Add support for tgl-h
Message-Id: <160036900934.20113.13931109991929748377.b4-ty@kernel.org>
Cc: pierre-louis.bossart@linux.intel.com, Rander Wang <rander.wang@intel.com>,
 daniel.baluta@nxp.com, lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com
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

On Thu, 17 Sep 2020 13:36:09 +0300, Kai Vehmanen wrote:
> SOF will support tgl-h and tgl-lp in different FW binaries due to
> hardware difference, so create another dev_desc entry with FW name
> of sof-tgl-h.ri and dsp_desc named tglh_chip_info for tgl-h.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Add support for tgl-h
      commit: 30ee3738f849b3f4af623c20adec73cdc4573a2e

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
