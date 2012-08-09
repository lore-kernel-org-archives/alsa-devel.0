From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] ALSA: hda - Defer probe when loading patch
	firmware
Date: Thu, 9 Aug 2012 09:08:13 +0200
Message-ID: <20120809070813.GA6979@avionic-0098.mockup.avionic-design.de>
References: <1344494723-6827-1-git-send-email-thierry.reding@avionic-design.de>
 <s5hhascft86.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4467547104362246174=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 01072265F2B
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 08:38:36 +0200 (CEST)
In-Reply-To: <s5hhascft86.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============4467547104362246174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 08:57:13AM +0200, Takashi Iwai wrote:
> At Thu,  9 Aug 2012 08:45:23 +0200,
> Thierry Reding wrote:
> >=20
> > Recent changes to the firmware loading helpers cause drivers to stall
> > when firmware is loaded during the module_init() call. The snd-hda-intel
> > module requests firmware if the patch=3D parameter is used to load a pa=
tch
> > file. This patch works around the problem by deferring the probe in such
> > cases, which will cause the module to load successfully and the driver
> > binding to the device outside the module_init() call.
>=20
> Is the "recent" change meant 3.6 kernel, or in linux-next?
>=20
> In anyway, I don't understand why such a change was allowed.  Most
> drivers do call request_firmware() at the device probing time.
> If this really has to be resolved in the driver side, it must be a bug
> in the firmware loader core code.

A good explanation of the problem and subsequent discussion can be found
here:

	http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/49=
975

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI2HdAAoJEN0jrNd/PrOhDKwP/1SfrABxS8nsazGGbX4y0+we
sKoFY1CUzO/0ltXsLWmHKcHvx3ibv/+/MO846z40Eijm/mTCktR/cVVejafufVyp
j2YyjBDLAozBlz0EuiBkD9kVlBFByLtfba1NOrYyQw8u2Nh0nCfbKgbOqHRPSxEI
slqEQPP38cGzdrdEQIYhA8oml2ffFmQHk0q3DIu70S0Zsrs5GZTeQ7m56QUj5suM
hnoTqnPupVadp+rRDpq1wPziogvBtF7tqATNsTZuZpKVJSFH/rB41qWhstx/tVUG
UQdVbHtSEulGGaSafqhgyzvydq+N2EF//ctEifmi9gBE8g09SFCFJlaDxMJsdB5t
m0WXFFL2s59F9iSgpJbYMVY3QD8GeD5FYFX3ZNQbfMvhMGrhEbJA85Dg+4hrQiIW
d4k68DV3HsbrAtrq9L0ijqhL4R8dL/Y3v1FEtxY6Fgm7SiHFZ56mXgJ/F82FR1G6
/Ek8gpqhFNkU+NG2CrlNh8sFTArYh2yUreUjurk0DDRf516qrnACGyJpW4Xme/hr
R5p3H2jqYog71MB+Z3nDtasdgikLNcpcDjHm/bO0pwswAwVUMr6tzo2nmpT81DdM
Uw5Lj8uhbr+POtjh8LdjHNbWflN5HTKpZgJkN+GmpeFHUeyBZrGaqOTLmobXQLQO
ssf8iXC03aPoBg1I+Ej3
=up23
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--===============4467547104362246174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4467547104362246174==--
