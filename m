Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA6C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 15:04:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD92611C1
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBD92611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6266817DB;
	Fri, 15 Oct 2021 17:03:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6266817DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634310244;
	bh=HUZyhXVFtyd+kL3lwYCZY+Spl4v5On1I0ObzJOAiC4Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqBEcm8vzcIkdDtTjwmka/YZ3gLhurv4C0x8rwwQbclLZCpoF2JzuYa5CkqrRU9J5
	 aGdJyX5j8tjP52s7JYATIaTpcKUlBrNsWfgqlu+G/ffExXDbMO84qoJaElVHF8KnSJ
	 2BzsjyuPB8nsQhmZSC6e7WtwLHJwqr+qhuPOZ70I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72324F8025B;
	Fri, 15 Oct 2021 17:03:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37CFBF80269; Fri, 15 Oct 2021 17:03:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26707F80167
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 17:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26707F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q/wSIGWG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AA1D600D4;
 Fri, 15 Oct 2021 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634310179;
 bh=HUZyhXVFtyd+kL3lwYCZY+Spl4v5On1I0ObzJOAiC4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q/wSIGWGEl2/OWZr20i72XN6klWiorQtf9EIvLFZweKKKNbFSFXn5nRWkvKnX+UMZ
 ltA+W5RJeRiqqhqwdjf9cLswODKBvnnWJQ/TIB46snpzjKbwMmpf3WjPGualypOyU3
 k6CNNCI2Ts822EChd9rTV81avQxcmcE828glTZhIwv2yAbPTyfRn0rpACfMYF8RD0D
 v1uALX3gbGqsMcSHeHCXGLE1k9zZdfUGJLEpKxXPP7fsVlp8u/lTObGlrPO6m8+N3c
 tne9Kh4vZVcluhZ+s5R79D2sMEOZdfHZrj8XGbCQcqCYnKd6pPCTdvi3icoiEoOqcO
 NrlrTFQbz42Hw==
Date: Fri, 15 Oct 2021 16:02:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 07/16] ASoC: cs42l42: Correct power-up sequence to match
 datasheet
Message-ID: <YWmYIQGgxFStAA1x@sirena.org.uk>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
 <20211015133619.4698-8-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RZ6HkpV1NsoM41ux"
Content-Disposition: inline
In-Reply-To: <20211015133619.4698-8-rf@opensource.cirrus.com>
X-Cookie: I'm having an emotional outburst!!
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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


--RZ6HkpV1NsoM41ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2021 at 02:36:10PM +0100, Richard Fitzgerald wrote:
> The power-up sequence mandated in the datasheet is:

> - VP must turn on first
> - VA, VCP, VL, in any order
> - VD_FILT after VL

>  static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
> -	"VA",
>  	"VP",
> +	"VA",
>  	"VCP",
> -	"VD_FILT",
>  	"VL",
> +	"VD_FILT",
>  };

If you need the regulators to be turned on in sequence you shouldn't
rely on bulk enable doing it for you - the existing regulator code will
initiate all the enables in parallel and then wait for them all to
complete ramping up so if for example VD_FILT were to ramp more quickly
than the earlier regulators the hardware might notice it getting to
whatever voltage the hardware cares about before them.  The only
sequencing you're getting at the minute is when the enables for the
regulators are toggled and you shouldn't even rely on that.

To get the sequencing guaranteed you should pull VP and VD_FILT out of
the bulk enable and do individual enables for them.

--RZ6HkpV1NsoM41ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpmCAACgkQJNaLcl1U
h9CEHAf+KR9IRwQTLAgF/4BGe7x+ICDnwwxyPG6OAI0gYOK3VLGyJdTrAl6pyCmC
d9/V8fKK5GbXumortiyIEqsnUOkFFyjHpFwyoXDUSA8GR0En5BYLcEAf3jo/WZcx
fIcm5LDQkB2ahkWs2p45x0D77i24pzABdYQXp9HjEqH3Rhkmeh5Uu93hkKn6MPQN
X5Y8aXsHrMdnz6dEAlGtd+0+jmHAu5PYPNalRB6gM0XXCoc+2SEpE1sSanCFlbH3
0LnX2g4iT2yp3r+ABpzWseK5GV4Xvg3C+e3REgOD29pwsoPCzinwhLU/xptbeqeI
Mf8m8gP0yqixU1d5+uz0w4VdcnDZSw==
=Z1lk
-----END PGP SIGNATURE-----

--RZ6HkpV1NsoM41ux--
