Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71795C4741F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:48:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7737B20759
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sdkkb75w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdSTbykM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7737B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE2F7169D;
	Thu,  5 Nov 2020 17:48:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE2F7169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604594933;
	bh=j9FHyAv+xNEEldf9CJ3rqWwa6WWbWLo2tOG5ZLBmics=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdkkb75we6xtslxZOksdt/VibkA9M9DJpGFw61rHf5L/pf6Bf1KFcu5tA5xjU7ki5
	 4RiprHkZvr5/h4/I0WchIS5YCkotAHQAZn5kwmqv41QSAMNQEecMumWSKLyRi+tdwp
	 k1DWhcQ51Le4nLCC/7fsxXm2C3K39NKa+A60qyyM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FFB9F804D8;
	Thu,  5 Nov 2020 17:46:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F733F804CB; Thu,  5 Nov 2020 17:46:02 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A45F1F804C3
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 17:45:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A45F1F804C3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jdSTbykM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 01FB022201;
 Thu,  5 Nov 2020 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604594757;
 bh=j9FHyAv+xNEEldf9CJ3rqWwa6WWbWLo2tOG5ZLBmics=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=jdSTbykM1rIMtCgBVH5LUPTLAGOeqeD7XEGdeYhkcSeLrD2nxKOh/0zO++FNd3rze
 Gws7IrWPd+UYA9vlQoORck2NyrFWWLGJpyx515liQpM08YfBcDsnOWb4yEW3xuJgnu
 GcheAy+uU40Et2y2EjpfVdq2Ts/zAsvA33XrcZTg=
Date: Thu, 05 Nov 2020 16:45:46 +0000
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, Xu Wang <vulab@iscas.ac.cn>, alsa-devel@alsa-project.org,
 tiwai@suse.com, s.nawrocki@samsung.com, lgirdwood@gmail.com
In-Reply-To: <20201029084137.28771-1-vulab@iscas.ac.cn>
References: <20201029084137.28771-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: samsung: i2s: Remove redundant null check before
 clk_disable_unprepare
Message-Id: <160459472200.54851.15787192690355908693.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 29 Oct 2020 08:41:37 +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: i2s: Remove redundant null check before clk_disable_unprepare
      commit: ec4177c83456b9e84d796ed0bc7656fd922937cb

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
