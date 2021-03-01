Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25950C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:43:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFA8600CD
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFA8600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FFDD169A;
	Tue,  2 Mar 2021 00:42:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FFDD169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614642201;
	bh=ee8F+2qtecALKXsHqBVpaFJBcACBRvTrOmpti/qYvXA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gkhRlgitszLwx75xQQoOwyAvzvAmSAKlGVK7so7UP9cv1QrySKz5I/fJUSHTM+ysO
	 oZ40tlCHmWWHb2y46F+dBllpMBTOHreeE64dLe4dHJ8l2q4jXfljcxAq6HnMFF9Mfp
	 FWZ6FMKRh29DhN75GxK5zHN0zjEx4nJI9vQrhDBA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14800F80519;
	Tue,  2 Mar 2021 00:37:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAB33F8051A; Tue,  2 Mar 2021 00:37:18 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79B36F80272
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 00:37:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79B36F80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q8e74QRY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E8461490;
 Mon,  1 Mar 2021 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641834;
 bh=ee8F+2qtecALKXsHqBVpaFJBcACBRvTrOmpti/qYvXA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Q8e74QRYLJGluQ8/AgQ88NCNIvn4YA+bPK5+dlr4P0lwhcVRrVGnZtYCNDyQw4FkV
 ieWiYuo2GSA5VwQK5N8G8vXJBdqR2b6CSJvqAXnWfe69PxD+ZPBtxRzOWlzwuYKrpD
 F1QojJlo7mIZydEhK8q2LqIzcgzs49UllzwMuf+2/i03100xqTcsuAf+SCMBBcpIMJ
 6DurPiaCuaj/n+ymJA8kg0EALk4hSuJg4Gp5w5rg+k84s0rLAMwKjuXgc/26JMq3RW
 t57NqP3+YMLkQVdMSTKVnLkN2Ln9bRAZZgeMZOcjHrE2Kd2YlXdxgs9s+2Ln83RtA2
 JxcYKeE+N7IVg==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210218221921.88991-1-pierre-louis.bossart@linux.intel.com>
References: <20210218221921.88991-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC: core: remove cppcheck warnings
Message-Id: <161464168096.31144.8026117442122515811.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de
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

On Thu, 18 Feb 2021 16:19:15 -0600, Pierre-Louis Bossart wrote:
> This is the first batch of cleanups to make cppcheck more usable,
> currently we have way too many warnings that drown real issues.
> 
> Pierre-Louis Bossart (6):
>   ASoC: soc-ops: remove useless assignment
>   ASoC: soc-pcm: remove redundant assignment
>   ASoC: soc-pcm: remove shadowing variable
>   ASoC: soc-pcm: add error log
>   ASoC: soc-topology: clarify expression
>   ASoC: generic: simple-card-utils: remove useless assignment
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: soc-ops: remove useless assignment
      commit: 56dc057925b112353a4d920380c537d1f96699a0
[2/6] ASoC: soc-pcm: remove redundant assignment
      commit: 8f7351ec37b52d22e77d2cab38ddd4aa920af0b4
[3/6] ASoC: soc-pcm: remove shadowing variable
      commit: 52fcd9638da0803c6fe0cfadab7af978c961be37
[4/6] ASoC: soc-pcm: add error log
      commit: 56fc1a7fd01ef0984d0272e52a9823ca11eff890
[5/6] ASoC: soc-topology: clarify expression
      commit: 761fa730a2e1e9197d89f3e9d1a13a9be165b109
[6/6] ASoC: generic: simple-card-utils: remove useless assignment
      commit: 8754b443fa7df24e357b7e707c901eefe373a05c

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
