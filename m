Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE365C352A1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 17:39:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C42AE1893;
	Wed,  7 Dec 2022 18:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C42AE1893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670434794;
	bh=l/hr3BP10VYHJeYpDguxTDL8VV9ctO18e0697lGL23A=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t7y+2zWJh0PtIa3j/Bz9/DdAJC9jQJqsVoOq8zR6i09S4+mKrAO+4Ny1v0PqVHt1w
	 fxEjCRRWUl0qsqe3tbYr8uTKKfl7QiCiNxyai4tH8W6BeEttpsFx4xcozoGIyOLNd2
	 MJ+ZoZJpne0BsdHBGqDMluo9nrYtEpTDKd1BAirA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DD88F80571;
	Wed,  7 Dec 2022 18:37:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05AF5F80578; Wed,  7 Dec 2022 18:37:55 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 061ECF80563
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 18:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 061ECF80563
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f4VXUaOB"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 94B2A61B8E;
 Wed,  7 Dec 2022 17:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E7EC433C1;
 Wed,  7 Dec 2022 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670434667;
 bh=l/hr3BP10VYHJeYpDguxTDL8VV9ctO18e0697lGL23A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=f4VXUaOBnDz1nVz+ytjxdy2D8CLl7kX5Yv5JY7ql4RBSUAdMti8E9PaBszdkfKYZ1
 MYNoLzCpxrZcdneiYmj1GJkI8gwHzcwY48M8Johq3/l6KUpsm+ouFPNmhktLAjx2lF
 xTdjiI+/XELJ0DB6PQA3S+m28IayyyyFBVZVfSHsc+SsF3180cqLhJtkXF/pOSng6l
 HXrCrAn6PZvOQJ0LxlyaZ1c2MdMOFomHENjXyZ+R3xvH6tRQzWDEM/ueaNl/iA2UUS
 x9MdwjM5lAEr1qpVSEM9U49KiGhnJK7lk00Wb++6Gfohrt7PvZDN46gjbAcic34BID
 Q2LuIxwKdnDpQ==
From: Mark Brown <broonie@kernel.org>
To: ye.xingchen@zte.com.cn
In-Reply-To: <202212051943476482106@zte.com.cn>
References: <202212051943476482106@zte.com.cn>
Subject: Re: [PATCH] ASoC: imx-audmux: use sysfs_emit() to instead of
 scnprintf()
Message-Id: <167043466270.393374.10705355616730317824.b4-ty@kernel.org>
Date: Wed, 07 Dec 2022 17:37:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, xiubo.lee@gmail.com, shengjiu.wang@gmail.com,
 s.hauer@pengutronix.de, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
 shawnguo@kernel.org, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
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

On Mon, 05 Dec 2022 19:43:47 +0800, ye.xingchen@zte.com.cn wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmux: use sysfs_emit() to instead of scnprintf()
      commit: a39bc7cf8e284653fb6fd9d897f269f4ac80cf52

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
