Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4045EC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 17:06:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9DA613CB
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 17:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9DA613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5691217CE;
	Wed, 12 May 2021 19:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5691217CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620839199;
	bh=uR97iHT9TbuhNgLA0XIv+lafc7LtNZqRCCX/bATyQXI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLPGt8OR7JXskXDrbWJ5SEqCIpIUz8sqsIEeqbVV7RUAXFAlNZC4DmgGKHQvYHOU9
	 gW6rTQ0qE33tymamHZ167WPbHNoIGnmJoKq0qrr9HNnMlHRnzq6B9PgyC/qgjJnvm8
	 a+q16q3BkzGnibrUr0bjpvOsKPE5ettgZUges3EM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3D62F8020C;
	Wed, 12 May 2021 19:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0993CF80240; Wed, 12 May 2021 19:05:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7ADF6F8012E
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 19:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7ADF6F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Y8Nf+/tQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 019B0613C5;
 Wed, 12 May 2021 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620839141;
 bh=uR97iHT9TbuhNgLA0XIv+lafc7LtNZqRCCX/bATyQXI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y8Nf+/tQc9Nbr79TcfA7g44QxHgGX0xoGTJV96qJY2CiHAC6nIKrY3Yx/KXlIl4N0
 hzFwT0baEKJTlK5J7pecvrl4NPWHlC8+FinZoeNYKinIY2xG4vEvL3zoZ2bEJCB/VL
 kLN30P9Gd6IZlvRO7Vl3cpAHhsquAZj94UbVyZrNXD/eMUign/HSkpLVzXFiWl4xKP
 cd8mKXRysXwUAJiSfOH1/Zfva5UFbkXRDOD0S6h6yvb7alNxZdLhAth4UAcpSrfTPK
 SlP/N6h1FQ0ZlwAJ8wVe2yzgzF+GMBBKkvk9Q3tyO8xrXk0+mQDle8cjkg/erVACYK
 rpVfCn/KHOfLA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Zou Wei <zou_wei@huawei.com>, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, perex@perex.cz
Subject: Re: [PATCH -next] ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
Date: Wed, 12 May 2021 18:04:42 +0100
Message-Id: <162083892846.44734.8935371254397073723.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620789145-14936-1-git-send-email-zou_wei@huawei.com>
References: <1620789145-14936-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Wed, 12 May 2021 11:12:25 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
      commit: e072b2671606c77538d6a4dd5dda80b508cb4816

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
