Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50644C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 16:46:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D160B207E8
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 16:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hy2sUX4o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+4qkJjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D160B207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 255321707;
	Mon, 18 May 2020 18:45:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 255321707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589820384;
	bh=PN662x2FXq4LngDAMLKyKEfjxr8CebC7aeVbnQ+z7zY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hy2sUX4oFQUFK571nx3+H+5z5tQj9kF/+E4lOTSGDMhjOB1IGZDLCAZyLvzhBHBZM
	 g/4tk4VHnm0b+UlOqWmxIoez0CyMveRhi7gg0f15jrfgBPMsX90QzzRAHmnTbkQQ0d
	 EjDtY7FUDJFjHBaGmkVUQtYgCjqMCNAlteReslkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 218CAF802E0;
	Mon, 18 May 2020 18:41:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 922C1F802E2; Mon, 18 May 2020 18:41:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DE78F802E0
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 18:41:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DE78F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="l+4qkJjC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1555B20809;
 Mon, 18 May 2020 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589820102;
 bh=PN662x2FXq4LngDAMLKyKEfjxr8CebC7aeVbnQ+z7zY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=l+4qkJjCp67DAy+fPTZ8QNF6+A7B/bCsiTWILZTN8pJFQHsjUkRs0AS1GOSkUbWgd
 JhnzfjSQdOGdaih33NiDHyzEIk4g2+t9DatDlYVP4aU/DuP0pz88w5VzmH+tkUuV1X
 8CedUrDt+v8yTlwWClZQFbDVCEJ/vpeK5OvAXXuI=
Date: Mon, 18 May 2020 17:41:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200511132544.82364-1-sebastian.reichel@collabora.com>
References: <20200511132544.82364-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv3 0/5] ASoC: da7213: support for usage with simple-card
Message-Id: <158982005876.28736.9440768140715468375.b4-ty@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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

On Mon, 11 May 2020 15:25:39 +0200, Sebastian Reichel wrote:
> This extends the da7213 driver to be used with simple-audio-card in
> combination with a fixed clock. Here is a snippet of the downstream
> board's DT, that is supposed to be supported by this patchset.
> 
> ---------------------------------------------------------------------
> / {
> 	sound {
> 		compatible = "simple-audio-card";
> 		simple-audio-card,name = "audio-card";
> 		simple-audio-card,format = "i2s";
> 		simple-audio-card,bitclock-master = <&dailink_master>;
> 		simple-audio-card,frame-master = <&dailink_master>;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/5] ASoC: da7213: Add da7212 DT compatible
      commit: 95579eaf98f17b97dc174bb31d71902b5895bd85
[2/5] ASoC: da7213: Add regulator support
      commit: b2a378816d0f6780a5500f4322e5b2542d41532d
[3/5] ASoC: da7213: move set_sysclk to codec level
      commit: 9c5c258438b23cacc4971b94d808ba8af9c5931c
[4/5] ASoC: da7213: move set_pll to codec level
      commit: f7a8ae295ca8e96e287f497506b49b1f4b47deb4
[5/5] ASoC: da7213: add default clock handling
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
