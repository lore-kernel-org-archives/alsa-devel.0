Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2722C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:31:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A752236F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FokMr2vw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC2NCRQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A752236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D92901708;
	Fri, 20 Nov 2020 22:30:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D92901708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605907871;
	bh=SIwPyXFAJOKpZYR+49+ogfv8MIu+ApLDZCx05NIzIAI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FokMr2vwJle2tV860CwS67NFf+2YvO35gRlfCDoT9GdvXNHq/jBqxRa+MwCSowwrW
	 RRJkyjVv3Jcs7hgfS/Xa+pv7YR+SrnQhiKypVJb4atw6QMFKkE1QNBr8oFlof0ZPsI
	 tE2QrHgAlGnuMq2bYRrgciS6ZwZucdf763wMOs/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70566F80258;
	Fri, 20 Nov 2020 22:29:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEF5FF8016E; Fri, 20 Nov 2020 22:29:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD090F800C5
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 22:29:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD090F800C5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lC2NCRQE"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 09D7F2240A;
 Fri, 20 Nov 2020 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605907758;
 bh=SIwPyXFAJOKpZYR+49+ogfv8MIu+ApLDZCx05NIzIAI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=lC2NCRQEDqOLWWzXWkcH1B2rOjFNNs3huDHoPWH4FdC89nmtk/xSxvcdqBfRoiI+y
 dWbCIznqhtsn0c6ohacFwgmB60S31HVx3HLQMHJ7UW3ejnqVPAbNM0bk0LJFYEqVXi
 e3M31XjaQHvjpy1LwMJQFHoFngBXSEAahewpp4sc=
Date: Fri, 20 Nov 2020 21:28:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20201120141653.2160134-1-kai.vehmanen@linux.intel.com>
References: <20201120141653.2160134-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: nocodec: modify DAI link definitions
Message-Id: <160590773743.47461.8532171065460752507.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com
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

On Fri, 20 Nov 2020 16:16:53 +0200, Kai Vehmanen wrote:
> The ignore_machine field in the component driver is used to
> ignore the FE DAI links defined in the machine driver,
> override BE fixups and set the stream names for the
> DAI links defined in the machine driver. This is required
> to make SOF compatible with the legacy machine drivers.
> 
> In the case of the nocodec machine driver in SOF, there is
> no need to rely upon this ignore_machine logic in the core.
> Modify the machine driver to set DAI link stream names and the
> BE hw_params_fixup callback appropriately.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: nocodec: modify DAI link definitions
      commit: f805e7e09c8f6d56f3e9bd2e7cec729f9d0855d0

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
