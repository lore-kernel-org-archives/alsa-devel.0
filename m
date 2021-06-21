Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81CC48BE5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:50:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BAF60FEE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BAF60FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5E0416A9;
	Mon, 21 Jun 2021 20:49:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5E0416A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624301410;
	bh=u4E7N74D5ICKc9j+WDBObEXlU0zyPpspSv6KfmMn7N0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L4Lr1Q7wHOihfo53FXVKJGoFxszBv0S+1s5LILWu8a6d3aL4Mdi9NTSS+l1zvgaFn
	 fAmzbHU6aBr+3DVZ8fbAh2MxyvDQyNhk6bSaukzPIEVdQsO1UC4FuHF34t7eI5FlAI
	 WHrn9ueoB6u7zvv/aIzAPFiV5znYSGyPuQUEs6Fo=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68886F804ED;
	Mon, 21 Jun 2021 20:47:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A9BBF804DA; Mon, 21 Jun 2021 20:47:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68884F804B0
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:47:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68884F804B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="H4F0ibZg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 848D26128A;
 Mon, 21 Jun 2021 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624301221;
 bh=u4E7N74D5ICKc9j+WDBObEXlU0zyPpspSv6KfmMn7N0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H4F0ibZgaXX6U83jHhLZTIC+Zm3XoM6mzWjO98BNqOQgt71PSWzGOjwawLckH/1cB
 r7kJhbRtCuSr0kqT2QZEgjnIUkinK0re8nNRQ4G8pFFL6lGMae/xuTXKSv8q0S3TB4
 mXxqPEJeTwZw2epe2dShvJWypBTROYodLqH4San8xzhpolWyvnLE/8e91f+7UR+yq9
 RYKFVbUqHnPjmRZRXiFpN3HUXGg86OOXUHGGJYTWg+Zv93HSzZNjt8KVCWAZmlcWZs
 GsYg6B92qITz0xeOXe6aU8YRzjgWxHw7JVuIMtruj4B9IyLWbFAfUyD1PekZKe/JmY
 tk2NNknLE4vDg==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH -next 1/2] ASoC: qcom: apq8016_sbc: Use
 devm_platform_get_and_ioremap_resource()
Date: Mon, 21 Jun 2021 19:46:00 +0100
Message-Id: <162430055263.9224.4713697107804997031.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615140711.1676704-1-yangyingliang@huawei.com>
References: <20210615140711.1676704-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
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

On Tue, 15 Jun 2021 22:07:10 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: apq8016_sbc: Use devm_platform_get_and_ioremap_resource()
      commit: e6bb518199181c9c35827a48142fbb548125d0b0
[2/2] ASoC: qcom: lpass-cpu: Use devm_platform_get_and_ioremap_resource()
      commit: 77b7bae7802848feabe37a92533bee64387906e7

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
