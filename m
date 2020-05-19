Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B5C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 13:20:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7BA204EA
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 13:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f/4un/5D";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3AETOYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7BA204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26C701759;
	Tue, 19 May 2020 15:20:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26C701759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589894456;
	bh=hwnc+pETKW2P49pTYiBu1BdKPYzSno5joXxdfed7aAQ=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/4un/5DpX5yXaN+q8tKl+ppXT7kt6NUrSjMiwEvcyBZ/JP+fecIa2Qmki3DuviKW
	 2eRyn23v726fEpQw3QSInmnWnb6cTXxaWcxOESbgAm9pOXZ/1NJH4Xyvb7KKdDneJ0
	 mIwQzOU3rsARS8vr7xj9QeexiMeHf0XnGMncPlow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47953F801F8;
	Tue, 19 May 2020 15:19:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7AB1F80256; Tue, 19 May 2020 15:19:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE424F801A3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 15:19:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE424F801A3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j3AETOYZ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3D182081A;
 Tue, 19 May 2020 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589894351;
 bh=hwnc+pETKW2P49pTYiBu1BdKPYzSno5joXxdfed7aAQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=j3AETOYZhNGv8kPo/p5+Rtr+ezXpTWcobb7uXHBJoPur52ArRAyLM/g5c6HyOKk/z
 sFpN+yOhnA3dR01H/shJHFOF9guBkmEGIFWgf3QS7WwMWYXNwmdAOjWduHqT7FIzLn
 SdnERwis3k+CSEDhN5ZD9iThmUfejxDFhDqRSdek=
Date: Tue, 19 May 2020 14:19:08 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, alsa-devel@alsa-project.org,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
In-Reply-To: <20200518171704.24999-1-Vijendar.Mukunda@amd.com>
References: <20200518171704.24999-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH v3 00/14] Add Renoir ACP driver
Message-Id: <158989434292.51282.3020457929402487885.b4-ty@kernel.org>
Cc: Alexander.Deucher@amd.com
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

On Tue, 19 May 2020 01:16:50 +0800, Vijendar Mukunda wrote:
> This adds an ASoC driver for the ACP (Audio CoProcessor)
> block on AMD Renoir APUs.
> 
> V3:
> - Changed PCI driver PM runtime sequence
> - Removed redundant code in Renoir machine driver
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[01/14] ASoC: amd: add Renoir ACP3x IP register header
        commit: 9b5e98e21467cd0a6c689db5ef971d7a61c73929
[02/14] ASoC: amd: add Renoir ACP PCI driver
        commit: 1eb2852efe05abfa94cd78cc9865389643726ee9
[03/14] ASoC: amd: add acp init/de-init functions
        commit: 85ded495640e63282aa83583ab64304a9912303d
[04/14] ASoC: amd: create acp3x pdm platform device
        commit: 66c4f558aa3a1b6f2b90981c364173af2f3d2c33
[05/14] ASoC: amd: add ACP3x PDM platform driver
        commit: f621a3676d3f52fcb8b7d8db8acbcc28423bcdb7
[06/14] ASoC: amd: irq handler changes for ACP3x PDM dma driver
        commit: b9901654a90a367a74c34c76e0c8b4156bf539af
[07/14] ASoC: amd: add acp3x pdm driver dma ops
        commit: 4a767b1d039a855c491c4853013804323c06f728
[08/14] ASoC: amd: add ACP PDM DMA driver dai ops
        commit: 370e7dde5b3d71820e142b566683306940daeffe
[09/14] ASoC: amd: add Renoir ACP PCI driver PM ops
        commit: c346e768f92cd6dbed474adf2f5eb3c9763a8bfa
[10/14] ASoC: amd: add ACP PDM DMA driver pm ops
        commit: 35e4be1136e69710ffe559d173c9d66ff7d32730
[11/14] ASoC: amd: enable Renoir acp3x drivers build
        commit: c15f258e6791e62c57d340c961de89261e48dc0a
[12/14] ASoC: amd: create platform devices for Renoir
        commit: b208c3bc33542ab5a689f9b7a5f6ffc1a3da2944
[13/14] ASoC: amd: RN machine driver using dmic
        commit: 7ca448a518cf40e161051f0fb69f550a1a636324
[14/14] ASoC: amd: enable build for RN machine driver
        commit: 1d3776669323e71b00c99a178317fc46edbd09bb

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
