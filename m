Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8199C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:26:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16153214D8
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="seyZpSL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16153214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF4A516F0;
	Thu, 12 Dec 2019 15:25:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF4A516F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576160795;
	bh=2bmRvdGrd97HzWyNRhoiy/v1T15GxPfo7IY/HaNEmV4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=seyZpSL99klBMzRlPaGjFznyepzayJ0vI8Ma2TNUTpD5Pd1c5wW93Vc9brwGiWhv5
	 XRbp5bRGd1CI/lQFFzBSuh2I1heuZg9TyMPaIMbHhT824LXO1x3UWh2b+2VGY2DW/G
	 Krn6vdoMjL0WzqNoWow/YFeGisKnVdtVNADqHw14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A9A8F80291;
	Thu, 12 Dec 2019 15:19:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D8B1F8020C; Thu, 12 Dec 2019 11:57:39 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DC57F80139
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 11:57:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DC57F80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D787CAFDF;
 Thu, 12 Dec 2019 10:57:34 +0000 (UTC)
Message-ID: <099cb6558e9a10c1fce73e34484c0eaf21293e61.camel@suse.de>
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 12 Dec 2019 11:57:33 +0100
In-Reply-To: <20191210141356.18074-3-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
 <20191210141356.18074-3-tiwai@suse.de>
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Dec 2019 15:19:28 +0100
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [alsa-devel] [PATCH for-5.6 2/4] staging: bcm2835-audio: Use
 managed buffer allocation
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
Content-Type: multipart/mixed; boundary="===============4881846710827184377=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4881846710827184377==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-KDe450wmkzJFlREF+n28"


--=-KDe450wmkzJFlREF+n28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-10 at 15:13 +0100, Takashi Iwai wrote:
> Clean up the driver with the new managed buffer allocation API.
> The hw_params and hw_free callbacks became superfluous and dropped.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!


--=-KDe450wmkzJFlREF+n28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3yHR0ACgkQlfZmHno8
x/7T1wf9HqdO2587apiYerHZt0Jf/EfpHtnps8r5NNLydl8BXf/nNo9Nnfb7E6vE
tamYcG/rVIzfWZ2aBeIaG1jxrfKwZFrTy8T+djPw4Y94x8HTLf7S+qhJs+ppzFHo
wAF3hzz25fUWCG0z1q2bEQXm4qmc5Irhdy/o9rESwdVF5Z3w+1XGo3J9HIDj4bKw
bKl63amT+yioLN4/cetU9IkEm2TUqKwR3qlH0TZz0EvCiXoOGR2t5kzT92YrROJL
Rxw/PyZ7gqJ4DM6fQ6aWUzo+/p82ASRfrfi0456846zQVShb7zYNAud7fODTsELR
aIt52MtSc3sl2zjH+jbV+U3hRV8Vkw==
=acj8
-----END PGP SIGNATURE-----

--=-KDe450wmkzJFlREF+n28--


--===============4881846710827184377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4881846710827184377==--

