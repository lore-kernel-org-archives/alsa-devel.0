Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D7C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 00:58:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C4964E99
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 00:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C4964E99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 661C21AC2;
	Thu,  4 Mar 2021 01:57:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 661C21AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819520;
	bh=YJWWyYkbMUlSYywtTgwbl+tKtWV4UlFelgfbuakB3GI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uZnl5JTzwws3SutzEPG0qV8MxRV55AxDzAfXpUgz04xR96uAma1zcluX3D1yrkQTv
	 6gqyyXyYy7E2c9Ibo6KefGIbewju1nmX9D81uxtpYHJVx1wmDPhlKZSiihpiArPfAo
	 WBhZ6nYOmLTo6YBgEnnDgRHAdXdr4WKvWw6lyhdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2CD0F804B0;
	Thu,  4 Mar 2021 01:55:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF5FFF804B1; Thu,  4 Mar 2021 01:55:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E071F804AD
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:55:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E071F804AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Gq1Q+shu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 661D064E99;
 Thu,  4 Mar 2021 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819342;
 bh=YJWWyYkbMUlSYywtTgwbl+tKtWV4UlFelgfbuakB3GI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Gq1Q+shuBnygGT0zQWeCjKyhI/uW01nGIXDAd/xkuIw6Cj1dQvuV7M7SqTeaPZ0rb
 NNsllc0eYlqG9j7d37PFrK6HN0D9By73X8PFfHImmk8+Z4+2XlAJIy0oCoSxvj3aVY
 R0cmacoxy5o7Sf+JRUHxktTeZ9Mhg34Syjn51QvM5jonpp4VG+ii7Fz7vjunfdxSFs
 cc1yNySFx/0ghLJC7yhlU5uDhQY3JWXWHqgd/CXddefzMjYvBtdNfWRZg6bJ3jYrnE
 fO1+uTlrTfXOXa1hqfq1eDWqoe8WtJOsch/qcnSlILjm6LlYJJ88UqBqryi6VWuuQ/
 9PKBaO/K8AZZQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210302003410.1178535-1-pierre-louis.bossart@linux.intel.com>
References: <20210302003410.1178535-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: unregister DMIC device on probe error
Message-Id: <161481924069.9553.2178928363251636626.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

On Mon, 1 Mar 2021 18:34:10 -0600, Pierre-Louis Bossart wrote:
> We only unregister the platform device during the .remove operation,
> but if the probe fails we will never reach this sequence.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: unregister DMIC device on probe error
      commit: 290c323008db6e3a44d981a46b56f7f166979a04

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
