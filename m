Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EDDC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Apr 2022 11:42:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15C641753;
	Wed, 27 Apr 2022 13:41:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15C641753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651059764;
	bh=OrIoR6u3SU+h0ZVt5IRQbJw+w4d6a9VMedLf55vc1ek=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siemQVT3l4lBagIk1Ksh2qZAesvXnr8o6FjfCHiVN93Hrac72j9hilHQN8j+1Jasa
	 9h+/MrWWedVW6Pu4j7tgTT0MHBpmZdolOTibFA0nzor+g/7C5N7Flq4Xv0c0KgoU6j
	 WUcDUq+zyP81GiUUrLiCib3Mr2gxwXy1Epst8ySY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1F58F80155;
	Wed, 27 Apr 2022 13:41:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E58AF8016E; Wed, 27 Apr 2022 13:41:52 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFEE5F800AE
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 13:41:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFEE5F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Fz7BS3Zi"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9D3CBCE24A2;
 Wed, 27 Apr 2022 11:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D663C385A9;
 Wed, 27 Apr 2022 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651059703;
 bh=OrIoR6u3SU+h0ZVt5IRQbJw+w4d6a9VMedLf55vc1ek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fz7BS3ZinelIjDox9N+q2oOXiMsM9r1j06vk4SxEVg8KHvWYHJa+y5o77a0FGYQDg
 qn190MGwwtSB22raT94F9cLfTYTXJnRBTVIgNiowV1JX/qOvtsn7jVIuVcmwynBZvJ
 FVLHoJuxq0R5x5knYV7TXewXaAYX0ANe6912MY9i0Fzh3xKfFXcRYUTkzy2atWF4GZ
 kA2loD2aXqWou39z1LkwMZsn3GTn7afATfJlizN+NeXLtDkbBcd63In602H8+xCYxC
 WTtqzqWmjuCvNHgUtvyhAKYTDP2TBBYHmKvH2zN433bSp9bbszeb1lo47ft5+Oeba+
 3kX8/dNibxt3w==
Date: Wed, 27 Apr 2022 12:41:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 04/11] dt-bindings: sound: add Arm PL041 AACI DT schema
Message-ID: <Ymkr8dFjbzEonXOO@sirena.org.uk>
References: <20220427112528.4097815-1-andre.przywara@arm.com>
 <20220427112528.4097815-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xEalpJZfvyrIiHuU"
Content-Disposition: inline
In-Reply-To: <20220427112528.4097815-5-andre.przywara@arm.com>
X-Cookie: Buckle up!
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liviu Dudau <liviu.dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--xEalpJZfvyrIiHuU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2022 at 12:25:21PM +0100, Andre Przywara wrote:
> The Arm PrimeCell Advanced Audio CODEC Interface (AACI aka PL041) is
> a peripheral that provides communication with an audio CODEC.

I've got this one individual patch.  What's the story with depenedencies
and cross tree work?

--xEalpJZfvyrIiHuU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpK/EACgkQJNaLcl1U
h9BwnAf9ENkVudoH1sxvPKQlVaixc0WFHUv8wulTouE6pJdR0Ol4eirsXbYIR9If
d3hHsmqdNtSlIdWQXeHuOsGo0Fb0Kdqh9UiU5nXeQOJktVnOvYCoeNa0vpQ9JRiW
ClNNntQO8hkL0W8ymhiS0oZ2GlFhMgSiAyARTMCIwYV5o2lNvblr0dVabYm+Gzgw
4Q6heunJnHt+oUZ+18f8Wp5Aq1lLIxd/LD6XoAg3tb9vRyvo4frAPu4CciLRpckt
cTVzec7tB8fyMfwlcerR0zQG4tXHeuMeALo1hpicYg7WI9XUqzOwvk1Se4mwr68B
TOERYG0uNDeG6kwVZERNJNZnfUWTHg==
=rz/g
-----END PGP SIGNATURE-----

--xEalpJZfvyrIiHuU--
