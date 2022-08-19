Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A54C28D13
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Aug 2022 22:49:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5186B1679;
	Sat, 20 Aug 2022 00:48:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5186B1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660949363;
	bh=T2ZIY+4uZ7FtlXL26qIP7vtXP3FByMTOuhwzDgOCdlM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vAbOlOstPUusaDyb8rHiHB90Djsqv5zICfCPq6Clz3TG4L4EBVNo/P2bc7TCwGN5E
	 54JMWrtmBz/yXk8I/pM9rpzNEstbIefjvSGM3CA8dV8CTMgwG9FLB7iCwyiJeRhrNb
	 u/1tqBtscj3du1XSwf1KvM0nElrluJqTPzG1eX0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A75BF8051D;
	Sat, 20 Aug 2022 00:47:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55277F804AA; Sat, 20 Aug 2022 00:47:44 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA0D4F802A0
 for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2022 00:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA0D4F802A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T3tGisiX"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0EA30B82979;
 Fri, 19 Aug 2022 22:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7AAC433D7;
 Fri, 19 Aug 2022 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660949259;
 bh=T2ZIY+4uZ7FtlXL26qIP7vtXP3FByMTOuhwzDgOCdlM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=T3tGisiXjhDAPfJeYTTCWjlgvPt5eplr5dVivhuV+unKd/nTVWlXBBpKocKpjkpWu
 Un6iuen5du6PXW0//lXn2yalqVRBFagPUE9pRDaXnGMlGM9Yv6GfCmxqbS/riE5jRo
 OZ8fOU2SEmSCmC8IQHsydZPFvDNa/kNT7CvOnuj0uM7tBN5/9NG4QJCG+8TE6TjG51
 wnv2LK0IbsPJ03uQRAJ3rmnMK0+GGIbIZvTd3ngQD9SC5HfkhDQUhv2d0PtiVq/4oK
 Pw7wH+wHIvkkJm4CyRY5qfl89z457MfkbTJh30bKbvuYGiBQMNaFjJ5pu8S4gqDFpI
 DlFdrLABjlkrA==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20220819073758.1273160-1-yangyingliang@huawei.com>
References: <20220819073758.1273160-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/3] ASoC: amd: acp: add missing
 platform_device_unregister() in acp_pci_probe()
Message-Id: <166094925849.19151.6188249886261583368.b4-ty@kernel.org>
Date: Fri, 19 Aug 2022 23:47:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: venkataprasad.potturu@amd.com, Vijendar.Mukunda@amd.com
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

On Fri, 19 Aug 2022 15:37:56 +0800, Yang Yingliang wrote:
> Add missing platform_device_unregister() in error path in acp_pci_probe().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: add missing platform_device_unregister() in acp_pci_probe()
      commit: 6a4ce20fd776d2fd19ffaf85cf34a53761e2c888
[2/3] ASoC: amd: acp: switch to use dev_err_probe()
      commit: f89a8c5bb3489e43ff87b5f91acc8db66a168e8e
[3/3] ASoC: amd: acp: add a label to make error path more clean
      commit: fd8ec75207588f85c622ee49e5f32267d2406d92

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
