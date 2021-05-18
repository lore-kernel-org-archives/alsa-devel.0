Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D0CC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 16:34:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B10611CE
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 16:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B10611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B16831741;
	Tue, 18 May 2021 18:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B16831741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621355672;
	bh=sd481hao0IvKarDjopwS5z1QyDhGwAXg6X3FMDmBoVU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAGDaUbpIYou/CrTaLBU6GbMWwwNgfzJ+LNN5PNfn6UB9sTgZhLi6f68YXcF2A1AK
	 cssPXA2WpkWhuaWnszeV9XcRnzBPeurlOlDMCzw3qeBXUNZzIgqudcNy5eUwwUomMX
	 J8ST+/y2s/e7UHWzDYVeCBjL/1WKVTsZt8IdOCAE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 462DDF80257;
	Tue, 18 May 2021 18:32:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70446F80217; Tue, 18 May 2021 18:32:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F88CF8014C
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 18:32:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F88CF8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rwK7OTX6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C8156124C;
 Tue, 18 May 2021 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621355559;
 bh=sd481hao0IvKarDjopwS5z1QyDhGwAXg6X3FMDmBoVU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rwK7OTX6zAJxyUItiymRzKwWLo+PKSpUa4x1sC6Kb7eJf1JPssuB1L7lOgGZsil0o
 N/APL1OzLgOOOcKqOlj5fsioTzuX6lQtF8bYFIEy1VxtcyeE1+ySpgE1XzOlAXRbcV
 mE+/uTnTFhI4r08QCfmgIkyUZvgmTLThn5L9WNz1zgl3CAlo8lrpyMUbBxchZCFaB4
 V6GfruVvyMr6TzURrD5tslfDcBnM1vputL4aM131y0JEvtnO6Z5/E7xg65eh3Qovj8
 TOrxINez0m4CMb62GRSgIIbJs+rTRafwi1wBtc35d8pKoUvF26uo8MJqaVaBU6jhzs
 VhuexZuMmRjNw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, YueHaibing <yuehaibing@huawei.com>, perex@perex.cz,
 lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Subject: Re: [PATCH -next] ASoC: soc-core: use DEVICE_ATTR_RO macro
Date: Tue, 18 May 2021 17:31:32 +0100
Message-Id: <162135531445.37831.1353258100383358131.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210514081100.16196-1-yuehaibing@huawei.com>
References: <20210514081100.16196-1-yuehaibing@huawei.com>
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

On Fri, 14 May 2021 16:11:00 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: use DEVICE_ATTR_RO macro
      commit: 5a3f869c5b4d230b60ba0197c10506dd4ae30851

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
