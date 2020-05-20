Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DDC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 17:18:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C4D2070A
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 17:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iwKMiEO1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ynn89FV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A7E817CE;
	Wed, 20 May 2020 19:17:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A7E817CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589995094;
	bh=yHlEbQ436cPIfFD1oyX4yafwtT/b8QhDnXnebWNb7uI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iwKMiEO17EJ4boinqXN2KF4PJAIUy2X2W0VNj46kfTG5C/a3YC1Tp+svgeHZSO4Gm
	 aqPCd41FtQUmJnyekkK56FbVFz/92I2ILpdI/Kxf/Qm25WX6BRjQpqKsNyiygMSzPt
	 icxzkUqVVB/H0lZXPWCq7Avi9i2RCVp/4SeTm6h4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA0B1F801DA;
	Wed, 20 May 2020 19:17:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 341C4F801F9; Wed, 20 May 2020 19:17:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 615EEF80132
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 19:17:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 615EEF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ynn89FV/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB8642070A;
 Wed, 20 May 2020 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589995036;
 bh=yHlEbQ436cPIfFD1oyX4yafwtT/b8QhDnXnebWNb7uI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ynn89FV//DJviWXl6X8oOoC21Q7k+6hWKM1eZBYrz4keTcj42CUPLWUe56fw5A/2G
 J6Z92s/1dy/WlzVZPc+/jW/CIiejOpM40IUHOa90ZxrDtjddVZN9hCn16vuDbcD8Ps
 CkDE5/BD6CRQXP7RfRyBngvDqT9P8ZGR6bpNbNZY=
Date: Wed, 20 May 2020 18:17:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
In-Reply-To: <20200520083516.2120802-1-lkundrak@v3.sk>
References: <20200520083516.2120802-1-lkundrak@v3.sk>
Subject: Re: [PATCH] ASoC: mmp-sspa: Fix the error handling in probe()
Message-Id: <158999503367.4807.15705967670453692304.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Wed, 20 May 2020 10:35:16 +0200, Lubomir Rintel wrote:
> If we fail after pm_runtime_enable(), we fail to undo it. Same with
> clk_prepare_enable(). Let's order them after all things that can fail.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: Fix the error handling in probe()
      commit: 6ea460d52299f7febd408f2710d7c43ce505bc2c

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
