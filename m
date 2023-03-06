Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DB0C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 13:35:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7584A1108;
	Mon,  6 Mar 2023 14:34:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7584A1108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678109746;
	bh=0HED5BF+CSMfApE3r3XXE+GO27EAtl453R3CEWKwYEo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=uLEgenXQL+hQDLyL+U3VxmbykU5vFC8VbpVc6qvTqBYMsEm6030xA/Iknm6KRPpj0
	 cj5ygXjLBkaAX2ODKjoOLm07LMOrhFOqC/dL+aOHX+aBa5bCD5O45Y74DAIo9QlI1r
	 SdV+MW5ffseelleTDEH8uUQw/EjSdxmSQHIZ5Al4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9291DF80564;
	Mon,  6 Mar 2023 14:33:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDB0FF8053D; Mon,  6 Mar 2023 14:32:15 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 353DDF80482
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 14:32:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 353DDF80482
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WpCcykSi
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id CED4EB80E43;
	Mon,  6 Mar 2023 13:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47FC4339E;
	Mon,  6 Mar 2023 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678109530;
	bh=0HED5BF+CSMfApE3r3XXE+GO27EAtl453R3CEWKwYEo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WpCcykSic850aKKJpl1UOMtcvw1Ngz7H69pUzq9SIT8S0psJvfClgxeo723/409Oy
	 wZig95iyo6RbUYI/NuaPzG/GF5AGtviFov8Bx0zbK+Ams7hjL9maBQ6ZBYJmvE1Sc6
	 TvbJPllsuqGA6lZ/VkkXUED/An3L54JRyORkapRm2oMViCfw58XtDEHnxjLOzp/6Dm
	 lDL8va/AYSFIMcLCP2VuHgu2hHgizBxbXKbelA0Sa6zKYh/aRslNBJHWsBEQ0YVxjw
	 PhyFGJgRyGKupOnTUET02RUrdWxOlDk+Rdbg/TnfEJXFZ2t+QTtatYdEKxHxslcos5
	 HeORDDFfobWfw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
References: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,wcd934x: Reference
 dai-common
Message-Id: <167810952776.75807.5349861629003654396.b4-ty@kernel.org>
Date: Mon, 06 Mar 2023 13:32:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: 2J2OK5PMOILVMGDBNNHPCDQUWMPQQDPI
X-Message-ID-Hash: 2J2OK5PMOILVMGDBNNHPCDQUWMPQQDPI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2J2OK5PMOILVMGDBNNHPCDQUWMPQQDPI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 20 Feb 2023 10:56:42 +0100, Krzysztof Kozlowski wrote:
> Reference common DAI properties to get sound-dai-cells description and
> allow name-prefix.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,wcd934x: Reference dai-common
      commit: 0106ba2476e1cce06da738a2076a98428a7da2a2
[2/2] ASoC: dt-bindings: qcom,wcd9335: Convert to dtschema
      commit: 631b8a8bb448e90764b8d4b6c0f8cdcc97b1e3e4

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

