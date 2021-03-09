Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC756C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:10:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5230864D74
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5230864D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBAEB1887;
	Tue,  9 Mar 2021 20:09:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBAEB1887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615317021;
	bh=5LFeXwxT2ezSl9hx8CP3wbU4WsjUdtBM6kZreWIPWnM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8PfIBcd1PxE85Ni9cU7MLfF3oleMCJMwuLHvQDMLj5A2GfNa97daA3hOM4PRWePh
	 tbt5eHZl/CUv5XjtZ20GB9bWRK3WHdUNum6B9pKvNieKXww4wZ/e0aG3ugnnanCJ/N
	 4DBw4fzq9Km+hV6+YXZNQkYS+OG1ImnA5KlkMYM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08B72F8042F;
	Tue,  9 Mar 2021 20:08:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55C61F8042F; Tue,  9 Mar 2021 20:08:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 459D3F8032D
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 20:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 459D3F8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sRA5VoJJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28CA96523F;
 Tue,  9 Mar 2021 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615316878;
 bh=5LFeXwxT2ezSl9hx8CP3wbU4WsjUdtBM6kZreWIPWnM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=sRA5VoJJmcFpl1R9Mfva2aHpI0XdmMPwB2WdvbDzQn9EAXMUJo/pDUiRkSoQQf6Rw
 Xu2eiagNeJuMaysWjrKxzNfm1VxQc1v79AaV4ti6Y73r7RJbioD6kulCo/hGs059Ef
 kbhG7XXkLNXibnbW/qrsIU081om6OGIOLOAMNA8vXR2BskbvD0gIs+ofURaMYysqG1
 nIOFp+a1PtXGtIuEw6IVp3pxlpR1ZoEeLXAHeUvw3Gq++zm1GPZK0wSFMCGzXrAl2B
 LRng35lCe2Lu/p6Q3r3hNHIPUPN4RntsP6ijcV/KFFP+msD+7QlzO/jYA7mx+Ok9rk
 AOH6xMlfy0MnQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210309004127.4940-1-pierre-louis.bossart@linux.intel.com>
References: <20210309004127.4940-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: intel: fix wrong poll bits in dsp power down
Message-Id: <161531678410.49117.8807899905412695011.b4-ty@kernel.org>
Date: Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>
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

On Mon, 8 Mar 2021 18:41:27 -0600, Pierre-Louis Bossart wrote:
> The ADSPCS_SPA is Set Power Active bit. To check if DSP is powered
> down, we need to check ADSPCS_CPA, the Current Power Active bit.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: intel: fix wrong poll bits in dsp power down
      commit: e3a1a31b8ec0cdd2c6483e342fcb5ee46167853a

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
