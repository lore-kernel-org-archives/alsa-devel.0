Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B85CC678D4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 13:35:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A82181115;
	Mon,  6 Mar 2023 14:34:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A82181115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678109707;
	bh=O0NjiuKo1KTeYcFKpvLnjP0XZq5Y7WBdJ9fIWIS1EPA=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EQ540YDvDevcqfmQy2VXc+MinQwjLVKWN+sTMTPLSmnxrbTzfQqOqr4A64WwrReqX
	 50h4JA2gFMo2vLdcpmLfQGyIftsYvxqVE8SKbErZgZMqwiGWe0j70qJNhO7KBOD7rq
	 hE/EA5SmV8EbFCItbE5SIgc6ce72SC8C09d24iv4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BDC6F80552;
	Mon,  6 Mar 2023 14:33:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA8EAF80542; Mon,  6 Mar 2023 14:32:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0FD8EF800DF
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 14:32:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FD8EF800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iUDwurd2
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D7DFF60F28;
	Mon,  6 Mar 2023 13:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257CC433B4;
	Mon,  6 Mar 2023 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678109525;
	bh=O0NjiuKo1KTeYcFKpvLnjP0XZq5Y7WBdJ9fIWIS1EPA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iUDwurd25ro1kA7RbCRBOaBAjZt56mRalMR2nh++cE7GCuh9CZgefYkN9+LDiA6mm
	 eqw4ycytfNZsIHOdOcCIwU2xX6hAdmoWhRkZwlQ6YoHd8TIPoSaXLpkT6yKrwaV/CO
	 Bo4kp0jPFxPk/CbLhmuHaLj24Ls0BQ+quPFYoPzqNX/7z6aHeJ8rkutbAoEzlDJCZ6
	 oIBnPm2nH0b7uNmBlf804wiaBSfxglSyOIP51UBS8EuF0gUPF2OJrd8eULJCTLPOGj
	 CF937OB/4hyr7SVq+PMo8hUoGa0ErgCyeFJ+G7gOyMKEeppWy91a159fthgZkzS02A
	 94zluJx4A3hYw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230302104616.26318-1-srinivas.kandagatla@linaro.org>
References: <20230302104616.26318-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: common: add kcontrol to jack pins
Message-Id: <167810952324.75807.15238785046098203120.b4-ty@kernel.org>
Date: Mon, 06 Mar 2023 13:32:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: 4RFJDRGA2FDHCF2HBQ5O52OOY3PY4NTO
X-Message-ID-Hash: 4RFJDRGA2FDHCF2HBQ5O52OOY3PY4NTO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, steev@kali.org, johan+linaro@kernel.org,
 quic_bjorande@quicinc.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RFJDRGA2FDHCF2HBQ5O52OOY3PY4NTO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 02 Mar 2023 10:46:16 +0000, Srinivas Kandagatla wrote:
> Add Kcontrol to jack pins so that device switch in ucm can be done correctly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: common: add kcontrol to jack pins
      commit: 4c2c935a278e53bf9a1713bb0a01ce299a994e9b

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

