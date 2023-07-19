Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAAAC0015E
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 22:02:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01D44207;
	Thu, 20 Jul 2023 00:01:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01D44207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689804119;
	bh=sOL4QJ8Up3hlV7T9f3HrCxwumWrI72GRQ9N+y83we14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bFqeQ9NR/ANOO802R18IDSreAO4o1wf+Xm0zrBMOAwQQ34ULXFTCQ4eTSmmrhQKVq
	 +8XANF3e5s9/O1Hrl1ucyJrbEAV5CZSS+nsCbe+feJI7jhQ3qJbQ+9rlEqSBjAvKTa
	 n1E68Ki5si8QjhGH67FpBjyM+SV9MsCn4V8KoZhA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCB68F8027B; Thu, 20 Jul 2023 00:00:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 64FB7F80535;
	Thu, 20 Jul 2023 00:00:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D746F80535; Thu, 20 Jul 2023 00:00:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 412EEF8027B
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 00:00:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 412EEF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Av+C/wUw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEE761857;
	Wed, 19 Jul 2023 22:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D79C433C9;
	Wed, 19 Jul 2023 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689804012;
	bh=sOL4QJ8Up3hlV7T9f3HrCxwumWrI72GRQ9N+y83we14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Av+C/wUwsYPZRoX6SyEwedo+ATgiMEuFG+K9PeNZaO8/OOXhZdOz+dNGf75P+/w7e
	 Xf7AAacy6Excho/Za5K1J6b7hVQeou6BH1m7OHzHaPy1wiCY45oSXq+P4rtPf396gC
	 p8Jb0YdRNBJm51g9crvtfx25+Vukc4IgouIWvtjmS68GcdMWNbjQuGadtiWt3qS4Px
	 XmVwLrua+ndMOb1n5LxA8QTHiJpQsrRBkRY2dE3Nes5SpFT3LwxWjhOS701d9Ehq0n
	 qQhAibuDc4klStKPhfTIcdSW9Mk6R3OcweDJ0E9yUPD0F90P3/KI5210XxU+6/fkV+
	 fi/CKUj2ty7fA==
Received: (nullmailer pid 852942 invoked by uid 1000);
	Wed, 19 Jul 2023 22:00:09 -0000
Date: Wed, 19 Jul 2023 16:00:09 -0600
From: Rob Herring <robh@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/6] ASoC: dt-bindings: pm8916-analog-codec: Drop
 pointless reg-names
Message-ID: <168980400907.852867.15301265985147515272.robh@kernel.org>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
 <20230718-pm8916-mclk-v1-2-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-pm8916-mclk-v1-2-4b4a58b4240a@gerhold.net>
Message-ID-Hash: 6IXYOHMWVSNIMWB5ZEKRFJEQJSE2RFAW
X-Message-ID-Hash: 6IXYOHMWVSNIMWB5ZEKRFJEQJSE2RFAW
X-MailFrom: SRS0=QU89=DF=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6IXYOHMWVSNIMWB5ZEKRFJEQJSE2RFAW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 18 Jul 2023 13:40:14 +0200, Stephan Gerhold wrote:
> pm8916-wcd-analog-codec has just a single reg region, so having a name
> for it provides no additional value.
> 
> Drop it completely from the schema and example. There is not really any
> point in keeping it (even as deprecated) because it was never used. In
> old DTBs it will just be ignored as before.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml      | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

