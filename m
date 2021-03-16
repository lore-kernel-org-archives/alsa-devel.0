Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA4EC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:02:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C20265132
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C20265132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D56E318EF;
	Tue, 16 Mar 2021 19:01:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D56E318EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615917756;
	bh=iGiBNRxaPcDr+iH013raTIVuSi+f7uXGwsktWMiJ3zA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=elJe4E6x6ZrEro4yd9I3HlR6vMmKFARPVj7JRYuOJLU/A15t85aUKDzp0AN1O8s2C
	 oc/i5+DKzkg/FlP4wPNuXN8JYWBIgTW2J3Cy4P4j7OYcSnrIP2x3nl+UIOMgom5Ruz
	 VFrhfsANAoPhs95mEHTLAosogfeHCNCTQxmU/k1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB959F80475;
	Tue, 16 Mar 2021 19:00:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B1BAF8025E; Tue, 16 Mar 2021 19:00:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 714E8F80163
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 19:00:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 714E8F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vk1OzZlj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56D5065138;
 Tue, 16 Mar 2021 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615917606;
 bh=iGiBNRxaPcDr+iH013raTIVuSi+f7uXGwsktWMiJ3zA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vk1OzZljn21yoof0f5+sxZerNH5nku57uhEErWCu0wqClyD4i6+Q2gbSbinH/hoX/
 Poq/vNUJiY/GJRdmdYa4dy0OgbxuWygENGWFNGJxR89EDL9/78UysElnpg21NKbXw3
 dHmhgaKTG+tQt/c3LtCQ8qWbaLFIFrWbvqrfSGFAcNarYf5zhp/nPIvochh1Nk2zX/
 /iQmt9+9gN+yM1Qzw0QDlvx610nIKv6apmWOqSYnVYx7KkGj4UQwREqOEzXHtdR7lx
 3h+LSG2S/3G7RkIPagCZMjiVT9fa2EGi41cX+jUOfYFHx+iHShBzl51X69GHAScRa1
 i8iYkO/X4yU8A==
From: Mark Brown <broonie@kernel.org>
To: timur@kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci
 warnings
Date: Tue, 16 Mar 2021 17:59:44 +0000
Message-Id: <161591744695.13544.5664238144081084443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, shengjiu.wang@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com,
 Mark Brown <broonie@kernel.org>, linux-imx@nxp.com, kernel@pengutronix.de,
 shawnguo@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 4 Mar 2021 17:08:01 +0800, Yang Li wrote:
> ./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
> will do it.
> 
> Remove .owner field if calls are used which set it automatically

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci warnings
      commit: 2e2bf6d479616a15c54c4e668558f61caffa4db4

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
