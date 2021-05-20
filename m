Return-Path: <SRS0=8dQ6=KP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9022DC433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 20 May 2021 21:10:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD499611AD
	for <alsa-devel@archiver.kernel.org>; Thu, 20 May 2021 21:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD499611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51B2216BE;
	Thu, 20 May 2021 23:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51B2216BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621545025;
	bh=LG9V/TQafsoAsE88DwTNEoOzd9py69hLE9jxEkJQCPU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=euA6gb2LR4yxpRLjUaPG8W8IWCVK4A0nsenrQIV5H+FLdj0zwYx2mUkVwh3yVM43i
	 G82zG2q6lDqf5Vt/vGdOnkXWal7HpOlqSTnUuGL6XoBKBXtc7827QJthFip4rPB8b4
	 SvZDESUnTc7gvz9NNaPyHz5TEpR3QSDQMzhWGxSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3E44F80475;
	Thu, 20 May 2021 23:08:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB16EF80482; Thu, 20 May 2021 23:08:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 363F4F800C8
 for <alsa-devel@alsa-project.org>; Thu, 20 May 2021 23:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 363F4F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EbMNMGWo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 865D561353;
 Thu, 20 May 2021 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621544907;
 bh=LG9V/TQafsoAsE88DwTNEoOzd9py69hLE9jxEkJQCPU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EbMNMGWokIwMGVWGnzQ6B+yMcpTNPUl9VU02RDoGJAUjKWfdRVyoIus65bfiMQnbL
 L1micb+F1YUSYQHmtXAt84+JpWWAT8CmSMPTIw4YdENcJ9zrsL2t0s0w7wzHWP/o70
 7KwKB+7x1U4vOs/vG5TpIuoFRxXWQmihTEnUFAk2gQd8nvU5VA7Z/iFoBJSy9OnxTa
 Ez6fNGw1yupI+1xIpvwgYzUbkIM8b+E10bDeOW6ucfcXROjM0IhsL8lPQyBi5kj58T
 PvncV6jUEBkpvh2Yi9TbRV6Hr8XAbSOnKrjLqzkRvDz9/ozc6UiQBSMisTnlNNOFfg
 ZMdvDdS0F5v2w==
From: Mark Brown <broonie@kernel.org>
To: linux-imx@nxp.com, perex@perex.cz, linux-arm-kernel@lists.infradead.org,
 nicoleotsuka@gmail.com, festevam@gmail.com, shawnguo@kernel.org,
 Xiubo.Lee@gmail.com, alsa-devel@alsa-project.org, timur@kernel.org,
 s.hauer@pengutronix.de, Shengjiu Wang <shengjiu.wang@nxp.com>,
 robh+dt@kernel.org, kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: imx-card: Add binding doc for
 imx sound card
Date: Thu, 20 May 2021 22:08:06 +0100
Message-Id: <162154465460.5161.5323165215525240615.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621247488-21412-1-git-send-email-shengjiu.wang@nxp.com>
References: <1621247488-21412-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Mon, 17 May 2021 18:31:27 +0800, Shengjiu Wang wrote:
> Imx-card is a new added machine driver for supporting
> ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms. But these
> DAC/ADCs are not only supported codecs. This machine driver is
> designed to be a more common machine driver for i.MX platform,
> it can support widely cpu dai interface and codec dai interface.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-card: Add binding doc for imx sound card
      commit: 623cd9cfcac522647e3624e48bf0661a39e8502a
[2/2] ASoC: imx-card: Add imx-card machine driver
      commit: aa736700f42fa0813e286ca2f9274ffaa25163b9

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
