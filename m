Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A02DC43334
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jun 2022 13:45:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC907169D;
	Thu, 30 Jun 2022 15:44:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC907169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656596733;
	bh=wnmXGjTygS47QXWEc8FN6W73CmVcZAxDxUD7fj5Ykr0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G1p5ps4WS3/uGUKyEYGNNgTiK16gTv5wkBIExmyoum50/ExX1WgOPVCQIMPm5c9Cw
	 WVF57piTmfyJsFQq2lBfgPHKs4DzhISNh3+Jm+TFuluL49eNaKFSQfgttkEs9KzX8T
	 GqfZKkiSgx0CPIT1/N526CWF3Uw8UR1pwCG1eVU0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45BACF804D2;
	Thu, 30 Jun 2022 15:44:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 094CEF804D8; Thu, 30 Jun 2022 15:44:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA00DF800F5
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2022 15:44:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA00DF800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FzL5xVZI"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 90E1961FC5;
 Thu, 30 Jun 2022 13:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8F1C341CE;
 Thu, 30 Jun 2022 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656596676;
 bh=wnmXGjTygS47QXWEc8FN6W73CmVcZAxDxUD7fj5Ykr0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=FzL5xVZIEwkttkQhaG96wxMj0g3WeQtsGXuu9vJ/07CufdloF6mm7RggXtAQbwlpS
 ed9M8xckErWWobjsI+Rh8c0jbfRplebA/bes/uk6LKn9zWjAIFQ4f4V6As4NBMu0W3
 PZbRnRcSHcVjQGG8/12TflaA0SrdLc45QMtmfyoaO58mEg3Sa1uFEhgs2YEWH4ZKI/
 QkkHGVpiP+/jN6Enj/WUwGE46lGUnVUKY5aQ9bdd9vmuDoDlgLZa1KOep2PPxXYmQv
 6bHUQa/E2PAN2gmWPAR2x/sz6uK5hvjxahnURaAS7LRZxilghXkmsWeiObmYzkqaou
 AjIJg2SsYwoNA==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, lgirdwood@gmail.com, linmq006@gmail.com,
 dan.carpenter@oracle.com, tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
 srinivas.kandagatla@linaro.org, niejianglei2021@163.com
In-Reply-To: <20220629182520.2164409-1-niejianglei2021@163.com>
References: <20220629182520.2164409-1-niejianglei2021@163.com>
Subject: Re: [PATCH] ASoC: qdsp6: fix potential memory leak in
 q6apm_get_audioreach_graph()
Message-Id: <165659667394.558624.13159284559869782249.b4-ty@kernel.org>
Date: Thu, 30 Jun 2022 14:44:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Thu, 30 Jun 2022 02:25:20 +0800, Jianglei Nie wrote:
> q6apm_get_audioreach_graph() allocates a memory chunk for graph->graph
> with audioreach_alloc_graph_pkt(). When idr_alloc() fails, graph->graph
> is not released, which will lead to a memory leak.
> 
> We can release the graph->graph with kfree() when idr_alloc() fails to
> fix the memory leak.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: fix potential memory leak in q6apm_get_audioreach_graph()
      commit: 0063ae55ccd2ade509be828762addcfccee52c4c

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
