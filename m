Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EDDC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 16:08:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BC8207C9
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 16:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BC8207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D7671763;
	Mon, 28 Dec 2020 17:07:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D7671763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609171725;
	bh=wTelgUznsDhN/8fLvdTzIb6NSyVxHVAgFT4YeXQ1xz4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qkTBeGPI+vVGN/uO/lllGeXu88lD3rxotOosD57pzLGhXxwLUZ5OynLNMl3TYsX+I
	 pYLwMKnA6PyS2aRmuGwk4Su/gEJJUQXUtj/O7iVNqUppyy6y7d0qZz9u6X4ZKsz6pX
	 lMvLbirH5NehIjf7ttfiwF3Bxztku8dLFQGV/9Mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1DDBF804C3;
	Mon, 28 Dec 2020 17:07:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B97CF801ED; Mon, 28 Dec 2020 17:06:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05982F801F5
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 17:06:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05982F801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HgaeqaM1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C406D207C9;
 Mon, 28 Dec 2020 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609171598;
 bh=wTelgUznsDhN/8fLvdTzIb6NSyVxHVAgFT4YeXQ1xz4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HgaeqaM1vMoAEl+xttYy2yKFdYdweIR0fP1Drqp4Ob0qObr78j/ivXV+hVPNRG4o8
 +18/uVxm8OkpmmSPAqHmrNasLdZiKHj7E8IGQDu/1Blx9tB1Ump/qWkCRbNL7zgqZf
 CeieleugX99Jz3u+MZGbFIzqEtYs3aujgZ6n8basg1Ajvj+/ivhTINBUV/62mz1rgi
 6xZzA293ubZRG1SrhfxJlB8M+LDSIYXHzQubIR5ZWM41I+l9wXYEkSl8QNKb+boQG4
 nDn+dWhSOZqHzb/YlujJLQh3wp3EmI4xZE240z5c35ocVSkeKDPvPPhNlM63++Binv
 dzX0D6/mWFZeA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20201214172138.44267-1-andriy.shevchenko@linux.intel.com>
References: <20201214172138.44267-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] catpt: Switch to use list_entry_is_head() helper
Message-Id: <160917143257.51553.11900566987042005324.b4-ty@kernel.org>
Date: Mon, 28 Dec 2020 16:03:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
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

On Mon, 14 Dec 2020 19:21:38 +0200, Andy Shevchenko wrote:
> Since we got list_entry_is_head() helper in the generic header,
> we may switch catpt to use it. It removes the need in additional variable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] catpt: Switch to use list_entry_is_head() helper
      commit: a9830fc388817c90282925694474fae005fec990

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
