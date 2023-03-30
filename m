Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B20BC6FD1D
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Mar 2023 11:15:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C4C01F1;
	Thu, 30 Mar 2023 13:14:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C4C01F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680174901;
	bh=ukBEhWrw/ajFJGkVU2++82d/hl2/pJctfu+fiaMHW7I=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F/IH9Xdc8mXTTXvvRn66tOe4qpIgKqPEvYbLyKH6TQdEx3wg6W371lVFLhHJWJDne
	 zaJKX48osYkcFcBi/HR/X2CzBREezb6jFlOdS0uVZTnC5xBBM/FP21R5lapw3ldIke
	 n3kCIPB4sPDxXT/JPhqk+AOKjV6GW5Atwg3+xkFA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 146F2F80272;
	Thu, 30 Mar 2023 13:13:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77CE6F80272; Thu, 30 Mar 2023 13:13:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4BB3F80249
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2023 13:13:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4BB3F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a7LcQIvb
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A9A1D6200B;
	Thu, 30 Mar 2023 11:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C1C433EF;
	Thu, 30 Mar 2023 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680174811;
	bh=ukBEhWrw/ajFJGkVU2++82d/hl2/pJctfu+fiaMHW7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7LcQIvbyx7HpDMExhi0iZUT+YkyF6a8Ahe17BEHusojPX7S8t7ZhOnRBnYTgF6+3
	 d91W6s+c8uv75MVWCsIjmTI8WKR63Ki65wdRLalRWD9Kuxr34MMMdfxd2NoBcy7K05
	 TS5JyobUdu8koooM2vi/ffjuEbrVQESlPWeOg1YInAsImoUx7co19tEbRgEayYgUjE
	 XyL8QwH0cxRH0Ldxp48VFEQKA2U/vRTV8MgzghQ6Jh2irGTXeZ/KY7KQwAIBdfOY0F
	 WWKH8Tv94CrI/MqWMNV/Q6PRQWwCwYfUOsbhWbx3HGdBmnGGZsQ/3sC1LTM8+iydCu
	 GBGf3QK/3bHzw==
Date: Thu, 30 Mar 2023 12:13:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 07/10] ASoC: dt-bindings: qcom,lpass-va-macro: Add
 missing NPL clock
Message-ID: <ZCVu11dHay8ktiRl@sirena.org.uk>
References: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
 <20230327132254.147975-8-krzysztof.kozlowski@linaro.org>
 <3bb3f40f-39da-2fe6-f5ca-2848a9e5c49b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IsDYuCYOQLYYOx2V"
Content-Disposition: inline
In-Reply-To: <3bb3f40f-39da-2fe6-f5ca-2848a9e5c49b@linaro.org>
X-Cookie: Single tasking: Just Say No.
Message-ID-Hash: JUCEOJL5B7ITWVZT3FBQFMQMUXEJIPSF
X-Message-ID-Hash: JUCEOJL5B7ITWVZT3FBQFMQMUXEJIPSF
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
 Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Patrick Lai <quic_plai@quicinc.com>, Rob Herring <robh+dt@kernel.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JUCEOJL5B7ITWVZT3FBQFMQMUXEJIPSF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--IsDYuCYOQLYYOx2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 08:59:12AM +0200, Krzysztof Kozlowski wrote:

> It seems you applied v2, not v3, so this patch is missing and the
> binding needs fixes.

I'd queued v2 already when you sent v3, and you're sending a lot
of serieses right now.

--IsDYuCYOQLYYOx2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQlbtMACgkQJNaLcl1U
h9AXegf/RDW+9ZdRUx8ufviZmnmZibB7wVYT4S9MOFBHzXu5Xs9hFd60Nl2uhGsi
VloXjO2lGlAuStck5I02NIMUNC1kEP/YExTGWadOY92CggJTGsUxhf4OGPKh5ib4
bDn37PhNH6IRdcH/rNTSyLmzxqWkrPt610U7gdgsLAjB6JYIT2lREX6ZqW3Ssizw
Qvq7IUXtcrs7DFEahV3ipkhBHB+RpZz++k0kWS42IlQo4Ij8pGanusKT5f5gzPoz
rYEEkTmIZWyUzUPkBa22IE7ROpvkyc+dCaYfAyLhBOBBq7TVn6JfQErggPhridD/
/S7VdzM5YXqVgwVHI/1nwAnvoumvNQ==
=NJ5a
-----END PGP SIGNATURE-----

--IsDYuCYOQLYYOx2V--
