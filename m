Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:39:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D9020706
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ibh+iZoB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjlcCYhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D9020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 699501859;
	Wed, 24 Jun 2020 17:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 699501859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593013177;
	bh=k66UnNbdyPj+LwX7I2nsf9Uvi/hIVtOAiKbZmkacQPs=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ibh+iZoB4uS3b+MF/abvjeNKFbz6fJwafwci0aBUIv6p1iAr3sWSlDUnmLsGSARws
	 ITzZXv/I8Ebm2+u8lN2xtCJ0ckeuY2VB3YBV+hqChQzGImINLTS/tk7gSJ96oZvCgK
	 4CaqJYG+amoYP5GpTj8gE5SE1QbWBqhhNU6AVHag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBE43F8015A;
	Wed, 24 Jun 2020 17:38:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96BE5F8015B; Wed, 24 Jun 2020 17:38:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79DE2F8012F
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 17:38:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79DE2F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SjlcCYhb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 738D7206FA;
 Wed, 24 Jun 2020 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593013118;
 bh=k66UnNbdyPj+LwX7I2nsf9Uvi/hIVtOAiKbZmkacQPs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=SjlcCYhbgYzIzfrM1ot62LZQoDUuGcOKV41ckwqgbdgvZsFRh3GPT84jLdJBra0lb
 zJlkt6b1uDO+GHMVO8rziQOOOcvfX5UDYws3hVF+hkjIEBtu7pamSSr8uFwNBFX1Gi
 5OrmjQYl8pc+GTzBPfWWL1Ul1ZEboAmIwOX7ZrCc=
Date: Wed, 24 Jun 2020 16:38:35 +0100
From: Mark Brown <broonie@kernel.org>
To: nicoleotsuka@gmail.com, festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com,
 timur@kernel.org, tiwai@suse.com, perex@perex.cz,
 Shengjiu Wang <shengjiu.wang@nxp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
References: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add WM8524 support
Message-Id: <159301311578.33465.8345204179048045259.b4-ty@kernel.org>
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

On Tue, 23 Jun 2020 14:52:46 +0800, Shengjiu Wang wrote:
> WM8524 only supports playback mode, and only works at
> slave mode.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Add WM8524 support
      commit: 3cd990267401fc7d0b222fc81f637e75e46967e0
[2/2] ASoC: bindings: fsl-asoc-card: Add compatible string for wm8524
      commit: 3b3372fa65bab619f99bcfe272e92fb6faa07219

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
