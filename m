Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D239C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:31:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F7E21532
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HVBN15uw";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xScVLiM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F7E21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9C461614;
	Wed, 17 Jun 2020 15:30:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9C461614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592400703;
	bh=yqPhqEFGOGGnf8tKs0A9o2GYo4CEG0qvZht6TK9uQRk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HVBN15uwikP7s57ohoKIUzQEQDBGtUnjZSgxeDZxkScHkL5GHTN5mQ1pd/5sZyd+6
	 YeewLBjQl2VF7M64xj5zv50mImOvlNMOu31MpdiEPGGFn+ls8N9b3fg77bFnICS0gT
	 jM4S9T22VPYLLXrYX80cKsHx3DxIhpzdiO+Vn5k4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26BB9F80101;
	Wed, 17 Jun 2020 15:30:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAD75F801D9; Wed, 17 Jun 2020 15:30:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D104FF80116
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 15:30:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D104FF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xScVLiM4"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F26DD2080D;
 Wed, 17 Jun 2020 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592400645;
 bh=yqPhqEFGOGGnf8tKs0A9o2GYo4CEG0qvZht6TK9uQRk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=xScVLiM4utiA2ijBBxaLGjDzdmBjZPDtyufiTw9HFMGHgIjPQluNDgj2DFGvw+pYo
 N8nxi/imPtpCa7rZp+UhzFPRJ5WLLYGglf8qZBwDPSj1IApRb4QfEm+xJoHTuAnbRT
 MQBOSJFe6KPMaImD7l+tKBDnU2IWxM+KrQ1FgZQE=
Date: Wed, 17 Jun 2020 14:30:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, devicetree@vger.kernel.org,
 festevam@gmail.com, timur@kernel.org, perex@perex.cz
In-Reply-To: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592376770.git.shengjiu.wang@nxp.com>
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592376770.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: bindings: fsl_spdif: Add new compatible
 string for imx6sx
Message-Id: <159240063808.19287.10407096002593271687.b4-ty@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Wed, 17 Jun 2020 14:58:00 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx6sx-spdif" in the binding document.
> And add compatible string "fsl,vf610-spdif" which was missed before.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: fsl_spdif: Add new compatible string for imx6sx
      commit: 632108afda6aa1d380e05f1eaa25463047fd00b3
[2/2] ASoC: fsl_spdif: Add support for imx6sx platform
      commit: f61b9273c347980f570d1f9cecb867a7835c613d

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
