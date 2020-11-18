Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF3C63697
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 21:01:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7602075B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 21:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dSAERA3N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP1wxYlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7602075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17A061718;
	Wed, 18 Nov 2020 22:00:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17A061718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605733280;
	bh=DgN0ueKPhlpMnl248+5X9YV07WLhR3E+i+hScOY+X6Y=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dSAERA3Nw17eebhuVEq/Mlw7+yQp7gRrZK4NhKpZYT3O2ZixW2m1EQ0mWKJic0EVl
	 h5WWYTBqV1W1pYJU2ArOUAOKI2d+IFp7RXCOAzRscOPC9bsMClvO+HMbfEPng8wuZv
	 RbET3XtBpxMI/UpzMkMdce5MXSsmy0xk7THYVBlk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97857F804B4;
	Wed, 18 Nov 2020 21:59:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74968F8016C; Wed, 18 Nov 2020 21:59:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3172AF8016C
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 21:59:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3172AF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nP1wxYlM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A2882075B;
 Wed, 18 Nov 2020 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605733164;
 bh=DgN0ueKPhlpMnl248+5X9YV07WLhR3E+i+hScOY+X6Y=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=nP1wxYlM3ubihD8EhQ8o6vyWu9XK1ue1Kjlof6nAzW0M5rQo8q9k9ARfhPJvyV0vF
 kUH+yLL3EpuMEoq5pla8h6dCSxn4S+Zz6Z4GhgxfU89UzKWajT1Lb8riBrMyLIvdCh
 RtZjD8dWQis4uLZLrLjmNXa87C9AMhgo7XeVFnRA=
Date: Wed, 18 Nov 2020 20:59:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Kyle Russell <bkylerussell@gmail.com>
In-Reply-To: <20201106145905.365903-1-bkylerussell@gmail.com>
References: <20201106145905.365903-1-bkylerussell@gmail.com>
Subject: Re: [PATCH] ASoC: mmp-sspa: clear transmit phase bit for non-stereo
 formats
Message-Id: <160573314460.46437.15997412834070266670.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, lkundrak@v3.sk,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
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

On Fri, 6 Nov 2020 09:59:05 -0500, Kyle Russell wrote:
> The transmit phase register value is never cleared during hw params.
> So once hw params sets this bit to handle a two channel format, it
> remains configured for dual-phase, which is not desirable for mono
> playback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: clear transmit phase bit for non-stereo formats
      commit: b88b31f4fa0abcd698045362d4aefcddc50cba59

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
