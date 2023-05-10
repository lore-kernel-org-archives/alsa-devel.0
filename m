Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB751C7EE22
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 08:17:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D64B1104C;
	Wed, 10 May 2023 10:16:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D64B1104C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683706650;
	bh=WqROl4ggoxtxvCzaJ+imf4UZL/RFubALoWh3+tcl7e0=;
	h=Subject:From:In-Reply-To:Date:References:To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b2ShC4CgdQuH7WHFMzKQ/YQoxqwb42YshVu1pEiOqMckY7eIBalXHDc9VlhXIsqkT
	 eMnaewzF7L/e0r0h2Y1r8Qg5JLKqC8vPm6nvCKEi5BSH/6i9L5V1pHf2hhhSs/2kMh
	 qEy3HurkblCNjPx1Cl5DG/dkmOiwFL2a9CSmdr4Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E74EF8014C;
	Wed, 10 May 2023 10:16:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DE6EF8032D; Wed, 10 May 2023 10:16:08 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7968F8014C
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 10:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7968F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=cutebit.org header.i=@cutebit.org header.a=rsa-sha256
 header.s=mail header.b=SXOkXai4
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
	t=1683706556; bh=VFBjS6KM+BKXoNWSG7Fj0R1+KXXRbEQwP2Vsz5SUkOI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=SXOkXai4EA7lzjaH0yLiw23MJUm4m1M0YlmGT62tM3d7XgHBKPxp9ZWJdlLOKDAhe
	 TXWqLOJzjrH7tmleBvVRXIEb4U221xOdX0NjfbPNF7B3Efvw2FC6F6OQ46opoKZ7NP
	 2MTWp+p9wJlWMRgJsjKfH0hq0YDok5nPaBuNaki0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
Date: Wed, 10 May 2023 10:15:55 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <04BB0158-6C7B-400C-A87A-6E9B2835FDC7@cutebit.org>
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Message-ID-Hash: 37GB4LBZJX2D3DWQNPWUXHFDEDD65YGT
X-Message-ID-Hash: 37GB4LBZJX2D3DWQNPWUXHFDEDD65YGT
X-MailFrom: povik+lin@cutebit.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, asahi@lists.linux.dev,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/37GB4LBZJX2D3DWQNPWUXHFDEDD65YGT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


> On 10. 5. 2023, at 9:51, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 09/05/2023 18:38, Martin Povi=C5=A1er wrote:
>> Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
>> mono amplifier with digital input.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
>=20
>> +  reg:
>> +    maxItems: 1
>> +
>> +  adi,ana-gain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    description: |
>> +      The value to be set in the ANA_GAIN register field on the =
codec. This determines
>> +      the full voltage span of the codec's analog output.
>> +
>> +      To quote the datasheet on the available options:
>> +
>> +        00: 8.4 V Full-Scale Gain Mapping
>> +        01: 12.6 V Full-Scale Gain Mapping
>> +        10: 14 V Full-Scale Gain Mapping
>> +        11: 15 V Full-Scale Gain Mapping
>> +
>> +  '#sound-dai-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - adi,ana-gain
>> +
>> +additionalProperties: true
>=20
> uinevaluatedProperties: false instead, so users can have name-prefix.

I actually tweaked this to have the example passing, which has =
sound-name-prefix,
which I guess is what you have in mind. Not that I exactly understand =
what these
options do (both additionalProperties and unevaluatedProperties), the =
schema docs
didn=E2=80=99t enlighten me right away when I looked into it.

If 'unevaluatedProperties: false' is the way to go here, I will change =
it.

Kind regards,
Martin

> Best regards,
> Krzysztof

