Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E510C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 17:28:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FD8610A0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 17:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96FD8610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67D7E826;
	Tue, 21 Sep 2021 19:27:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67D7E826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632245322;
	bh=4wznaaP03tnFM8BprBoP3rh9QQqQF2VPJocjoL51BuE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kFQyaVYEUJFSEN68nL6E55jKpurpDMoHA9uzyskXoNuwWO+WjAW2bTuK8XE2lMTz3
	 KJJScXPZvn8lNChQ2r+UcklxMDdTq/6gQYx6L9wj6fHJ7Awm5pDgFIReRzlOv0SXpH
	 3FYlLb+xfLPKLXncZZLA/pJfwpzk8GXEy37iPffg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8BB7F8025F;
	Tue, 21 Sep 2021 19:27:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23596F80268; Tue, 21 Sep 2021 19:27:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B263AF8016E
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 19:27:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B263AF8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hoYNdAiU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31F0861178;
 Tue, 21 Sep 2021 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632245263;
 bh=4wznaaP03tnFM8BprBoP3rh9QQqQF2VPJocjoL51BuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hoYNdAiUjWaLcM6M+o6RV3UthxTiD6l2HWBLV4wxKXP0t6FLMIDWHLzUK5zjDcR49
 146IGSMBJsFgRqXObuVVdrJFzchQYQJyTqIt9FmygiIWxv+hyzt9eKfw4dTvvJFwPh
 rgihGoqfwVirV+iRVABTkE//dyTC4r4+6bEcFiEb3tPt4D9lGelpxtYsUgJ7PW++N1
 rMqmP+gHEe/w2hxXQ5HXEejTUUUJlw8b2GLtcRCYS6FFRnPk8vX7moJyzKIkO5JG4F
 eeqr6eQLspvcgZTQvoucMi6RcF3EqokT0g4yniIefbkvJ/PETMnnaciKY5wq5tOQ9F
 tbZCi6aH8nuhQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jbrunet@baylibre.com, robh+dt@kernel.org,
 stephan@gerhold.net, Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] ASoC: Fix warning related to 'sound-name-prefix' binding
Date: Tue, 21 Sep 2021 18:26:59 +0100
Message-Id: <163224493612.45861.17851911764511102643.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632238860-16947-1-git-send-email-spujar@nvidia.com>
References: <1632238860-16947-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, 21 Sep 2021 21:11:00 +0530, Sameer Pujar wrote:
> commit 82d3ec1d89fa ("ASoC: Use schema reference for sound-name-prefix")
> added name-prefix.yaml schema and the same reference was used in couple
> of other schemas. But this is causing following warning and the same is
> fixed in current patch.
> 
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.example.dt.yaml:
>  audio-codec@34: 'sound-name-prefix' does not match any of the regexes:
>  'pinctrl-[0-9]+'
>   From schema: Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.example.dt.yaml:
>  audio-codec@36: 'sound-name-prefix' does not match any of the regexes:
>  'pinctrl-[0-9]+'
>   From schema: Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Fix warning related to 'sound-name-prefix' binding
      commit: 013148fe7f5eb420a497e35d9aa8020cdfe92eb6

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
