Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE5DC3DA7D
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Jan 2023 17:48:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE1E52AAA;
	Tue,  3 Jan 2023 18:47:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE1E52AAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672768080;
	bh=HpEuUON7T/Taa39AKkC9kQKGM4tGcAYDWm8d6gKhEww=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NCk46hxpk+zzl/E+POmjumA1KofjLbsftKpYcbknrYOTr/x5SFPQHUemzcXl3htSK
	 v4u7tiw/ZbbVM5vLgRu5QzGeNckxbVDpKsnRQZdCT4CD2XFHxeZkMuylocxhr1Gyny
	 l5N1W49KVDgYAdQRcS9omuzgi7SqqWz+iWrVUqRI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73EFFF800C0;
	Tue,  3 Jan 2023 18:47:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B902F8047B; Tue,  3 Jan 2023 18:47:09 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8341CF800C0
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2023 18:47:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8341CF800C0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IefW0jsY
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 55487B81062;
 Tue,  3 Jan 2023 17:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C8C433D2;
 Tue,  3 Jan 2023 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672768024;
 bh=HpEuUON7T/Taa39AKkC9kQKGM4tGcAYDWm8d6gKhEww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IefW0jsYXRbKMusfop78CLgIBsW6GonX9SslmNu4evz/hKWH3F3FzN/vFEGORhA9g
 50RsL0ANTl9sKyYWjgMTRMA2m3CrDXymK8WS81gNbpIVIs2NkwQMxuHsXGdWJm+AQ0
 +byzDL000f6Je3jALyR9tDx+ELhCH2sU7Q3/foFXNk0qr62xERZcXCZDPtARipKANo
 jYoYw/8dvRHK24p44Be+rSAWGCvWjNZlXk3IbAPJkPg/OE9J1cy4HZRjUd+SDnu/7n
 LQUHh/hjipjMCzy/zziy+HLGM3JsTwxkyN9TiLxQ5Uu/2oTSEBnlxgnjl2CVX49ahQ
 HNOhwW+7kmoIg==
Date: Tue, 3 Jan 2023 17:46:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RFC PATCH 14/14] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Message-ID: <Y7RqEM+GvBQbmBTb@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-15-quic_wcheng@quicinc.com>
 <f57d8d44-651e-b51d-dd72-bdf15801958f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PO3S68PHtAbTyz04"
Content-Disposition: inline
In-Reply-To: <f57d8d44-651e-b51d-dd72-bdf15801958f@linaro.org>
X-Cookie: So many men
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, bgoswami@quicinc.com,
 mathias.nyman@intel.com, gregkh@linuxfoundation.org, andersson@kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 srinivas.kandagatla@linaro.org, agross@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
 quic_plai@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>,
 linux-kernel@vger.kernel.org, quic_jackp@quicinc.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--PO3S68PHtAbTyz04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 26, 2022 at 01:27:21PM +0100, Krzysztof Kozlowski wrote:
> On 24/12/2022 00:32, Wesley Cheng wrote:

> > +            link-name = "USB Playback";
> > +            cpu {
> > +                sound-dai = <&q6afedai USB_RX>;

> Hmm, that makes me wonder if you really tested the bindings before
> sending? If yes, where is the USB_RX defined?

It was added in patch 2, it's in include/dt-bindings.

--PO3S68PHtAbTyz04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO0ahAACgkQJNaLcl1U
h9AKVQf/fc7Y7J2DCQMq65W+xhq5tWOw1Qchwes0+mWkJqejTVwv6w4CSEKMF2XY
Lod25qJvGe5s/RZXqTFYlJFpL3XpOC/aKU2lMROweZC7uZ5uL33u0WgoIHNcS6eC
mLWEupWXoX0BUYhs2IqmQaScXcAv6A5vyfss0TYYbDUv/0HDJS4hDAI3qE+OPvxH
tcYr+MERsr1SC/UP5kK0mj/KjKziNL7kj3tfAr3cbm6nfNDRm7ZBwcVdUOOYYqmC
lhSRvfVI1sodgqiIwd2SVp6cYTR+M4h7+OTP7gFq2gbq2ZJep6Cwh6OalJXvUFMF
7F1mQP986vnD+xoyCWMU3Dv7uHg+4w==
=aEau
-----END PGP SIGNATURE-----

--PO3S68PHtAbTyz04--
