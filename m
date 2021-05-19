Return-Path: <SRS0=AXUI=KO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C96CC433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 16:13:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8459E61244
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8459E61244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D0011682;
	Wed, 19 May 2021 18:12:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D0011682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621440791;
	bh=ZL3psb3b/PFz1Seul7gHnQyH1SZ87FzQ+4g1uiKv7xI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NgfOA0N33b4eyMuKU8gL39B3laCzwgqfzLOKTFOJcU84ba/Rwn4encajWwXildFDV
	 2SmOYOdbfAymsVJIckkpwKtRXuITvmEJn2WbCf/CJLNQ1rLMTTcN5HyjFwMHM6HCgg
	 JQfN/AfZIOO6G+BXqBvzW2tJb2yujqpPvxhBiXls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECAB1F80258;
	Wed, 19 May 2021 18:11:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7079F8025D; Wed, 19 May 2021 18:11:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 576B8F8014C
 for <alsa-devel@alsa-project.org>; Wed, 19 May 2021 18:11:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 576B8F8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oYJ2Kb8A"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 208EC61244;
 Wed, 19 May 2021 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621440681;
 bh=ZL3psb3b/PFz1Seul7gHnQyH1SZ87FzQ+4g1uiKv7xI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oYJ2Kb8A5KEl78y977KlTupYWeDNOcVNuHyAC89B/yEt/vCLvaKUiB42OqAEKJiEX
 wpm2zlEGZttK8mFaDxA5K7X3gArZ0dFM9/v2Pshq2IhFbu4SMHCY0yqtg0Q6s0KKSw
 MQgPxbPJH2aJHbasFWHdQJHtJH50w+cycBj11lZnLU+DSRzkuE4ls61AWfTEWSh7qI
 SCTTTYJH2Q6dqHsKQ4hgw73j62cc3VRponStdt+opayu1YOPbnHP/Ku+J0qAT0P6EH
 DieMU9d7DQV8I0U4qyHDtcINyKeIG4t3/GD28qBzANhQ1gyZuMB7tnGoAO+UFBRwcY
 BMMxDx7clLNTA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: sound: wm8750: convert to the json-schema
Date: Wed, 19 May 2021 17:10:17 +0100
Message-Id: <162144027323.37060.7346923502506402074.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512205926.780-1-zajec5@gmail.com>
References: <20210512205926.780-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
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

On Wed, 12 May 2021 22:59:26 +0200, Rafał Miłecki wrote:
> This helps validating DTS files.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: wm8750: convert to the json-schema
      commit: 11480dbfe1d59eaa6382864acc476e7621b1da4c

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
