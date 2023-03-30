Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2C8C7619A
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Mar 2023 20:01:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3FD81F1;
	Thu, 30 Mar 2023 22:00:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3FD81F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680206465;
	bh=PKl59xrFNUIN+xj66A1w7ioz+iBVnTH7SBApsoJlFVs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QYU+aRNU0HPv7Ji8OU+snwr7dvu5bfdLNnAXOKCmKC8/aFsaxEKbn/1EGjxdCWuFb
	 9cu/DV2N8EERdP1GTd8KKNbtRimlqRRWY2HSipsuAB5de9EMkDOLbtysAg4JuqSf+M
	 t936yYrYYI2gShCq+s1r2tz79JhlLu2nQz1jfjXQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A3C5F80249;
	Thu, 30 Mar 2023 21:59:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BCDFF80290; Thu, 30 Mar 2023 21:59:48 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CEA49F80249
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2023 21:59:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEA49F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IGBYnkD6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 374FAB82A1E;
	Thu, 30 Mar 2023 19:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54435C433A0;
	Thu, 30 Mar 2023 19:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680206377;
	bh=PKl59xrFNUIN+xj66A1w7ioz+iBVnTH7SBApsoJlFVs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IGBYnkD6/blVHeVCt/RyQ0e/8kyYTnk/zjEu8ftklLhrBtTu+LzCuM53ng07HAGVD
	 b9mh9gRKHgSL+SKqqsAJqqH3sLPBImoeIfOjaTuJQJYBDNKSQrDvL9uL9/lQHw5bMr
	 B1ZRj0r6c0X4ExtPqhqIavPDsdElNi9kGDZVttro7mjXIqc3Fmm3fg5v2xOnG8UOh9
	 jGkC3SFrcFZDrgd47eBBpHFvCs1i8WIKHccQaWor7utUmart55FzPqHues4ljL5IVJ
	 c6WCdTwwKDKlrJYW1JoY0eHFiSucJj+fWZVj27OvqYJwLRgiM/gjV6taD2SXTZihBT
	 +KZCiQKoPvHsw==
From: Mark Brown <broonie@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330113405.55722-1-krzysztof.kozlowski@linaro.org>
References: <20230330113405.55722-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing
 NPL clock
Message-Id: <168020637506.3358032.8475838193533014341.b4-ty@kernel.org>
Date: Thu, 30 Mar 2023 20:59:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Message-ID-Hash: 7TTR6LY3VKCYPOXEIHBERWCWQOLTPNP6
X-Message-ID-Hash: 7TTR6LY3VKCYPOXEIHBERWCWQOLTPNP6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7TTR6LY3VKCYPOXEIHBERWCWQOLTPNP6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 30 Mar 2023 13:34:05 +0200, Krzysztof Kozlowski wrote:
> Several devices (e.g. SC8280XP and SM8450) expect a NPL (Near Pad Logic)
> clock.  Add the clock and customize allowed clocks per each variant.
> The clocks are also required by ADSP in all variants.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
      commit: cfad817095e111b640c7d538b9f182d2535ee065

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

