Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA59C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 18:35:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221CD6115B
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 18:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221CD6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54B701661;
	Thu, 15 Apr 2021 20:34:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54B701661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618511716;
	bh=PYa5K/9xtz9ynU04D6uakE9tOPICvr40isBXtdKn6lo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JIqu6TTdhBq8jwcijpSOFASuamZdhz/pRDxYcBKReBMUxFnC2Gh0rh9R5VlmlBZAH
	 KFAeZm7BeHIeROM7sAERNHkYdLk7AU1l5g1Qdm1q0qAPNres9AeFU87J1nJ6J2wXMi
	 Zea9J7/AIxmjqTZj/6C0jU1fm2muQf0lkmpLx3SY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC44EF8022B;
	Thu, 15 Apr 2021 20:34:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C3C6F8022B; Thu, 15 Apr 2021 20:34:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23940F800FF
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 20:34:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23940F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Mz/4KHib"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 793CB6115B;
 Thu, 15 Apr 2021 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618511659;
 bh=PYa5K/9xtz9ynU04D6uakE9tOPICvr40isBXtdKn6lo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mz/4KHib0hIiuvesUq+5QUVvCJE3h9PQkAZerKu8SQtJRfx1MdduVLKrjxP6e8VZ0
 XnLK5I5VH/Yzh+JjAvxgHYg3FNsdn0DursPfO3U5zredzQtodX9jQfG3wppn4zKHsY
 rOd/sQ6NO0AyBWXJIk4ujjVMdTkCTWTVnp9Ha4f6yhJpN9dM8h94gfW6gPJ6Ng3uEL
 bMEZ9vhgry+a8DIdREeWdkmTGyupnPdhM5liUofC/9yQPa7mHJkz3XcCCGiQN5fGQw
 jgBpVP0Rnw34O1VLa+1xl7U0zywSqLoCOBzRpBz0006XDVHxJYyjfpXfhn93J0YzTZ
 TIQkjC4vPqmHg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: use current DAI config during resume
Date: Thu, 15 Apr 2021 19:33:43 +0100
Message-Id: <161851148784.23061.9866275896209866181.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414165926.1875465-1-ranjani.sridharan@linux.intel.com>
References: <20210414165926.1875465-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Wed, 14 Apr 2021 09:59:26 -0700, Ranjani Sridharan wrote:
> Recently, the sof_pcm_dai_link_fixup() function was
> updated to match SSP config with the PCM hw_params
> and set the current_config for the DAI widget.
> 
> But the sof_restore_pipelines() function still chooses the
> default config for the DAI widget upon resuming. Fix this
> to use the last used config when setting up the DAI widget
> during resume.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: use current DAI config during resume
      commit: eea1d18e9b2d959df908746b193f66dba3078473

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
