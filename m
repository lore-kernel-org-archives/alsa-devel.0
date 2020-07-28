Return-Path: <SRS0=2FB+=BH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FFFC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:34:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159BB20792
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qTWqayDd";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xLGrdsjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159BB20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8895C16F0;
	Tue, 28 Jul 2020 18:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8895C16F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595954073;
	bh=qSSsk3Q4yBuE6jVV4/Jzs7DFUFhFDj7pypOHHWSyQxw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qTWqayDdYaNMk50GdFV2LKu2PvSN2rTgaxTlcsthxzFZiWDg/XJFx1BE0xbzoOhtM
	 OWOlKqfSKqiPYmVNji08AxnYGGZiztQjTN2iUH6ppMqCzzYqQ423QbFMa/4xYxmthU
	 0sfc7mYWnLZBqEwcQuhEoZ6XtHQvcQ7pCdJVCRRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D103F8029B;
	Tue, 28 Jul 2020 18:31:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DB86F802E2; Tue, 28 Jul 2020 18:31:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44A09F8029B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2020 18:31:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44A09F8029B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xLGrdsjV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 366E920809;
 Tue, 28 Jul 2020 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595953876;
 bh=qSSsk3Q4yBuE6jVV4/Jzs7DFUFhFDj7pypOHHWSyQxw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=xLGrdsjVmBBLqWdm7G+OriL+3iACj3TSiFslwAymnbWzrnlTPWCHrcygQ3VYwbgLz
 94f/VJgAEf61LkRtaTM9E6Q2/miMfqtOU9IToLtAbyIEVxVVdnc4bo0jFPdT5kRXnS
 GzllPuvyKUIpKiQp8iuTe6purwYpL/vafOLma3vw=
Date: Tue, 28 Jul 2020 17:30:58 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <20200727183613.1419005-1-ranjani.sridharan@linux.intel.com>
References: <20200727183613.1419005-1-ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/2] SOF Fixes for S0iX suspend/resume sequence
Message-Id: <159595383113.15027.6278240410973415297.b4-ty@kernel.org>
Cc: tiwai@suse.de
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

On Mon, 27 Jul 2020 11:36:11 -0700, Ranjani Sridharan wrote:
> This set of patches is required for facilitating system S0ix
> entry when the DSP is in D0I3. This first patch adds the missing
> CORB/RIRB DMA stop and restart to the suspend/resume sequence along
> with powering up/down the links. The second patch ensures that the
> FW traces are disabled when the system enters S0ix with the DSP in D0I3.
> 
> Marcin Rajwa (2):
>   ASoC: SOF: Intel: fix the suspend procedure to support s0ix entry
>   ASoC: SOF: Intel: disable traces when switching to S0Ix D0I3
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: fix the suspend procedure to support s0ix entry
      commit: 195f101980dc4c0d0093007d7daac68ec2270f95
[2/2] ASoC: SOF: Intel: disable traces when switching to S0Ix D0I3
      commit: 79560b8aeb01a715f75060e40085e641248bee51

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
