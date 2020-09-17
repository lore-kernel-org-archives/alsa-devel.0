Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981CC43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:05:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B2220717
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SKS6+niE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvMZfo4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B2220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B2FA1684;
	Thu, 17 Sep 2020 21:04:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B2FA1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600369514;
	bh=WzQSueMrPjH1L0bv8gkr24oYRFWKRtRXu3TB/kv+Fws=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKS6+niEWPTmq/XXAhGgyGrVN/wAQ2v4uUjauYADmEb30oeDA48B3hhxi4DNKH/2W
	 laAQsew/bc3YdDhTAY+TbtWpNQ2kJxGy5VWAhybXUBipvkZlSuUR1xUIWmoiLmXqRI
	 rJXhK58iKq8nRMrdZC1lWsDQjxKXKiGygdabHlm0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C49AEF8032A;
	Thu, 17 Sep 2020 20:58:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08F49F80331; Thu, 17 Sep 2020 20:58:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E03DCF8032A
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 20:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E03DCF8032A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KvMZfo4k"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0020F22208;
 Thu, 17 Sep 2020 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600369118;
 bh=WzQSueMrPjH1L0bv8gkr24oYRFWKRtRXu3TB/kv+Fws=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=KvMZfo4kro2jTQb5Wgt+VFDai1DJo7YYwmtvW3jtJMW8zaJqwHI8+l85SzRbpn/BS
 lUU/oqMaCrHn5ly2TQ81LBThPqH282ocOnCeL8oXxylFcSnPfSnwkPZZnVy6Q/yaCZ
 VQ2yEsjJx+uXouSwzqwgRIBEQuiXwJAsP58Jdo5U=
Date: Thu, 17 Sep 2020 19:57:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Xiubo.Lee@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <1600104274-13110-1-git-send-email-viorel.suman@oss.nxp.com>
References: <1600104274-13110-1-git-send-email-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_audmix: make clock and output src write only
Message-Id: <160036900934.20113.8635457303400843609.b4-ty@kernel.org>
Cc: Viorel Suman <viorel.suman@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
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

On Mon, 14 Sep 2020 20:24:34 +0300, Viorel Suman (OSS) wrote:
> "alsactl -f state.conf store/restore" sequence fails because setting
> "mixing clock source" and "output source" requires active TDM clock
> being started for configuration propagation. Make these two controls
> write only so that their values are not stored at "alsactl store".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_audmix: make clock and output src write only
      commit: 944c517b8c838832a166f1c89afbf8724f4a6b49

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
