Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:42:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9467060555
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9467060555
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 022E616D6;
	Mon, 25 Oct 2021 18:41:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 022E616D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635180160;
	bh=+f1u/k8tcw7KrKVie3+DT7cZQFMJl7nIB9hC2xhyxqM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iKwMqhU6D3LTdkyHRRRdikE9slYMbGU0cpHOxnSFq+BzUZ1rk+KnYmc/QvK7IVjR3
	 /5ALFPyEsTWU5bGzcprDIiF3KjRIzUCBtUlaZoaA27MgCXAOs5NcWMBCxZg7JN7vr+
	 2+25v1BlNhgP0EB/56L2HGKOSH+o2LJAovbVgz0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A449F80508;
	Mon, 25 Oct 2021 18:39:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16397F804F1; Mon, 25 Oct 2021 18:39:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9C0AF8025E
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:39:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9C0AF8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cBS4gCJZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2F3560F22;
 Mon, 25 Oct 2021 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635179988;
 bh=+f1u/k8tcw7KrKVie3+DT7cZQFMJl7nIB9hC2xhyxqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cBS4gCJZKU3LODG3zfT7xTzGY1EbKSRHMYgDrDKuPbPH4IT0RQoqBqmlAfU3/mHSe
 OAFbXeQEzfVcl5bsEGKQ8BZRWaO8jkALlBwrWImgowNFt+mmp20/wbsuD/M7CCmCsc
 O5Upen3ShTOukPXGk7hW5FNdjmj+nL3y8zOH0IUE+jbLH5GoPRFZj8W8/dEz5mSkSj
 38I8imQBLmW5kC/Z3WcsaVIhla9OL35Jiu1Pd7bTbYo8bqOpJjpZXBqc2g8SToR+kw
 HB+2xVATjh96ewxvTt28Hfz37hduG5zyDSfm3B2ZTjI8FcSNuSPQh0XcZIsBU2b+3N
 ox2JFj12relfA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoc: wm8731: Drop empty spi_driver remove callback
Date: Mon, 25 Oct 2021 17:39:25 +0100
Message-Id: <163517996156.3558038.2860845676283809182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020125803.23117-1-u.kleine-koenig@pengutronix.de>
References: <20211020125803.23117-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, kernel@pengutronix.de
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

On Wed, 20 Oct 2021 14:58:03 +0200, Uwe Kleine-König wrote:
> A driver with a remove callback that just returns 0 behaves identically
> to a driver with no remove callback at all. So simplify accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: wm8731: Drop empty spi_driver remove callback
      commit: 8b27cb2e6dd67552f19f45b4560bdedce1ffb638

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
