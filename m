From: Jochen Voss <voss@seehuhn.de>
Subject: Re: M-Audio Revolution 5.1 support status
Date: Sun, 10 Sep 2006 23:45:41 +0100
Message-ID: <20060910224540.GD2749@tarte.seehuhn.de>
References: <20060907231004.GA2607@tarte.seehuhn.de>
	<s5hfyf2cv11.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0315642352=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyf2cv11.wl%tiwai@suse.de>
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
Cc: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0315642352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Fri, Sep 08, 2006 at 04:06:34PM +0200, Takashi Iwai wrote:
> > 2) Bug #312 is still present: the left channel is mute on start-up.
> > This is also triggered by unloading and then reloading the ALSA
> > modules.  No idea what to do about this.
>=20
> My guess is that this is a generic problem, possibly in i2c
> communication since this occurs not only on revo 5.1 but also on revo
> 7.1.  Still I don't figure out what is wrong, though.=20

Maybe it is some annoying timing problem, i.e. that the driver starts
writing to the chip before it is ready?

> They are routing tables on vt1724.  The real names of these controls
> are "H/W Playback Route", and "Playback Route" is omitted by the mixer
> abstraction layer.
>=20
> Each channel is indicated with index numbers because the output analog
> channels might be non-bundled, just independent mono outputs.  Also
> the driver keeps generic names there.  That's why 'H/W' is used.

Couldn't the names be modified so you could see from the name which
control is for the rear left speaker?

> > Also I find it a but suspicious that there is only one "PCM Out" value
> > and not "PCM Out L" and "PCM Out R".
>=20
> If you choose PCM as a playback source, you have no option to choose
> left or right.  The certain channel is always bound to the certain
> output. [...]
Oh, ok, after looking at the diagram in the Envy24HT spec again, I see
what you mean.

> VU meters are read-only, so you cannot change the values.
> However, basically they shouldn't appear on alsamixer.  [...]

This would need to be changed in alsamixer then?

All the best,
Jochen
--=20
http://seehuhn.de/

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBJWUf+iD8yEbECURAq8pAKDAMbeU8ml5qM7pJ6+rRHOsg8iclwCgl2Cg
gHF5AFZCVOvatjcYCo2bG/4=
=QhNs
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--


--===============0315642352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0315642352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0315642352==--
