Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DEDC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 16:10:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C2364DD0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 16:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C2364DD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AB971662;
	Mon, 22 Feb 2021 17:09:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AB971662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614010215;
	bh=n3N6IdcyLq//ZyjojbWT0VuSMCmzZBMWV5924CcfNY8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGJp3ewLBBbOWuJxMM/EJD14KDbur1Mo83JQ6mfnHfyIMamAzUlSuTCg2psejbOYX
	 YD30IVAbtVRRw41Ie89gXaOWGe1Mov43Fh70aC2e0fs0agKjeeSinRRyPBCRWohzn3
	 vnU+skmgz2Sc6Y9jNcSDN3Jlin/Dg3mOhP1TNNBw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC7F6F8026F;
	Mon, 22 Feb 2021 17:08:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92C0AF80279; Mon, 22 Feb 2021 17:08:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FA4FF800CE
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 17:08:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FA4FF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Jf0J6TRR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11C9364E61;
 Mon, 22 Feb 2021 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614010109;
 bh=n3N6IdcyLq//ZyjojbWT0VuSMCmzZBMWV5924CcfNY8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Jf0J6TRRUjZyBZPhEsnSDlhSEUdxjgfuJIswK0EZr3YVZuWh38nQSZekbVH3JiCJb
 +6FSXgBQPAhjnOHG1JiONd9511U0cA8JllJILdFZVrIIGtWdqn11iFnhdYqxGZrc3u
 wc8JMKTLjal9hEN9rBiHHJfQMb8RoKE3mNNz61er8mRGYcrCXJ5ZxKi8kiy4eypq8n
 lxEB1f9DX3ib+YBx93U16xZ+VijHvnInxLKeS7rn2GlqJiD9l4KiSaAqsS4Bl11Mmm
 0SQCgDJ7nb7cl8tsDTPgaw1fsZzBJXeobdrdqEUp/QXi0y34il7XMJNOoadnV/H1U3
 7jF66vzFV/aFw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: (subset) [PATCH 0/6] ASoC: samsung: remove cppcheck warnings
Message-Id: <161401004266.2538.5738460015320431431.b4-ty@kernel.org>
Date: Mon, 22 Feb 2021 16:07:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Krzysztof Kozlowski <krzk@kernel.org>
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

On Fri, 19 Feb 2021 17:09:12 -0600, Pierre-Louis Bossart wrote:
> No functional changes except for patch 2 and 3 where missing error
> checks were added for consistency.
> 
> Pierre-Louis Bossart (6):
>   ASoC: samsung: i2s: remove unassigned variable
>   ASoC: samsung: s3c24xx_simtec: add missing error check
>   ASoC: samsung: smdk_wm8994: add missing return
>   ASoC: samsung: snow: remove useless test
>   ASoC: samsung: tm2_wm5110: check of_parse return value
>   ASoC: samsung: tm2_wm5510: remove shadowing variable
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[5/6] ASoC: samsung: tm2_wm5110: check of_parse return value
      commit: 75fa6833aef349fce1b315eaa96c9611a227014b

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
