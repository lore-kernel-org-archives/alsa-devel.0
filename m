Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A67C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:18:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958F561248
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 958F561248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC77018A0;
	Thu, 16 Sep 2021 17:17:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC77018A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805485;
	bh=4QLwaC785TfYOOli3D95AGvqg+miqEkr3Vod9miFKCg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrArrvrRjaFcmAG3XzGgkCvt5WeDwZ/kFyqk3vFYY1SL01whKXKiAxLikV8xgLsSO
	 lwR8K25+sViVYGcUA6rRBDEyX6Vvtyx2z6QZgQp19y7ObmcCtP4Cwre3Zbe0m/tQzU
	 kAN1QCVYfpwLagFuNMB7cmXiNfbsRgGdTjvKv+gw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC08AF804F1;
	Thu, 16 Sep 2021 17:15:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E333F804E6; Thu, 16 Sep 2021 17:15:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A18DFF804B0
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A18DFF804B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="R2I6djcB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0166261248;
 Thu, 16 Sep 2021 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805328;
 bh=4QLwaC785TfYOOli3D95AGvqg+miqEkr3Vod9miFKCg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R2I6djcBlWxTjQGzUV6lQX/5Xa9OefD1WHbvn/RXeYIZD6rt9CbM37Fj4z7BB7or1
 Lp9cWSB/Of4VRxAd4+btG9w9krGqIHxw6jV1ohYbg6DkVp98hAGIBadGCWT/5H9NRI
 4u4u7d/dZF9uKY4kcbGHt/4L9gaMHWc3hQ5wQKBoVz2kVawL6teMTfX0JDa2XIUSSi
 SadXQV4I0Uh4Tf4N7FDpI0NcIhHnxyaCaw6PV2KCVNlAmCSOiU96P549zJ3OUMmtD/
 BhX61WyQUHgb8RGlyAux8Hkgf09rkYICxpBpHI6Nr0BD9kw4lDWbpMiwxz5pvseHZa
 dAQfUi40rTTGA==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: loader: Re-phrase the missing firmware error
 to avoid duplication
Date: Thu, 16 Sep 2021 16:14:32 +0100
Message-Id: <163180495856.19842.10376911229287728676.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916085342.29993-1-peter.ujfalusi@linux.intel.com>
References: <20210916085342.29993-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 daniel.baluta@nxp.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

On Thu, 16 Sep 2021 11:53:42 +0300, Peter Ujfalusi wrote:
> In case the firmware is missing we will have the following in the kernel
> log:
> 
> 1 | Direct firmware load for intel/sof/sof-tgl-h.ri failed with error -2
> 2 | error: request firmware intel/sof/sof-tgl-h.ri failed err: -2
> 3 | you may need to download the firmware from https://github.com/thesofproject/sof-bin/
> 4 | error: failed to load DSP firmware -2
> 5 | error: sof_probe_work failed err: -2
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: loader: Re-phrase the missing firmware error to avoid duplication
      commit: 25766ee44ff8db4cdf8471b587dffb28b7b9d17f

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
