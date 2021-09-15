Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277DFC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:25:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5127860F5B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5127860F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA192185B;
	Wed, 15 Sep 2021 17:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA192185B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631719500;
	bh=hYM/NKbgpLHVOai31dObwTbz9HfkGYUYeERzVv/RnrA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C4pNHHHJnArjg6A7w+Kv0fRAoJM156bzK7bNuPGLo8tQ8keewRJD+PRz7POTSWLyu
	 7QFhFg0JRP2PxuB3jZzV/3o6B/9rYR/l/7I2dVeE9GN44C4rtvIO7mXFzmdEEb+5nG
	 KLq0mWGWlsljosnaNIJKivxv7hsb4rsrwrCj4Dpo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33A9AF804F1;
	Wed, 15 Sep 2021 17:22:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E703DF804E5; Wed, 15 Sep 2021 17:22:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BDE0F80227
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 17:22:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BDE0F80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="K6CooD4t"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9234D60F5B;
 Wed, 15 Sep 2021 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631719362;
 bh=hYM/NKbgpLHVOai31dObwTbz9HfkGYUYeERzVv/RnrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K6CooD4txBJwdU3E/Wzw1Mmq7WPyCs8iF109tipPbSLj5CDdw3TaoVoeSsFlGxWEa
 H9OKKLlARcH6qpeDGc64txIPrdEBFqfB4L1tHmkkLnnFGc54P7FwZ0DQXG6lUw6VBL
 5l9zvbJo26C3eKoYBo5DtfYi1bY/Dfk9JJnTIagL/xjHSHf86uKn3oBf+W5I3RtXtO
 cmeeCssJ5yDWgbsfRAXyTNyRChXLMIRKQ6N5okeoyim7ZOl7oWwD3HE1O/XgbTMqEY
 mlyyLolTW7Yt9GF6npU/VPOlTaYB4FWXn0z04GNG52v5W7yo2H0xBOYclLIhbs2b6r
 1dpwiPAbq4KFA==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: Remove unused members from struct
 sof_dev_desc
Date: Wed, 15 Sep 2021 16:21:45 +0100
Message-Id: <163171901944.9674.10459698385534328374.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915065541.1178-1-peter.ujfalusi@linux.intel.com>
References: <20210915065541.1178-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Mark Brown <broonie@kernel.org>, daniel.baluta@nxp.com
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

On Wed, 15 Sep 2021 09:55:39 +0300, Peter Ujfalusi wrote:
> dma_engine, dma_size and resindex_dma_base is unused from sof_dev_desc, drop
> them.
> 
> resindex_dma_base is initialized to -1 for Intel platforms, but it is not used.
> 
> Regards,
> Peter
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: intel: Do no initialize resindex_dma_base
      commit: 7e7d5ffa37e34ec2a6e8aa2e1fd846fb296fc8a1
[2/2] ASoC: SOF: Drop resindex_dma_base, dma_engine, dma_size from sof_dev_desc
      commit: 2395fea7ae7f0cf6dfd37a8bb3cd9dbcf2d0e492

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
