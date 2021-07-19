Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0EC07E9B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 15:43:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B58C61287
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 15:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B58C61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 355771614;
	Mon, 19 Jul 2021 17:42:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 355771614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626709404;
	bh=cqRlSDulqqbVMM513s7AFYOzCKIGTfbT7035ImdtIoc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lCELGy2uqIQnnM3T91UjgbUS/NrQiLK6ybQeEF51PTVtStwAejjC1yOLKYBAkWK+7
	 9zhfW0s40Btvc7aG7asP/dbtc1baSlm05GMeSA1AalJhuV+O9OKMWS4YGdgEekKyT1
	 MIsR8iBEk+Ier4EAnZ/dVUvhB6bu2Ncv5gHJGYh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE828F80218;
	Mon, 19 Jul 2021 17:42:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACBA5F80227; Mon, 19 Jul 2021 17:42:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 438BAF800C5
 for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2021 17:42:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 438BAF800C5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NQ+929W/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90E94611CE;
 Mon, 19 Jul 2021 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626709344;
 bh=cqRlSDulqqbVMM513s7AFYOzCKIGTfbT7035ImdtIoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NQ+929W/FwxyDTbyM3SeYTeO7L3gAxt+Y0FTX4cOElbGw461eafssJywtDcc8NcV/
 dnFkc78JJBjA1bNRCy+aL062UQHwZ3hs6Zp4xbyHVxp0UiDZ6ixvrYofidVfde7hKK
 J4juzwVMXg+Kwwyl76/j/ifujUL/VqvttqoWkbzkDNjSOC1kDMu1i0Dak0OAoyi2sf
 58SjmCC2gyD4wWrj+YOQ0wjk2Le3x69vklkNis95a+xx+8i4jGvK93Z1+7tw4u4VZL
 Iur1fqi3RLuIdmGgR79tVweZ5iGpzDab33ZZp4irhytLLvdGTsDrhaeSQslfaMN0Kx
 tqQlFvU+hgyoA==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: (subset) [PATCH 0/3] ASoC: ti: j721e-evm: Small fixes and code
 cleanup
Date: Mon, 19 Jul 2021 16:42:20 +0100
Message-Id: <162670863483.4740.8075302398410243155.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210717122820.1467-1-peter.ujfalusi@gmail.com>
References: <20210717122820.1467-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com
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

On Sat, 17 Jul 2021 15:28:17 +0300, Peter Ujfalusi wrote:
> I have found two issues with the machine driver which for some reason did not
> caused errors but they are certainly bugs.
> 
> The last patch is just to convert the IDs from define to enum.
> 
> Regards,
> Peter

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: ti: j721e-evm: Convert the audio domain IDs to enum
      commit: cfc9d37ab79ff19d44a17195e57b2828084d5896

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
