Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEADC48BC2
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:49:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47CF61107
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CF61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A12B16B6;
	Mon, 21 Jun 2021 20:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A12B16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624301359;
	bh=VT8jjUiO3DASVpwIemns7UpacAV+opD53af/FKpn/Xw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0/FSMGRDi+d0bzB8n8EvGEl9juOBYEZTILy2c0/IrDQtULJKiyYhZ/T4mQ4GTwaG
	 +NoIfaUm+3XU/i45+Lga+No5Dyq4cQvTWCQwHcHQkPOtMAw7HXY+CLQq4Ai8L2ykFS
	 IUhS69cFpc8RMp9bpsZJfzqs6AwnhDE+KxhJO0tI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EE3BF804D9;
	Mon, 21 Jun 2021 20:47:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92830F804B0; Mon, 21 Jun 2021 20:47:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1FA1F8016D
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1FA1F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="H3z4XWyB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 340C261107;
 Mon, 21 Jun 2021 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624301217;
 bh=VT8jjUiO3DASVpwIemns7UpacAV+opD53af/FKpn/Xw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H3z4XWyBxOm/dlbGHRS3F+pNprVp1oFTb2un2UstPuDejQdlAL0PxO5uspdKS6Fsf
 T2M3UUut19kemJI9IMiak79ELrnm7c15IYEg7vZKt4at/HTAe/kjkmjRG52jAdXMT7
 dmR9KB35tkU4pJDaZ+nNG3hdNKq0Y86xNOdraNh7JtJxYCGp4THAXayUsnluG+FuCG
 pnsNbAREKpfmJKYZyiEnb3Rd6YBxq+3/enAgn9VfXy5lO6O3GkYf6qNZy7K4vtr19/
 QYMnAMQX/wei61w0KzcYMhDb6HY9SbbIaHl/R7l/SiJL48fYJNDkGEfU0Yi1ottBuz
 FU4nNlNjUhN1A==
From: Mark Brown <broonie@kernel.org>
To: linux-sunxi@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH -next 0/3] ASoC: sunxi: Use
 devm_platform_get_and_ioremap_resource()
Date: Mon, 21 Jun 2021 19:45:59 +0100
Message-Id: <162430055263.9224.277778628672275964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617045012.1119650-1-yangyingliang@huawei.com>
References: <20210617045012.1119650-1-yangyingliang@huawei.com>
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

On Thu, 17 Jun 2021 12:50:09 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Yang Yingliang (3):
>   ASoC: sunxi: sun4i-codec: Use devm_platform_get_and_ioremap_resource()
>   ASoC: sun4i-i2s: Use devm_platform_get_and_ioremap_resource()
>   ASoC: sunxi: sun4i-spdif: Use devm_platform_get_and_ioremap_resource()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: sunxi: sun4i-codec: Use devm_platform_get_and_ioremap_resource()
      commit: 37c617f1cf062b56141a06e2ae355e3ecc8b8451
[2/3] ASoC: sun4i-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: cc384f05c05618dfcf1990054c1f40bedbb01cca
[3/3] ASoC: sunxi: sun4i-spdif: Use devm_platform_get_and_ioremap_resource()
      commit: bb17379cf278c15574b0c1c94a76531f637970c7

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
