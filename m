Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EA6C3DA61
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jul 2024 18:27:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8ED4F1ED;
	Mon, 29 Jul 2024 20:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8ED4F1ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722277624;
	bh=WEp7MKcDizDCCmWrtrmzawwxKIgA8pq0VK4KYR7wRv8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nveQDUfgP8T/y+Pun0iloQ7hN5CzK4RyXnWy79v5F3C/iHUHO1YKtJM6fNhvhRA6k
	 TqK3nSdGSeYU0kDdESWUMTn2aZmlEXOleXIo9HRaMwt1puAYukd920uWfQenCgHpKz
	 WEns97rx9nY8vu99juZWAtueI+gKqP8L7piYmik0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12FFCF805B4; Mon, 29 Jul 2024 20:26:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 60C6EF805B5;
	Mon, 29 Jul 2024 20:26:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E487F80448; Mon, 29 Jul 2024 19:17:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60005F8026A
	for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2024 19:17:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60005F8026A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EYS0dRUW
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8966A61BC2;
	Mon, 29 Jul 2024 17:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9012DC4AF09;
	Mon, 29 Jul 2024 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273448;
	bh=WEp7MKcDizDCCmWrtrmzawwxKIgA8pq0VK4KYR7wRv8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EYS0dRUWWI54YiZjUGYaFWirms4lFG4IfgpKnfBF2LMiggAKMgGD/zVDhcqSo8/+8
	 4Se4G83nFa+yz6UmhKS0kNzh1xhhtxVNNLdRkwy/O4YEHssomQqZ0FlxWyu/sWp/Lj
	 pxBa719WjOCD1iLZHb3nCOSb/tNPx210XsVCpehqoPBfgw60s1Oscfmi7of1u0LBfB
	 ircXZ2C7hryyk4IijVwlXXAVAsXNbZquATXjuJcA9MP7S8eK07lawacEbNZQ3Tmx3q
	 N/fsmqz7oq9o0G1YPfRTAoBgf9F7O2wPE0QaTAiqPXOVEO3ta5eHDAvNwJTEmFmLrk
	 zXQL7ual5KcvQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <20240723083300.35605-1-krzysztof.kozlowski@linaro.org>
References: <20240723083300.35605-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,apq8016-sbc-sndcard: move to
 separate binding
Message-Id: <172227344531.109775.3516537789525186479.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: NLZ3DYZ6Y2CI74GFE4OZ43Y23WXFBLXI
X-Message-ID-Hash: NLZ3DYZ6Y2CI74GFE4OZ43Y23WXFBLXI
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NLZ3DYZ6Y2CI74GFE4OZ43Y23WXFBLXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 23 Jul 2024 10:33:00 +0200, Krzysztof Kozlowski wrote:
> The APQ8016 SBC and MSM8916 QDSP6 sound cards are a bit different from
> others: they have additional IO muxing address space and pin control.
> Move them to separate schema, so the original qcom,sm8250.yaml will be
> easier to manage.  New schema is going to grow for other platforms
> having more of IO muxing address spaces.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,apq8016-sbc-sndcard: move to separate binding
      commit: 8716bd241fa120aacce5e0136125b7ecc74fe3b2

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

