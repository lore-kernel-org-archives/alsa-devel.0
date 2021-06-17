Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A6C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 15:03:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A805E610A0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 15:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A805E610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 145E0178F;
	Thu, 17 Jun 2021 17:02:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 145E0178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623942216;
	bh=NK0hn3vw5IKcdns+8rADQfTxpAK7UdjTsHCh/B4bILA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSZdVA5vQSfxxVCI91U2dOPdDnyFEeHgMVl2kAlCv99MnbvcnPtV7k5X2U7ZF051Z
	 GFQtweNZDPqM/AXYX6SHt2ps3EVDp8gzjoaHFpl6gE9VUmZS71gMgnC9zyK8GrUS3v
	 NNYXxmi3JSKyXz7vGpZ/OPzkGZ02vXT52smARpY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 996AAF8028B;
	Thu, 17 Jun 2021 17:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94D51F8025E; Thu, 17 Jun 2021 17:01:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F927F80088
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 17:01:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F927F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hHuMLbzU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C01AE60C3E;
 Thu, 17 Jun 2021 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623942104;
 bh=NK0hn3vw5IKcdns+8rADQfTxpAK7UdjTsHCh/B4bILA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hHuMLbzUhQZbegtkzsLAxghPUBYwDlNPx/Mgbujp25Pc9qfz6uf4XHbFgCBbBaEsY
 IAQGUcoR3E8nzCvgJRUeCegbuIrjgctFpf/baqOQM/nwG/n9M96LAFDwWt2RERH2Ve
 oeI1RUL/3MEZA7otr+8zMIY1kVTaVtIerXdnG2jbQbTImvPPiHDaYpyjcNHc0z2cri
 YqbzqE4Z36kbPArEE6sVpKQPmqPHPoODh44aWp8oL8d+W1etwZVyuiJW/avmFX60X+
 D9xS3b5euA7e0IlSsVSnShxYSKYi4dGbnR7j4Cy1dxOEsMK8S9m2ywMZkm8FlqfWyS
 p612Q6qWPQfTg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: sprd: Use
 devm_platform_get_and_ioremap_resource()
Date: Thu, 17 Jun 2021 16:01:14 +0100
Message-Id: <162394075659.19104.18167768597198191135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617033237.605808-1-yangyingliang@huawei.com>
References: <20210617033237.605808-1-yangyingliang@huawei.com>
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

On Thu, 17 Jun 2021 11:32:37 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sprd: Use devm_platform_get_and_ioremap_resource()
      commit: 19b71456f3684f8dba078619a31afab05ee47c3a

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
