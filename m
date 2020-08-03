Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F69C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:55:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66DA2072A
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KDqL9LTu";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq1ZBmDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66DA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 662761660;
	Mon,  3 Aug 2020 17:54:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 662761660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596470127;
	bh=mQeowY8CWoF5oCIepRkpl7Z5wCiGFjMYaay4ZC1xFKc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KDqL9LTuW4ItLLq5tbSj3V8dWE7OM58phX3tFg4X9rgAezfF29eGfdc9dIXnEK/b3
	 1WIwRqcWrKgU5iH7nlqbGistylorJcLDHDvlB4oYtY6Wm/ZFEykHl0uCmyJeDcnNS0
	 bisNfm1n7QnonnTAxeE7xqBQWmFo8xyY+rVXSPfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15749F802A2;
	Mon,  3 Aug 2020 17:53:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57145F80148; Mon,  3 Aug 2020 17:52:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D070CF80148
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 17:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D070CF80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oq1ZBmDU"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCBC12072A;
 Mon,  3 Aug 2020 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596469971;
 bh=mQeowY8CWoF5oCIepRkpl7Z5wCiGFjMYaay4ZC1xFKc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=oq1ZBmDUyZc/OPO86rY/94O3VDdxgn06WGSeZuXz5lpt74RsZIyUO1mZCQ9dUx8dm
 R+iMzBeOVcqJomoD8qVH0VRSghoZTdhLIA1qqSnoyQp/vsgNThKEFoyMqP2q+NesDi
 ANWwzVI5/CU38VBMpUPFj1OmlR1DlSufDHYCKiIs=
Date: Mon, 03 Aug 2020 16:52:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 Vijendar.Mukunda@amd.com
In-Reply-To: <20200730075020.15667-1-hui.wang@canonical.com>
References: <20200730075020.15667-1-hui.wang@canonical.com>
Subject: Re: [PATCH] ASoC: amd: renoir: restore two more registers during
 resume
Message-Id: <159646994087.2524.11753685481726603724.b4-ty@kernel.org>
Cc: stable@vger.kernel.org
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

On Thu, 30 Jul 2020 15:50:20 +0800, Hui Wang wrote:
> Recently we found an issue about the suspend and resume. If dmic is
> recording the sound, and we run suspend and resume, after the resume,
> the dmic can't work well anymore. we need to close the app and reopen
> the app, then the dmic could record the sound again.
> 
> For example, we run "arecord -D hw:CARD=acp,DEV=0 -f S32_LE -c 2
> -r 48000 test.wav", then suspend and resume, after the system resume
> back, we speak to the dmic. then stop the arecord, use aplay to play
> the test.wav, we could hear the sound recorded after resume is weird,
> it is not what we speak to the dmic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: renoir: restore two more registers during resume
      commit: ccff7bd468d5e0595176656a051ef67c01f01968

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
