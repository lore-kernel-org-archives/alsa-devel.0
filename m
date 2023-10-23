Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDDAC001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 16:52:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FA4784A;
	Mon, 23 Oct 2023 18:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FA4784A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698079943;
	bh=onD/1VpEcq0ar0HLDecxjwDy6/MzmpL5MbWQrVCDEBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=msi8FCX6j/rnu9pBpsbPKvNIxfYOVt5zyEj+eHuu0d8BhUkvmOH8B7JZg/HuoH/Jh
	 31fxCv83fbW8aqG7H+kdVL1NMn+43D3DO3xJ1JSwHHdOn0n0ciAI9t9sC4zsPpkHuV
	 54CqiXsGMZBLf4J6SDFzbnqK14FTdQ6u9I9rGibI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BAED3F80536; Mon, 23 Oct 2023 18:51:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28803F804F3;
	Mon, 23 Oct 2023 18:51:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA85BF804F3; Mon, 23 Oct 2023 18:50:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB535F80134
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 18:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB535F80134
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hsqdITsZ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C9561B81F6F;
	Mon, 23 Oct 2023 16:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D9C433C7;
	Mon, 23 Oct 2023 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698079846;
	bh=onD/1VpEcq0ar0HLDecxjwDy6/MzmpL5MbWQrVCDEBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsqdITsZGRXZSoz8Zen3g5ujFVc6y/NTwK+YshogcOC0pp31XP5VwqgzIUk9Ckl+U
	 iYFIKIAaE+e/5265zv8+3EWhWWxt9rqP8E+ThEnp54xFWyA8HatPPdng+2jO+wfwUb
	 DOPPAwkblPfZrY3e2S4BzQ+e1u9CjhfSs6O/xcYP9WEXwlgk+XMChpcAG4jrPBBKar
	 LoJ4Y27lXUuKte8bEm8IAZ0k9ayEBRndUiUZtwF7zrBW/OTzsa42d0d+jksZgvVxUV
	 47DhkS3ubihHdT9YIzPAI6JmzGetJLfL8+kArjqwsVKtWSyBSSTd7z16C8CaaCv9h0
	 6NAkymk0pHEHw==
Date: Mon, 23 Oct 2023 17:50:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>, bard.liao@intel.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] dt-bindings: audio-graph-port: add ch-map-idx
 property
Message-ID: <20231023-security-tadpole-8b4fd45a96da@spud>
References: <874jihlx44.wl-kuninori.morimoto.gx@renesas.com>
 <87wmvdkiif.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ruNs9TzVbLZc0kVS"
Content-Disposition: inline
In-Reply-To: <87wmvdkiif.wl-kuninori.morimoto.gx@renesas.com>
Message-ID-Hash: RJQBEN3VUYPFM4QNOQSDOWNJRPPNWKTS
X-Message-ID-Hash: RJQBEN3VUYPFM4QNOQSDOWNJRPPNWKTS
X-MailFrom: conor@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RJQBEN3VUYPFM4QNOQSDOWNJRPPNWKTS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ruNs9TzVbLZc0kVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Mon, Oct 23, 2023 at 05:36:09AM +0000, Kuninori Morimoto wrote:
> This patch adds ch-maps property to enable handling CPU:Codec =3D N:M
> connection.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/sound/audio-graph-port.yaml        | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yam=
l b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> index 60b5e3fd1115..47f04cdd6670 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> @@ -19,7 +19,12 @@ definitions:
>      properties:
>        mclk-fs:
>          $ref: simple-card.yaml#/definitions/mclk-fs
> -

Why have you removed the blank line here?

> +      ch-map-idx:

I would rather this be spelt out as "channel-map-index" - although I
don't know if that is the best name for the property, as it seems very
tied to a single operating systems variable names.
I'll leave it to Mark as to whether there is a less linux implementation
coupled name for this property.

> +        description: It indicates index of ch_maps array for CPU / Codec=
 if number of

=46rom a bindings perspective, "ch_maps array" is meaningless, as it is
(AFAICT) a linux driver variable name, whereas the property description
needs to describe the hardware alone.

> +          CPU(N) / Codec(M) DAIs were not same in one dai-link. ch-map-i=
dx is not needed if the
> +          numbers were 1:M or N:1 or N=3DM. see soc.h::[dai_link->ch_map=
s Image sample] and

Again, relying on header files in an operating system to explain the
property is not a runner. You need to explain how to populate this
property in an operating system independent manner.

> +          ${LINUX}/sound/soc/generic/audio-graph-card2-custom-sample.dts=
i. It is good sample.

I'd much rather you added an example to this dt-binding, rather than
pointing off to another location. A proper example will also be able to
be validated by dt-binding-check.

> +        $ref: /schemas/types.yaml#/definitions/uint32-array

Blank line here please.

Cheers,
Conor.

>    endpoint-base:
>      allOf:
>        - $ref: /schemas/graph.yaml#/$defs/endpoint-base
> --=20
> 2.25.1
>=20

--ruNs9TzVbLZc0kVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTakYgAKCRB4tDGHoIJi
0o3/AQDhRJS/mOXWB4AdVYiKnbnsld3CgR0HRZKljGI0juJ5LgEA4P9TomOoqcoB
QcFUcKrr9v4ReivCcvCrmLVUs0TCcQ0=
=q5jM
-----END PGP SIGNATURE-----

--ruNs9TzVbLZc0kVS--
