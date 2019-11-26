Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD5BC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:30:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714952071A
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PWzlF8XT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714952071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C89CB1744;
	Tue, 26 Nov 2019 17:29:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C89CB1744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574785835;
	bh=SLdoIxOoXp92502bCsp2dYm/T8xpKMTVxpbyKIV9bLY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWzlF8XTgqNn1kivtlY1dLABflv6Wk/jLKnwx3Mmr1q1hTYGf+9rKQ2e362Sxp+17
	 BwcOK8hE0J3pX8xK7iwGrU9X1UH/2lkFuQs9PI7pwvbKRyXM9G04/2qi4fYOOrlHcd
	 M++IHmITCJ7RauY1reMCxf06iL5ddAbavpxre/f4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 353B7F80149;
	Tue, 26 Nov 2019 17:29:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 685E2F80159; Tue, 26 Nov 2019 17:29:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7912AF800AB
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 17:29:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7912AF800AB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 686F730E;
 Tue, 26 Nov 2019 08:29:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49393F68E;
 Tue, 26 Nov 2019 08:29:36 -0800 (PST)
Date: Tue, 26 Nov 2019 16:29:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191126162935.GB4205@sirena.org.uk>
References: <20191126103404.29534-1-perex@perex.cz>
 <dd238740-f154-a660-2a80-0ada80183dd2@linux.intel.com>
 <32edec86-ec1c-1809-2278-fecac09ac321@perex.cz>
MIME-Version: 1.0
In-Reply-To: <32edec86-ec1c-1809-2278-fecac09ac321@perex.cz>
X-Cookie: Where's SANDY DUNCAN?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel/skl/hda - export number of
 digital microphones via control components
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
Content-Type: multipart/mixed; boundary="===============3853128790834064031=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3853128790834064031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2019 at 02:51:19PM +0100, Jaroslav Kysela wrote:
> Dne 26. 11. 19 v 13:33 Pierre-Louis Bossart napsal(a):

> > Any objections if we take this patch into the SOF tree (without changes
> > to authorship) and provide it on alsa-devel next week with the cleanups,
> > so that we don't have any conflicts?

> I'm fine with that, if we don't miss the 5.5 merge window. Otherwise, you
> may rebase your changes on top. Mark?

You've missed the merge window already - it was open before this patch
was sent.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3dUu4ACgkQJNaLcl1U
h9B/lwf/blUe4s8g4xNnapWxUVDtz8R7l3WsReBNHEY4NpCaWREV51K4VPObfHGA
hHtdyBJMD6128lu13RMVTZpwW7CKwjq4tKyTgl17UXXsCbdnXlflaVukLjvB02UD
IgPxcau1p+viVWHK4CHjLVv/7R4prNQ3a+F0AebFw7yWYq0PgkWKVFREIpBwXLNY
05O49QoZoJo4Z8zLoBxVmmQntATYFr4T30QyjwAJnCRu56becEVhZhUGjlXrSyIc
shWoxq87EdmrXGqadRLZft5vUoQqbTn0ytHvxqeugEv79xyiz2n0WaPxNJpkBACH
AMk0SAkmSAxnjk8qBYAVZlWeBN2B9w==
=MVl1
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

--===============3853128790834064031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3853128790834064031==--
