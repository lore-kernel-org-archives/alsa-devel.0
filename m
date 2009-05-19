From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Tue, 19 May 2009 01:10:35 -0500
Message-ID: <1242713435.8063.200.camel@petrie>
References: <s5h4ovovtwe.wl%tiwai@suse.de> <4A0C0985.9040004@knobbits.org>
	<4A0C0CF3.3000902@knobbits.org> <s5hvdo3vpmu.wl%tiwai@suse.de>
	<4A0C0FC1.1050709@knobbits.org> <s5hprebvozj.wl%tiwai@suse.de>
	<4A0C17AF.8020607@knobbits.org> <s5hfxf7vmok.wl%tiwai@suse.de>
	<1242700732.8063.188.camel@petrie>  <s5h1vqllkp8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6885804047145008040=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 216192462A
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 08:10:47 +0200 (CEST)
In-Reply-To: <s5h1vqllkp8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Michael (Micksa) Slade" <mslade@knobbits.org>
List-Id: alsa-devel@alsa-project.org


--===============6885804047145008040==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uJMO5/O3usZvAtWdaDzw"


--=-uJMO5/O3usZvAtWdaDzw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-05-19 at 07:34 +0200, Takashi Iwai wrote:
> At Mon, 18 May 2009 21:38:52 -0500,
> William Pitcock wrote:
> >=20
> > Hi,
> >=20
> > On Thu, 2009-05-14 at 15:28 +0200, Takashi Iwai wrote:
> > > At Thu, 14 May 2009 23:07:59 +1000,
> > > Michael (Micksa) Slade wrote:
> > > >=20
> > > > Takashi Iwai wrote:
> > > >=20
> > > >     At Thu, 14 May 2009 22:34:09 +1000,
> > > >     Michael (Micksa) Slade wrote:
> > > >=20
> > > >         Swtiched audacious to 24bit.  It very quietly plays a badly=
 distorted version
> > > >         of the song :)
> > > >=20
> > > >     What about aplay with 32bit samples?
> > > >=20
> > > > Seems to work fine.  Also 24bit.  Guess it's audacious' fault.  Pro=
bably.
> > >=20
> > > It's possible that audacious tries to access 24bit, not 32bit format,=
=20
> > > and ctxfi driver has a bug around that.
> >=20
> > Audacious indeed uses 24bit formats.
>=20
> OK, thanks.  Is it 24bit 3-bytes format, or 24bit in 4bytes format?

24bit 3-bytes format.

This is a table of supported formats:

static alsaplug_format_mapping_t alsaplug_format_conv_tbl[] =3D {
    {FMT_S24_LE, SND_PCM_FORMAT_S24_LE},
    {FMT_S24_BE, SND_PCM_FORMAT_S24_BE},
    {FMT_S24_NE, SND_PCM_FORMAT_S24},
    {FMT_U24_LE, SND_PCM_FORMAT_U24_LE},
    {FMT_U24_BE, SND_PCM_FORMAT_U24_BE},
    {FMT_U24_NE, SND_PCM_FORMAT_U24},
    {FMT_S16_LE, SND_PCM_FORMAT_S16_LE},
    {FMT_S16_BE, SND_PCM_FORMAT_S16_BE},
    {FMT_S16_NE, SND_PCM_FORMAT_S16},
    {FMT_U16_LE, SND_PCM_FORMAT_U16_LE},
    {FMT_U16_BE, SND_PCM_FORMAT_U16_BE},
    {FMT_U16_NE, SND_PCM_FORMAT_U16},
    {FMT_U8, SND_PCM_FORMAT_U8},
    {FMT_S8, SND_PCM_FORMAT_S8},
};

William

--=-uJMO5/O3usZvAtWdaDzw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoSTVgACgkQoB+26npOQg6ETgCfbhhARGmZSO/qxt1Pt29B42Ek
GMYAn0cEjkSNA1FsnWRjG5I0CjL7U2ki
=Xr0D
-----END PGP SIGNATURE-----

--=-uJMO5/O3usZvAtWdaDzw--


--===============6885804047145008040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6885804047145008040==--
