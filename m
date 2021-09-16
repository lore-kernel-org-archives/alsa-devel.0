Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E938BC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:20:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA2C6120D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BA2C6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C7F218C5;
	Thu, 16 Sep 2021 17:19:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C7F218C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805604;
	bh=S7nxMgyMrlHvlQaX48tF3XLVSgAAO84ahumvlgR0lEg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BEWC0ZwLOeoa5vZJCN5bBPKeUXoUiebV9OU8pCHs7D2MDJlWQS5pDgoorKSYkgd0X
	 qf/z/7iRlw51iRZzXUYSRGH6u5rMzZKs6QI6JyQ68tYZEmo6ReAeYage2A9pytIhMl
	 A/mgjZSxufRm6omE81RkQrOt1zUqJbazcLDqQ6MQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C700F80525;
	Thu, 16 Sep 2021 17:15:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24B5FF80526; Thu, 16 Sep 2021 17:15:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AAC9F8051D
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AAC9F8051D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pYcdTg6U"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E99F6124D;
 Thu, 16 Sep 2021 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805347;
 bh=S7nxMgyMrlHvlQaX48tF3XLVSgAAO84ahumvlgR0lEg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pYcdTg6UaoSf8TB2zBs6PPwwFkLtZ9raR5kRZlNM9glXWmnGQIh/oAKAw1N2d8Vcr
 Hu7Rytbou3zN4lbpRJOKYH3Qp2Ch5vmCr4/Nk5vBZBAkv7r7VqjnRqB0UrxVx0Ip28
 uEfnFGE3BlyEtMdEWEbudsQkdUH2dwJe557casBgtNRqIudtMA+nZlKfOjynaGfCZU
 I//K2xd5uRERYcTKk2TQLgc0vztDKKFeRbgbRNpEw7EzwJEs176FdKuNH0fEE5Rje4
 BdJEXQuGvczTuQQSVAJ9UXBUIqy+PAGJl/z5APsPfCWnEUjOC+qDUmghBDE4BhhsMV
 Llx8IxBLLtD6w==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, marc.herbert@intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: SOF: loader: release_firmware() on load failure to
 avoid batching
Date: Thu, 16 Sep 2021 16:14:39 +0100
Message-Id: <163180495857.19842.17556613481379062480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916085008.28929-1-peter.ujfalusi@linux.intel.com>
References: <20210916085008.28929-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

On Thu, 16 Sep 2021 11:50:08 +0300, Peter Ujfalusi wrote:
> From: Marc Herbert <marc.herbert@intel.com>
> 
> Invoke release_firmware() when the firmware fails to boot in
> sof_probe_continue().
> 
> The request_firmware() framework must be informed of failures in
> sof_probe_continue() otherwise its internal "batching"
> feature (different from caching) cached the firmware image
> forever. Attempts to correct the file in /lib/firmware/ were then
> silently and confusingly ignored until the next reboot. Unloading the
> drivers did not help because from their disconnected perspective the
> firmware had failed so there was nothing to release.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: loader: release_firmware() on load failure to avoid batching
      commit: 8a8e1813ffc35111fc0b6db49968ceb0e1615ced

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
