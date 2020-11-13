Return-Path: <SRS0=KFnC=ET=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C880C388F7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 16:08:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B402076B
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 16:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kBE4r4FP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wombEv1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B402076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 100DE187C;
	Fri, 13 Nov 2020 17:07:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 100DE187C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605283703;
	bh=sre5Ncd4+t1WbdhGWEmDUhsQD2o0plV7vDn9cH+bFeA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBE4r4FPtSEvr8Hr1HxUT/Z2I45cQFeeurXBNsxSZyCivKcp2PtrYpq57QaWj2946
	 hA+a9syf6p7Ucj41MnFHezHtJdaD5ZLemqhJiiUbprKKBMpsXxaEDuBKWJT5Fs//9W
	 UVV1prCZVBlU3Bcq3wLPB2Ytu9X+UcdR/Wlb4I1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA8FEF802C4;
	Fri, 13 Nov 2020 17:06:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A0F9F804AF; Fri, 13 Nov 2020 17:06:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23777F8022B
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2020 17:06:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23777F8022B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wombEv1V"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 120832076B;
 Fri, 13 Nov 2020 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605283589;
 bh=sre5Ncd4+t1WbdhGWEmDUhsQD2o0plV7vDn9cH+bFeA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=wombEv1VG10DlCHhFIAUeWi7TKLu/n/pr8p0Svl+7PetLuHeFINctEwbr5MH7ookb
 cIZmfWMNfAqEq+WB5a49Z8IQbNqFidSq0VtLviTddDDcl5w5yLTyzDPBD7i/C/na5L
 iQkKCfSKkhvsfOA+c5BAZ42uAufutslSULT0jNg0=
Date: Fri, 13 Nov 2020 16:06:13 +0000
From: Mark Brown <broonie@kernel.org>
To: "shumingf@realtek.com" <shumingf@realtek.com>, lgirdwood@gmail.com
In-Reply-To: <20201113092125.19206-1-shumingf@realtek.com>
References: <20201113092125.19206-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt1015: increase the time to detect BCLK
Message-Id: <160528356700.2641.6066991082215649740.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, kent_chen@realtek.com, derek.fang@realtek.com,
 flove@realtek.com
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

On Fri, 13 Nov 2020 17:21:25 +0800, shumingf@realtek.com wrote:
> To meet the most platform, the detection time should be increased to
> avoid that the flushing DAC data fails.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015: increase the time to detect BCLK
      commit: 106e6d8df4842d816dae23076c501ae48386afcb

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
