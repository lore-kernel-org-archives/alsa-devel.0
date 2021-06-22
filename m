Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013B6C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:17:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706E561289
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706E561289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01C751686;
	Tue, 22 Jun 2021 17:16:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01C751686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624375043;
	bh=36Q0EN0ywk76JIdsYkkzUNCRAO4ZEj+9BRi8a7OzxJA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZGFNYB8YYizw9gyH0lDjXHnWW6LcKw3NXt2ZWWC334Wd4zqCbCAiiTRl0/HV6tobJ
	 FOPgPBLpy93Rj2zo6AjVK+Y006Onh/frEv/hSDjT+szWiNCXLUVp+qHBEPXzeNzDD/
	 J1rN0PiiH4BmmKwM7/67VjGYDEA/5gz4yoAWfgWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79A1DF804E1;
	Tue, 22 Jun 2021 17:14:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0EAAF804DA; Tue, 22 Jun 2021 17:14:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBE01F80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 17:14:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBE01F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PeAP168U"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1596160BD3;
 Tue, 22 Jun 2021 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624374889;
 bh=36Q0EN0ywk76JIdsYkkzUNCRAO4ZEj+9BRi8a7OzxJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PeAP168UjSx0B9yS1cwdCOXE5zbBuEQ4ShXRWcNdj837L7TNrtpyd82VN9BgasD+L
 Zsr5uUyW9q31vyX9tIUvSDGyxdmD2ehdAOh+Il3ABRFtLxMnDWtW8bV9kdoKNwP6zl
 RvolsX0QT2/9yDMTYj/TduB0ZANH4/uBcRZZI3KWUDT/CMfLWyAO/wl5yitL/YRUNy
 6Xu2+C2QmG54LhG3bhEX1eWtdJngawwLTWyXf/xQiCoZ+Ci4tzOrEFZ2n5QFzu6IjC
 DI4U/c1gG6MMp87FKpYQkoT7jRvloSdklwAk8Dn10Wd60QlnNy5ibx0BMlRzghNU3+
 dEuqf1NBtWnTA==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: SOF: imx: Add missing of_node_put() in
 imx8_probe()
Date: Tue, 22 Jun 2021 16:14:08 +0100
Message-Id: <162437355278.1773.16960158765626979060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617032756.599359-1-yangyingliang@huawei.com>
References: <20210617032756.599359-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com,
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

On Thu, 17 Jun 2021 11:27:56 +0800, Yang Yingliang wrote:
> This node pointer is returned by of_parse_phandle() with refcount
> incremented in this function. of_node_put() on it before exiting
> this function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Add missing of_node_put() in imx8_probe()
      commit: 0ba0f44fd516b34c9f40cd82fd480705d0f378dc

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
