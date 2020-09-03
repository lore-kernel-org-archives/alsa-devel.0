Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E339C433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:50:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742C220826
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rqixQPA4";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2i4GX0iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742C220826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C39731746;
	Thu,  3 Sep 2020 15:50:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C39731746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599141052;
	bh=wx3edxGRbnkP+0ghqdokdIw1oQlPriAUWdZG5DLAQ+4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rqixQPA4gBoobEm82pL/7n29GySjEtTZuD6IiTnu93wIrd5ByYZPXI7mI4y34jHdA
	 jY0j+k6wPyCaJfW4kg3C6qhR1BfAKT9t7eid5hGaHwNLdQS/lgia1mHM6uchif4UWM
	 aU6iez22DIjy+Km7II9Fi27ZDcCN9VuPMzfV3Pck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90167F8021D;
	Thu,  3 Sep 2020 15:49:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9525F80217; Thu,  3 Sep 2020 15:49:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1296F800F0
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 15:49:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1296F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2i4GX0iX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6222520758;
 Thu,  3 Sep 2020 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599140941;
 bh=wx3edxGRbnkP+0ghqdokdIw1oQlPriAUWdZG5DLAQ+4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=2i4GX0iXPOGtmQ5pAwrqoBAyG80F5eBnZVCT2zJjp/ljVNd0G2yUtiQbCoIrVfjLF
 6nVEBg0M5/P0qMEMAYndtAxt7U18R4YJ+WU68ZbQp5sUVr3y4zzCc/jRkExX2Tw4Zr
 QCF09Okl9ralGJSC0y5PecV3eHAmyNfBfhyys/6s=
Date: Thu, 03 Sep 2020 14:48:20 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, tiwai@suse.com, timur@kernel.org,
 festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1599112427-22038-1-git-send-email-shengjiu.wang@nxp.com>
References: <1599112427-22038-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Message-Id: <159914089549.45733.5564781801193033736.b4-ty@kernel.org>
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

On Thu, 3 Sep 2020 13:53:47 +0800, Shengjiu Wang wrote:
> Transmit data pins will output zero when slots are masked or channels
> are disabled. In CHMOD TDM mode, transmit data pins are tri-stated when
> slots are masked or channels are disabled. When data pins are tri-stated,
> there is noise on some channels when FS clock value is high and data is
> read while fsclk is transitioning from high to low.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
      commit: f4c4b1bb2f5a7f034f039c302b56f82344a6dc8c

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
