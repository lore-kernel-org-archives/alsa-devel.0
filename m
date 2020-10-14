Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4D1C433E7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:14:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E985D2072D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R2NeXXfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E985D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F81216E0;
	Wed, 14 Oct 2020 10:13:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F81216E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602663244;
	bh=9vHEikThE6lNTE3k2fOB5fl0rf0B9V1x+diidtcPp10=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R2NeXXfn+ihB12u3CKf+i2Ke+tHTjsfQTkg6H03wKR+rX5Zanu8WPwfedruCHLFKt
	 mcvVeDPnFS5I4vV//bW9HTCNkCUMhCrDHI5Y8IHPdjgfJdVs/z46D8Dz8/RTwk3oeA
	 Dw4obcD8GARLO8TH4TQ2u5x3MQ3mRFWr6Qy6ijuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF73AF8020D;
	Wed, 14 Oct 2020 10:13:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1152F80217; Wed, 14 Oct 2020 10:13:12 +0200 (CEST)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08C2AF800F6
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 10:13:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08C2AF800F6
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id C8CE41C0B87; Wed, 14 Oct 2020 10:13:05 +0200 (CEST)
Date: Wed, 14 Oct 2020 10:13:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: disabling CONFIG_LED_CLASS (SND_HDA_CODEC_REALTEK)
Message-ID: <20201014081305.GD29881@amd>
References: <3c6d174c-30db-3d03-3d16-42df405f38d9@xs4all.nl>
 <58e774c5-fc80-2060-2091-9a6398582cc5@infradead.org>
 <9fc679e9-e9a9-ad80-b24c-f04489b98aa7@xs4all.nl>
 <27e159be-4376-e87b-5e60-803bc3749ec2@infradead.org>
 <eadc23e7-b383-e2fc-6e20-ed22745d0bfc@xs4all.nl>
 <2739e1fd-75c6-4e43-cd79-9028479f91bf@infradead.org>
 <1e6b1961-9e9b-5f82-86a1-bf838cb68f55@xs4all.nl>
 <d7774b58-caf5-5bd8-845d-a5d45aaef4c6@infradead.org>
 <20201014075458.GA29881@amd> <s5h4kmxmdqc.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <s5h4kmxmdqc.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Udo van den Heuvel <udovdh@xs4all.nl>, Dan Murphy <dmurphy@ti.com>,
 linux-leds@vger.kernel.org
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


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-10-14 10:08:27, Takashi Iwai wrote:
> On Wed, 14 Oct 2020 09:54:59 +0200,
> Pavel Machek wrote:
> >=20
> > Hi!
> >=20
> > > >>> I.e.: it looks like I will lose some funcionality when I disable
> > > >>> SND_HDA_CODEC_REALTEK.
> > > >>
> > > >> OK. At present you can't have it both ways, i.e., SND_HDA_CODEC_RE=
ALTEK
> > > >> with no LEDS. That driver apparently wants LEDS.
> > > >=20
> > > > Thanks but why have I gone for years without LEDS?
> > > > I do not need LEDS, I do not want LEDS, I do not have LEDS (that are
> > > > visible, usable, etc).
> > > >=20
> > > > Please make this selectable instead of forcing more bulk into my
> > >> kernel.
> >=20
> > LED core is not that big, and this avoided some rather "interesting"
> > hacks IIRC. If Udo wants more config complexity, lets first make him
> > measure the benefits, second submit a patch.
> >=20
> > But I'd suggest to just live with it.
> >=20
> > And yes, we should probably get rid of "CONFIG_NEW_LEDS" symbol. That
> > one is actually useless.
>=20
> IIRC, this was needed for the reverse selection of CONFIG_LEDS_CLASS
> and co.  But if it's really useless, I'll happily delete it.

It is needed for now. It is just something we should remove in
future. CONFIG options are not that cheap...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+GsxEACgkQMOfwapXb+vKj2wCgl8EFtbg190UseqaqnZEYuRJF
nsYAniWZl08TwB5hCRT99EU4nRv0+Zd+
=Vqx7
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
