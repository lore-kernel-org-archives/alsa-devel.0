Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0429CC47DA2
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jan 2024 18:28:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 033B7741;
	Tue, 16 Jan 2024 19:27:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 033B7741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705429686;
	bh=GoV6P97mBKlY0A0OpxO//43jXPc+qh/qWkDvpufu9c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OuyL45hpJVZ8qNL5cwt+smlAtO0wM7rzwVXNU3Oeux583dxB/p03VA9d4hk6hh9mv
	 RqDfe7kATnh2cyCEzdPMSdEBG+TXWijoTMH2aG4NaiS99Ofdl8TQV9OMvTGqK6tesV
	 FqY+f+XbjbU+hMnpHO2/BhOlYLKotRUPgvAAjG+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCD6EF8057D; Tue, 16 Jan 2024 19:27:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70B5AF80587;
	Tue, 16 Jan 2024 19:27:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7721F801F5; Tue, 16 Jan 2024 19:27:28 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 003A2F80074
	for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2024 19:27:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 003A2F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uhYf6t5F
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 8BD6CB80E81;
	Tue, 16 Jan 2024 18:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3F4C433C7;
	Tue, 16 Jan 2024 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429639;
	bh=GoV6P97mBKlY0A0OpxO//43jXPc+qh/qWkDvpufu9c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhYf6t5FgUfLAIryawnsSZ+L2OdC8Nsbx9vp12EvS7On7q9ZjuiUXX9I+1WRSKVp3
	 sdhxCsWqQaZTjH4bOw7ATyxJziuqNLWUOQ0dLRlmqkdL0sulgbrzt/+u2wj+GD4PA/
	 y4Yfid0AFLqXt1u6aNmRY9Rj93kgYaQzV/MBb48i1Ogmu/p8mbEB04gkTJpGiPTuz8
	 QJbKAI9xl1OLPd3TvT/Ji+tPZ1QWyJ4uUN7OuPotOjk53bRIcyM80/CpykZw1I1K8v
	 E3Yb52cLXz8JbfFbJeWOj1BYIgjVEFynEzn4PUaBkGD9Pj4e4GDJETJhfugn+gUx+m
	 OHQxNXYoRYAsQ==
Date: Tue, 16 Jan 2024 12:27:17 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	Banajit Goswami <bgoswami@quicinc.com>, alsa-devel@alsa-project.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>,
	Rob Herring <robh+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios
 for shared line
Message-ID: <170542963664.213464.16983216340118145853.robh@kernel.org>
References: <20240112163608.528453-1-krzysztof.kozlowski@linaro.org>
 <20240112163608.528453-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112163608.528453-4-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: Z7JKTWQKOCMD3CRIJC7ORWK3TWUNF4QV
X-Message-ID-Hash: Z7JKTWQKOCMD3CRIJC7ORWK3TWUNF4QV
X-MailFrom: robh@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z7JKTWQKOCMD3CRIJC7ORWK3TWUNF4QV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 12 Jan 2024 17:36:06 +0100, Krzysztof Kozlowski wrote:
> On newer Qualcomm platforms, like X1E80100-CRD, the WSA884x speakers
> share SD_N GPIOs between two speakers, thus a coordinated assertion is
> needed.  Linux supports handling shared GPIO lines through "reset-gpios"
> property, thus allow specifying either powerdown or reset GPIOs (these
> are the same).
> 
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> If previous patches are fine, then this commit is independent and could
> be taken via ASoC.
> ---
>  .../devicetree/bindings/sound/qcom,wsa8840.yaml       | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

