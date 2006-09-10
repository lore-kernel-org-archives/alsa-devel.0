From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Sun, 10 Sep 2006 23:38:37 +0100
Message-ID: <20060910223837.GC2749@tarte.seehuhn.de>
References: <s5h8xkyk631.wl%tiwai@suse.de>
	<20060905192453.GA2537@tarte.seehuhn.de>
	<s5hr6yokmym.wl%tiwai@suse.de>
	<20060907102954.GA17846@localhost.localdomain>
	<s5hirk0klu9.wl%tiwai@suse.de>
	<20060907110027.GA3030@tarte.seehuhn.de>
	<s5h7j0flu3v.wl%tiwai@suse.de> <s5h8xkvg245.wl%tiwai@suse.de>
	<20060907221844.GA7188@tarte.seehuhn.de>
	<s5hr6ymd4xq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1071873661=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6ymd4xq.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1071873661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Fri, Sep 08, 2006 at 12:32:33PM +0200, Takashi Iwai wrote:
> > One remaining problem: Unfortunatly left and right volume are
> > exchanged when recording.  When I record with the setting above (using
> > arecord) and then replay the recording with aplay all the sound comes
> > from the left (!)  speaker.
> >=20
> > I reactivated my register write spying patch and got
> >=20
> >     reg4 <- 00
> >     reg5 <- 98
> >=20
> > for the setting above.  So the actual register writes seem to be ok.
> > It seems that register 5 corresponds to the left channel (and 4 to the
> > right channel) on the revolution 5.1 card.
>=20
> Hm, this is a bit weird.  Could you double-check this?

I did now and the result seems repeatable.  Maybe we should try to
find another REvolution 5.1 owner to double check (to make sure that
it is not just a weird defect of my card or so).  See my recent mail
to the list for details.  Any hints on what else I could try would be
most welcome.

> > Otherwise everything seems fine.
>=20
> OK, I committed the patch to ALSA HG tree now.

Thank you.

> > [ ... ]
>=20
> The code above is for the cases with multiple codecs, i.e. when two or
> more AK5365 codecs are connected to a single controller.

Ok, I see.

All the best,
Jochen
--=20
http://seehuhn.de/

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBJPtf+iD8yEbECURAuvhAJ4pK37i1OVVFVOf6ufeBUuKdzO3RwCgygB5
sKUKs7a0HaL+dkCwBbAQ1Ck=
=Dqom
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--


--===============1071873661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1071873661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1071873661==--
