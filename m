Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D3C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:49:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A796B610CB
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A796B610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BCC3168C;
	Mon, 12 Jul 2021 12:48:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BCC3168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626086973;
	bh=rRB64sjiBKQruseT1bEUVq+5wupC8VMPtoVNxCyIyEI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQ4ERczjOjIDeoq5DX1ujX4rN5OyeXm6MsD8iLPC8Wz98Pa2GxEy+UapsA/m/vs7Y
	 yxeeeKQUw1g0gfdSA/eHjjgnTFGDIx2/cNnmLJNKU1pFjD7O9fyqAGm7PiiNtR+7Bn
	 opppsV5ou+RzlrwQR1KTAkFcHBHWpocdyfUDof6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EA72F800EB;
	Mon, 12 Jul 2021 12:47:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7360CF80254; Mon, 12 Jul 2021 12:47:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 071C1F80253
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 12:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 071C1F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CqaBZWa8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C36CA610CD;
 Mon, 12 Jul 2021 10:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626086860;
 bh=rRB64sjiBKQruseT1bEUVq+5wupC8VMPtoVNxCyIyEI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CqaBZWa8B/RzkMpNzg2pUREb4m99FHCCi+BgPzMI3gBp7KIaEjQDI15R967JPVHZN
 fy6kfNvy7u+HGV+NdZZ0jhyLagk87O22kRz7sj/RJx4ODORvj4HkdyVC3nqOCu0mip
 3628geIVhUvowjNSywPgGajW8aWQHlNc9x+pX30XdnKSAZBXH4IPeRqKp6ZnL1oSpV
 Pklg2fgfMCsbiyl3JnJP12QWxKO/qzXzWWA/OeE7XqUGFYHqFx63I6F0Ro24NCbYrO
 Y2EXbVByywveXqyWiYwTKLBoHezzRGwAIgnBQ44siYYghnsaIIRsJPZn/DhpJM146M
 7DNM2DtMMeqTA==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] arm64: tegra: Enable audio IOMMU support
 on Tegra194
Date: Mon, 12 Jul 2021 11:45:57 +0100
Message-Id: <162608623153.3192.16025207604600677942.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708103432.1690385-1-thierry.reding@gmail.com>
References: <20210708103432.1690385-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sameer Pujar <spujar@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 linux-tegra@vger.kernel.org
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

On Thu, 8 Jul 2021 12:34:30 +0200, Thierry Reding wrote:
> This small series addresses a minor issue with how IOMMU support is
> wired up on various Tegra generations. Currently the virtual "card"
> device is used to allocate DMA memory for, but since that device does
> not actually exist, the path to memory cannot be correctly described.
> 
> To address this, this series moves to using the ADMAIF as the DMA device
> for audio. This is a real device that can have a proper DMA mask set and
> with which a stream ID can be associated with in the SMMU. The memory
> accesses technically originate from the ADMA controller (that the ADMAIF
> uses), but DMA channel are dynamically allocated at runtime while DMA
> memory is allocated at driver load time, drivers won't have access to
> the ADMA device yet.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tegra: Use ADMAIF component for DMA allocations
      commit: 0dfc21c1a4cac321749a53c92da616d9546d00e3

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
