Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C3C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:39:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76FE20715
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r3PlgHOm";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVvtbHHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76FE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1C78173B;
	Tue, 17 Nov 2020 23:38:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1C78173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605652738;
	bh=Mtz9tEmVoqD4BFiEPcLYBQ3rkMPTjLGFyqnatHxG7oo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3PlgHOmZ42YptuHzZEaKsLqlqHRn1kvDzX+S4Jk1/evE2n/H4y9MA9o8ZFQGm44O
	 sDycQK9Gab/w//LLYsoDNTcrl47LmEprBodhwl3DfofCnhc4dOlkXBjidQabHIlaL0
	 ZCn4pHZX7k3IFFbHh8SFg7fWhF4sjMLWz7VCg4G0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D033F801ED;
	Tue, 17 Nov 2020 23:38:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47E36F801F9; Tue, 17 Nov 2020 23:38:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0AA1F800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 23:37:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0AA1F800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OVvtbHHk"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E05C1206E0;
 Tue, 17 Nov 2020 22:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605652676;
 bh=Mtz9tEmVoqD4BFiEPcLYBQ3rkMPTjLGFyqnatHxG7oo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=OVvtbHHk6tPrHyUE+ie1iMjBcVh8oXsJiWDXXN9WG2bH54rfXjCLUbe28cOr9gEah
 sSsCIAUOIIomo3S8ZY7eCQcAGFbh6RxtZjVVi4PBQ191BayTtuIvaGN6tIuxWD6B7l
 pzKhhR6nrohBm0QGjUvvhejCLUKbK1sPxmhvrWxQ=
Date: Tue, 17 Nov 2020 22:37:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20201110145120.3280658-1-geert+renesas@glider.be>
References: <20201110145120.3280658-1-geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: fsl: SND_SOC_FSL_AUD2HTX should depend on ARCH_MXC
Message-Id: <160565265703.23689.12029405282658577742.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 10 Nov 2020 15:51:20 +0100, Geert Uytterhoeven wrote:
> The Freescale/NXP AUDIO TO HDMI TX module is only present on NXP i.MX 8
> Series SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the
> user about this driver when configuring a kernel without i.MX 8 platform
> support.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: SND_SOC_FSL_AUD2HTX should depend on ARCH_MXC
      commit: 674226db62ec758c4575bcdb933a2410f1a29bbf

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
