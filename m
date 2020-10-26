Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF685C4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:58:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED158223B0
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uukbDuvQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="spfUEF17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED158223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FA2216AE;
	Mon, 26 Oct 2020 17:57:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FA2216AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603731502;
	bh=XmX6A5dOrT7WqJQna3rzilmb9nV0XqwdxyjS4DZdXEU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uukbDuvQ5n2NTzIVl03eGsoFrZ5C2DQKjciGF+QHZAAtmwAoOl4Vqz6aXfDkyVEkZ
	 pkYI4bd+2Dz71A8k/QHjEfuL8UJ584aOJu0nLIzUM2ip8uULw7ogrtIEYl0erlnsgZ
	 a46BMxhlkSVuld7R5+Mwg2iAOrJoUoyUlvwQSbKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B241F80212;
	Mon, 26 Oct 2020 17:57:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C49ECF80249; Mon, 26 Oct 2020 17:57:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FE14F80086
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 17:57:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FE14F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="spfUEF17"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 546452068D;
 Mon, 26 Oct 2020 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603731444;
 bh=XmX6A5dOrT7WqJQna3rzilmb9nV0XqwdxyjS4DZdXEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=spfUEF175Trz/DmMSvKaULQDVGy2BQTVfG/DiGwdAtV5LCKPP6cO5FUWcwAnwMZ4w
 9+fDwhbMOi3MRBrLCcAMAkH7s7FMjgHWv/oky0Oq2VVsX5FZdOiJ5ier7qwPh+2/td
 BbtxTnJ7dYJCCmEFvg0xITwAZpziohyiWEA1qBck=
Date: Mon, 26 Oct 2020 16:57:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: stm32: dfsdm: remove
 stm32-adfsdm.txt binding
Message-ID: <20201026165720.GG7402@sirena.org.uk>
References: <20201020155709.2621-3-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <20201020155709.2621-3-olivier.moysan@st.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org,
 alexandre.torgue@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com,
 lgirdwood@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
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


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2020 at 05:57:09PM +0200, Olivier Moysan wrote:
> Device tree audio configuration for STM32 DFSDM is already
> covered in the following binding:
> Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> Remove stm32-adfsdm.txt obsolete binding.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+W/+8ACgkQJNaLcl1U
h9CPMgf+KTRCiGSyBxhUE1u/M2akejBvVr7Dx8sFslGtFFE8Iwr2D84zpI3/N+bF
0PYNahj9ur9gfNaKOLzQ+vH43Em59mjbdM5tL+ws97s5KvHDTQHtv4sWwceNG635
eTffbX/qd3MYwtRENfvGG+rMunPntaLfmCA/98Dm/c9NmyIwWL9VB8/HnYfEI/a6
YVTSsn+N6K9mLXTUD4N0CyhcQRxZDCvpgcbwsh2wtQO4xdx4vx174EDfyTT8HZF9
01x2ATDmoFoxsyEe75UQ2umKQ97hTgf0UDT17abwAZGFHTcH3DmvYRnenLxIyVmX
lmfhsylfvgLNnkypJT9lirXhrY7YZw==
=L9DH
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
