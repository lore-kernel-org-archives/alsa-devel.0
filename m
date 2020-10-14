Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E96C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:39:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DE8214D8
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GgWfPvhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DE8214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12F441738;
	Wed, 14 Oct 2020 10:38:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12F441738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602664738;
	bh=p7DcwnPJeVGOS04l26qrhy399p5Z8FMUUEs60lR5ndE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GgWfPvhWgOl11JHQusnp0WL7/fg+0BDb5q54+Vuz0OkHygTpNYEOljpHRrCXwoqSn
	 ELdjShOft74E+RHAHnS5OVIVbVc9ZDsAXmgYacAP06MEtSHoP7/g1jR51hVAgAFAUN
	 V5lJu08ZPyTidiSFmWMmXOMubLm3Aq1N2CFEO09c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3088F8020D;
	Wed, 14 Oct 2020 10:38:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9E0BF8012B; Wed, 14 Oct 2020 10:38:05 +0200 (CEST)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD5D7F8012B
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 10:37:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD5D7F8012B
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 75E1B1C0B87; Wed, 14 Oct 2020 10:37:59 +0200 (CEST)
Date: Wed, 14 Oct 2020 10:37:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: disabling CONFIG_LED_CLASS (SND_HDA_CODEC_REALTEK)
Message-ID: <20201014083758.GB31728@amd>
References: <1e6b1961-9e9b-5f82-86a1-bf838cb68f55@xs4all.nl>
 <d7774b58-caf5-5bd8-845d-a5d45aaef4c6@infradead.org>
 <s5hblh5mele.wl-tiwai@suse.de> <s5ha6wpmei5.wl-tiwai@suse.de>
 <20201014075853.GB29881@amd>
 <056a8933-378f-30f2-c7af-5514d93d3c36@xs4all.nl>
 <20201014081116.GC29881@amd>
 <2be6e184-97d4-a2b1-a500-6ea3528cff37@xs4all.nl>
 <20201014082752.GA31728@amd>
 <9cf705b9-1fca-2445-43de-916b13b9103f@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <9cf705b9-1fca-2445-43de-916b13b9103f@xs4all.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
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


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-10-14 10:34:21, Udo van den Heuvel wrote:
> On 14-10-2020 10:27, Pavel Machek wrote:
> >> One should have thought about stuff beforehand.
> >=20
> > We did. And decided this is best solution.
>=20
> Then the thought process went awry.
>=20
> >> The non-selectability is not my fault.
> >=20
> > It also does not affect you in any way.
>=20
> It does.
> /boot fills up even sooner thanks to this unused code.
> Compiles last longer because of this unused code.

Have you measured how much slower and how much bigger it is? Do you
understand that you propose to make source code bigger and slower to
compile for everyone else?

You are filling my inbox.

> > Feel free to go to the mic LED discussion to see why we did it like
> > this. Then you can come up with better solution for problem at hand.
>=20
> I did not think of forcing code onto somebody. Someone else did.
> This is effectively the effect of the LEDs thing.

Without understanding what was decided and why, this discussion is not
useful.


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+GuOYACgkQMOfwapXb+vJMOACeINaNJ284URcw5rkEnAaaBLD3
AUkAoK9ipT87VRbgXSFTZYc9dMa1g4go
=0WBC
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
