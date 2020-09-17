Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10869C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:01:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4E2206E6
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QDb9fZHs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="COy9VIGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4E2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F15216A8;
	Thu, 17 Sep 2020 21:00:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F15216A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600369268;
	bh=h2oBzSRlDP6lx+rd4sKX9zHni5NLmneiOlwvYFS28v4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QDb9fZHsPf0dwqp+6u8/IBj16XScHx9tA78JlQP2gD7RghvoCWW+PZxNINnp7NxL7
	 oyBnsmKCMh1yZwjriHCgkXymM8rF51ozf16Qe8nV9OY/QsRTU2uEKrJSjdokxohHl7
	 UqdSG/8GjhJHTAAEFdB4tPa33sDEe2EBpYvbkFWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5A48F802E0;
	Thu, 17 Sep 2020 20:58:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A43DF802E1; Thu, 17 Sep 2020 20:58:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AAEEF802DF
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 20:58:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AAEEF802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="COy9VIGa"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D2832072E;
 Thu, 17 Sep 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600369080;
 bh=h2oBzSRlDP6lx+rd4sKX9zHni5NLmneiOlwvYFS28v4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=COy9VIGawcbUC2qB47O6ifSy3VHIHqyKV/Slg/r590Y0r1xhwDQLyjWdTHieGTVa1
 ekqEU3m4TvI+HUfQNCzoMc529Mwgs4mau+JK2IkbI+5LX0EnIdCgSeDb8uOPgAgvep
 WjSJoYVYU9b70EnDGw7VXkRzUdzV7YrrpEAiKQhs=
Date: Thu, 17 Sep 2020 19:57:10 +0100
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
References: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: q6afe: add clocks support
Message-Id: <160036900935.20113.3270260230921504372.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, sboyd@kernel.org,
 plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com
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

On Thu, 10 Sep 2020 14:57:06 +0100, Srinivas Kandagatla wrote:
> q6afe already exposes clocks using apis, but not as proper
> clock controller driver. This patch puts those clocks
> in to a proper clock controller so that other drivers that
> depend on those clocks can be properly expressed.
> 
> 
> Srinivas Kandagatla (2):
>   ASoC: q6afe: dt-bindings: add q6afe clock bindings
>   ASoC: q6afe-clocks: add q6afe clock controller
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: q6afe: dt-bindings: add q6afe clock bindings
      commit: 4e398353a7e51410c34fd19f8b7dfc56fff5901b
[2/2] ASoC: q6afe-clocks: add q6afe clock controller
      commit: 520a1c396d1966b64884d8e0176a580150d5a09e

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
