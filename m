Return-Path: <SRS0=et8u=MM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969FCC07E9B
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 18:50:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1EE610A7
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 18:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1EE610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63F6716BB;
	Tue, 20 Jul 2021 20:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63F6716BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626807054;
	bh=ZgNgco34g0cjFukJMoXeTAIC0r9NhF6dPTG608EQ+00=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JFU34iRTBQ6srAG4k5MpAydUGxu1Mhzfsc/5T8OonO0VI5HOwpxUYpY+uiXUQN21m
	 34yiT48m/yUugz0V7me9mt/vWXovv//ZOyCWJHbQ4+RHz3J8ynOsQEBN1GJ71eQvxo
	 fA3Fg3UKv9XHt0FifKROydYrlePIwCZpmj3ijkfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03B80F804EB;
	Tue, 20 Jul 2021 20:48:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA319F804FB; Tue, 20 Jul 2021 20:48:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ABE1F804F1
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 20:48:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2ABE1F804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qHS0oXdj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BEEE610CC;
 Tue, 20 Jul 2021 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626806908;
 bh=ZgNgco34g0cjFukJMoXeTAIC0r9NhF6dPTG608EQ+00=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qHS0oXdj9YTwOcw7hZup4YWAKxbdnJheL6wvKwJZarUgjDg4fF9GAFWo9s+1l+yJs
 An3b95aFALXTMYiJGQ86tLyNfsdNzQvDr1nTDoCXB7v9/WeVh8hl+pYOVk5qTk/JrX
 RHGYTaocGQUW9/RJaZVQWZgvtxDovAJg2jWF91RYWE/XcCjSDeqzjHJFf8c9lCJJSa
 aCqCQo99HDu2GREv4yc3pPVCbw13LUmBxWc/FO+4BmiCcKBdI6JkP4yHzqW7/DUVfN
 E/2bL2fRumUjzDy/szhGbCG+1tqtW26BPYiPwJNEuzmWSFyVUIQkQbkDLLTfWYYph5
 LdFk7ZjO3lhwA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: (subset) [PATCH 0/2] ASoC/soundwire: add quirks for Intel 'Bishop
 County' NUC M15
Date: Tue, 20 Jul 2021 19:48:18 +0100
Message-Id: <162680637204.10901.1832612641882359435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719233248.557923-1-pierre-louis.bossart@linux.intel.com>
References: <20210719233248.557923-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, vkoul@kernel.org,
 Mark Brown <broonie@kernel.org>, Bard liao <yung-chuan.liao@linux.intel.com>
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

On Mon, 19 Jul 2021 18:32:46 -0500, Pierre-Louis Bossart wrote:
> The 'Bishop County' NUC Laptops designed by Intel rely on SoundWire
> peripherals. Quirks are required on the soundwire/ side to work-around
> ACPI issues (bad _ADR) and sound/soc/ side for jack detection.
> 
> The two patches are independent and can be merged in the two subsystem
> independently if desired. Both patches are however required in any
> backport.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASOC: Intel: sof_sdw: add quirk for Intel 'Bishop County' NUC M15
      commit: 1bd80ff2cfb38582e258baf681211a21d448984f

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
