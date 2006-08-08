From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 18:47:42 +0100
Message-ID: <20060808174741.GA29366@tarte.seehuhn.de>
References: <20060808104015.GA20149@seehuhn.de> <s5h4pwnqydd.wl%tiwai@suse.de>
	<20060808111850.GB2922@localhost.localdomain>
	<s5hzmefpj2o.wl%tiwai@suse.de>
	<20060808114033.GA3784@tarte.seehuhn.de>
	<s5hpsfbpe9t.wl%tiwai@suse.de>
	<20060808163025.GA12347@tarte.seehuhn.de>
	<s5hr6zrfa1s.wl%tiwai@suse.de>
	<20060808172037.GC12347@tarte.seehuhn.de>
	<s5hk65jf83f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1736148156=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk65jf83f.wl%tiwai@suse.de>
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


--===============1736148156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Tue, Aug 08, 2006 at 07:30:44PM +0200, Takashi Iwai wrote:
> > Is the last argument (mask) for AK_COMPOSE the maximum allowed mixer
> > value?  Is it ok if this is not a power of two?
>=20
> Yes and yes.

Fine.  Slowly I am getting there.  Now I have something working,
which uses the following addition to snd_akm4xxx_build_controls:

	if (ak->type =3D=3D SND_AK5365) {
		memset(ctl, 0, sizeof(*ctl));
		if (ak->channel_names =3D=3D NULL) {
			strcpy(ctl->id.name, "ADC Volume");
		} else {
			strcpy(ctl->id.name, ak->channel_names[0]);
		}
		ctl->id.index =3D ak->idx_offset * 2;
		ctl->id.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
		ctl->count =3D 1;
		ctl->info =3D snd_akm4xxx_stereo_volume_info;
		ctl->get =3D snd_akm4xxx_stereo_volume_get;
		ctl->put =3D snd_akm4xxx_stereo_volume_put;
		/* register 4 & 5 */
		ctl->private_value =3D
			AK_COMPOSE(0, 4, 0, 0x98);
		ctl->private_data =3D ak;
		err =3D snd_ctl_add(ak->card,
				  snd_ctl_new(ctl, SNDRV_CTL_ELEM_ACCESS_READ|
					      SNDRV_CTL_ELEM_ACCESS_WRITE));
	=09
		if (err < 0)
			goto __error;

		idx +=3D 2;	/* always stereo */
	}

(I will post a complete patch later today.)

This gives me a beautiful (and working!) volume slider for the capture
channel.  Does this look ok to you?  The magic constant 0x98 is from
page 35 of the spec and I think is correct.  I did not imitate the
loop over idx which other parts of this function have.  I hope that
this is ok.

The card seems to have a separate mute control.  How do I create a
mixer element for this?  I would like alsamixer to place a little mute
box just under the slider bar.  I looked around, but could not find
anything similar to copy within the ice1723 directory.

Many thanks for your help,
Jochen
--=20
http://seehuhn.de/

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2M49f+iD8yEbECURAqIaAKCSljGAkpZIqgU3eHGC9WZNyZK0OgCgymVU
qhmF89IDaAuem6FgD8IyfEc=
=9x5C
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


--===============1736148156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1736148156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1736148156==--
