Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB411C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 19:03:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A434E6105A
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 19:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A434E6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCDE81614;
	Mon, 12 Apr 2021 21:02:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCDE81614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618254201;
	bh=RYIGgnMpyZjD+wdo8Y4ADPryIM+CPN8WSbFZ+mteMrI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jy49gw2R/CwogBWVbVJnHhgEQUAbGxjcz0t7Zra0ctKdqIgM5zU0sqKIAvPFPnUzo
	 EDwYuyT6nc6TlnqsqzG5mMLNnTZlT0kemJ0mRg2qJb6o/1UZ+PvSVBB2hEIsz4gzRX
	 g+RhkKr9e1SZFp2JS7AR5MFzIh132Dprxv6MZnT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 596A7F80273;
	Mon, 12 Apr 2021 21:01:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4556DF80269; Mon, 12 Apr 2021 21:01:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7877F800D3
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 21:01:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7877F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GnKtvirH"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 677E561350;
 Mon, 12 Apr 2021 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618254092;
 bh=RYIGgnMpyZjD+wdo8Y4ADPryIM+CPN8WSbFZ+mteMrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GnKtvirHXsmP4BxLlDYSHR2LynR1dAYpvMGENTLf06f0dAGd8mVkPSt0nip9d2kAQ
 agazIqymdwvhlEp6yqEdwGqhSh3DXUi+jGoQegEB3ohJDfTg7jYrif7VN28Xroe5IJ
 V93DPkHvs7Og8nloxUYhGucD9m9esH1GKDzO3QUO41CunrdqKocRDqaJ9Iuf8TZmMJ
 x9Hzrf19YPrq4aLqxV2Du7t7HAS3521iRXyaAfZUPIAlqUVz+z/aJVxo9YrtMBpsTE
 2+v0FCNkCjju2r1sTmI8HqeiBaVOs5CfV7QUpzcbArJYvlYTp7ZHV/6hMQG1OgtnI7
 N8hBduRj+fykg==
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/2] ASoC: SOF: simplify probe and report errors
Date: Mon, 12 Apr 2021 20:01:00 +0100
Message-Id: <161825392630.52100.15360826880049350043.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409220959.1543456-1-ranjani.sridharan@linux.intel.com>
References: <20210409220959.1543456-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>
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

On Fri, 9 Apr 2021 15:09:57 -0700, Ranjani Sridharan wrote:
> These patches simplify the sof_probe_complete handling and
> address reporting of errors during probe.
> 
> Peter Ujfalusi (2):
>   ASoC: SOF: core: Add missing error prints to device probe operation
>   ASoC: SOF: Simplify sof_probe_complete handling for acpi/pci/of
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: core: Add missing error prints to device probe operation
      commit: 3bcae98e101727457c727b354c95c3ea8f074dce
[2/2] ASoC: SOF: Simplify sof_probe_complete handling for acpi/pci/of
      commit: 4d1284cd795296e4aa7be6db5fdce85f31374520

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
