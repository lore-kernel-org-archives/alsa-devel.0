Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1DFC48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 17:32:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B242611EE
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 17:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B242611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A83E168D;
	Tue, 15 Jun 2021 19:31:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A83E168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623778326;
	bh=GEAwyVbCu9FzP4tJk0ycazZjAaockIItbW1zOcgtnD4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t/R/GXXs+4mf1h4pGNtV1msEmLk+JQku5SYlSkgUo4WphRc+E5/jfIFE+2SmUA/ob
	 bZXCwkUpk0xgJv+xTG6DID/Jxb+Hgms/QaAsrhUAdmNi+Ro1udvygZpOxFxAWWPEl3
	 RE6v9hDhh+B9VqxxCvcIRXM0vl+FypiUIY8cXZ1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66E29F802A9;
	Tue, 15 Jun 2021 19:30:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D14C0F8016D; Tue, 15 Jun 2021 19:30:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A6E0F8016C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 19:29:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A6E0F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eX1MFs5S"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB7D613FA;
 Tue, 15 Jun 2021 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623778188;
 bh=GEAwyVbCu9FzP4tJk0ycazZjAaockIItbW1zOcgtnD4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eX1MFs5SdRZYdboOArHyCe3KH+hld9wSZdB6J9XsMl//rcSw/eheZf04JLhr+JzBo
 smRhD2+nsvraIGjpvAlWC24r381xwFlFL/00BduN8OOcPRVCoB93VVEy4lh+pquCTk
 ZWziAgcGx57J0mf+acJuobuCaRlq3ecc9qcDKGXirKp9KngvF34rju4CRPnZ0oEu5A
 QMjMBCqdqzHif1R5jLXGHQg+0edA0LeWBCfVgci2sQOsRHoulsZgaIHSCTA6szTDun
 tyABhZE4caX7WdvDpDv71jqYaWSvaNDHU8COul+I5JMlxeiHs1uI+1iUdI+dbChB/G
 eyu/DIPvmXnSA==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: hisilicon: Use
 devm_platform_get_and_ioremap_resource()
Date: Tue, 15 Jun 2021 18:29:18 +0100
Message-Id: <162377763944.21612.17506249147724784597.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615133515.1376290-1-yangyingliang@huawei.com>
References: <20210615133515.1376290-1-yangyingliang@huawei.com>
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

On Tue, 15 Jun 2021 21:35:15 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hisilicon: Use devm_platform_get_and_ioremap_resource()
      commit: afc3a0b4c408b00787d60225e6d667e1e6f93b6a

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
