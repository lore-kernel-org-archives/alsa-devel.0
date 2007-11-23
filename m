From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add number of periods constraint to
	snd-aoa [try 3]
Date: Fri, 23 Nov 2007 21:23:11 +0100
Message-ID: <1195849391.4149.154.camel@johannes.berg>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
	<1195822183.4149.118.camel@johannes.berg>
	<s5h63ztt6uu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1596583763681255879=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id CE98C246E3
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 21:23:39 +0100 (CET)
In-Reply-To: <s5h63ztt6uu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Heikki O Lindholm <holindho@cs.helsinki.fi>
List-Id: alsa-devel@alsa-project.org


--===============1596583763681255879==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VeAaMME4yFDeMvx4a5Df"


--=-VeAaMME4yFDeMvx4a5Df
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-11-23 at 14:43 +0100, Takashi Iwai wrote:
> At Fri, 23 Nov 2007 13:49:42 +0100,
> Johannes Berg wrote:
> >=20
> > > +	if (err < 0) {
> > > +		result =3D err;
> > > +		goto out_unlock;
> > > +	}
> > >  	list_for_each_entry(cii, &sdev->codec_list, list) {
> > >  		if (cii->codec->open) {
> > >  			err =3D cii->codec->open(cii, pi->substream);
> >=20
> >=20
> > So what I'm not sure on... Why do we see the same behaviour with other
> > drivers? Same bug?
>=20
> Which driver?  It should be fixed as well, then.

snd-usb-audio I think. Was there any further debugging between you two
that I missed? with the dummy driver?

johannes

--=-VeAaMME4yFDeMvx4a5Df
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0c2raVg1VMiehFYAQKSzQ/+NDbFaYOrqLxy3TRX61vs3Ae9I/oVVnzM
PhZe4G9V6Kb8V+rQIlibmZsg+X4eIEAffRYZTKrRkp8vlH6pPxy4J2lftzkG7gpG
WDZGA20RNwXuXnO1bNtl22rJBZ+s8HShO61//uIn9llezjdClZmkzkvuxlsyOygv
X0ujVcqYvxOm/hsanOK9e5bwgeLem5QmYMrf/CpyO5VwmEA+IOcm0dk0JuX3zeCh
GRR0vpj+tKxtz0ctrc3jZkyQgZQYoLLlNQZeF4567lf/SiVLcbkTy4dtEJ81Qbid
KVGmRCrp2YArdZJNhRPvWYybiRolegZPK+g7tCur6EHfaDxt1r+9t/ZirxR98iHA
4PO5A/JHKSbX6U2PkpuW26vLTvmld9AgH6hQkPO/Yz/cefKdH87MJmXp/iDJbjwW
/GMegfiZmbx1COYNQW/52wuE3Lyo8qeuoz4MAVMjPup/frcTYYA1D9r00X/dbQ5Q
5vo9rVNyGqdEKTEZY9/HFDxvjNldgkN6eBRK5xUVVZMLutxZ8Xk3wPHoPs6eVXJs
JDIt0zVTcUhlBtRRPn1LjpuwKZCpJmnWa1199Zt+NClOKWnxS97CUGbcnbmv2D4g
Tvj6SWIIuojpWdmNK+MKs7P9NQKmECnHm8gmwqHfqJmW47g7ze0uVg+JCUNFcfa6
FrebzMHxOuY=
=5w/T
-----END PGP SIGNATURE-----

--=-VeAaMME4yFDeMvx4a5Df--


--===============1596583763681255879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1596583763681255879==--
