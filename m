Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006FC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 17:02:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C549664D9A
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 17:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C549664D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D54218E2;
	Mon, 15 Mar 2021 18:02:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D54218E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615827773;
	bh=X9FXDjHHH0l74nuXFjYXBr5zguKiacAJ1oANBMdIGZE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gz8sgSkbaUBk2ng1LuIf6Gqs6MQH0xAEqgThZYWSWeZX+hokVBLxCqmLo0otdE165
	 PEPafgSQObw84DtskVJbd4za4DHoFf4YtfIOvnDX43NQoqWpD9OJeyeRSyxuvWgaEz
	 0N0kNOu77+TEXl6LBXrWQTDDk/+pWCyTqSqNBVQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A4E5F804FC;
	Mon, 15 Mar 2021 17:58:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29A20F804FE; Mon, 15 Mar 2021 17:58:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D7E1F804FB
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 17:58:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D7E1F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="duBgOd0l"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2890B64F39;
 Mon, 15 Mar 2021 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615827507;
 bh=X9FXDjHHH0l74nuXFjYXBr5zguKiacAJ1oANBMdIGZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=duBgOd0ljdSkO8avX7XwWSobCC3nObKVXmpHaqjF8ge6/ueE/nayyuNDC2QsPpARu
 no4sZYRnR7VttD8SAFCu7vI9tS1X/13XivvNdX6qHKhJnfW0B1+w3THrzYzuTZ+l8h
 Ov2z5FEeHTt+eUDJa4HUnnB4gRwkk1XHYCh4caWGR1FcP3aQ9WZ2cpt+yxU1TSHNGl
 nJSxhgHMD++W/UVXSpeIxAOEJHaV//8aC2RZuYDD5+LXgjgiLdZ3ATDBoLo2+nC299
 RGVuTEg7dEg6Qr7zLKAC0ziGw+oWXKGmPmbcjP2RSOfkJMTrZfJqlxH1kPBpnAHQEH
 lFOJv5YIrExdA==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Wang Qing <wangqing@vivo.com>, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] sound: soc: codecs: Remove unnecessary THIS_MODULE
Date: Mon, 15 Mar 2021 16:57:05 +0000
Message-Id: <161582734875.54882.47331867129357785.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
References: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
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

On Sat, 13 Mar 2021 16:23:02 +0800, Wang Qing wrote:
> As THIS_MODULE has been set in module_platform_driver(), so remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: codecs: Remove unnecessary THIS_MODULE
      commit: a5e78cfbd50e33c19236f32693516380d1a61c34

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
