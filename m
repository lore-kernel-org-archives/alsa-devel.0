Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C04C43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:55:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00FE206BE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k/Aku6XK";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHEYHty1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00FE206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57EAA16A3;
	Mon, 14 Sep 2020 16:54:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57EAA16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600095323;
	bh=0Rdhj23dSlc9B+I6Z1sKv+n1S1msaVOGFY5Rifck8UY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/Aku6XK7wvMC0x+d1H16ggbe/uLzq+kmfWcmRjvSnHCTFIaBtw6LNhIAeCvkE2uF
	 u/eOcyqBlbBwrCt0g7PIiJTJxCcCfVOAe+aq12ecYTlotSMdP6PBoEuHFqu4DeG8xH
	 78pDuCdF5fFktv8gBa2MbCm3z1dyToE/fe/iNypI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24A01F802DF;
	Mon, 14 Sep 2020 16:52:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC29AF802E2; Mon, 14 Sep 2020 16:52:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15924F802DD
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 16:52:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15924F802DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fHEYHty1"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24C3320829;
 Mon, 14 Sep 2020 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600095133;
 bh=0Rdhj23dSlc9B+I6Z1sKv+n1S1msaVOGFY5Rifck8UY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=fHEYHty1PVdcEQnikpPvfiPNka9hST336BpqbxHDCMnUueClin5G5K5kX2SKqMrj8
 jsuZ/zPMJHvowVIOH3/2O/2zvMvRtCaCuFp+uzqWxLkRq9yBg4vxOJSLZ1QQR3jVmA
 /cQV/jesqMRC/2qgYMcibLfSSnzrVbtumNbPSyU0=
Date: Mon, 14 Sep 2020 15:51:25 +0100
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200911024833.1673961-1-tzungbi@google.com>
References: <20200911024833.1673961-1-tzungbi@google.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: mt8183-da7219: support machine driver
 for rt1015p
Message-Id: <160009506912.439.1847050038899323133.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
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

On Fri, 11 Sep 2020 10:48:31 +0800, Tzung-Bi Shih wrote:
> The series reuses mt8183-da7219-max98357.c for supporting machine
> driver with rt1015p speaker amplifier.
> 
> The 1st patch adds document for the new proposed compatible string.
> 
> The 2nd patch changes the machine driver to support "RT1015P" codec.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: mt8183-da7219: add compatible string for using rt1015p
      commit: 5d1e0557520862c3a73b8b6a809807be1b522c3f
[2/2] ASoC: mediatek: mt8183-da7219: support machine driver with rt1015p
      commit: 7e5bfdddd8772011a2d38cf6be821d616db6cf8c

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
