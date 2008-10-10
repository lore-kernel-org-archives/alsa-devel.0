From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 10 Oct 2008 13:17:32 -0500
Message-ID: <1223662652.5275.10.camel@petrie.sacredspiral.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<s5hzlld6j6u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3694997692761833097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [67.202.90.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C59F24179
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 20:17:53 +0200 (CEST)
In-Reply-To: <s5hzlld6j6u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Ted T. Logian" <tedtheologian@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3694997692761833097==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YT3Wbo7wPkhE/qubmYHH"


--=-YT3Wbo7wPkhE/qubmYHH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

With this patch, the driver does output audio, but the DAC dies and we
only get noise. Going to try to whack at this with a larger hammer, it's
a fairly obvious bug, it just needs some debugging. The noise sounds
like the write pointer is off-by-one; it sort of resembles the source
audio.

Some patches for mixer stuff are coming soon (next few hours
probably)... as well as chip revision detection and some other
niceities.

William

On Fri, 2008-10-10 at 08:46 +0200, Takashi Iwai wrote:
> At Fri, 10 Oct 2008 01:26:15 -0500,
> Ted T. Logian wrote:
> >=20
> >=20
> >=20
> > On Fri, 2008-10-10 at 08:01 +0200, Takashi Iwai wrote:
> > > At Thu, 09 Oct 2008 15:17:58 -0500,
> > > Ted T. Logian wrote:
> > > >=20
> > > > Sorry for the multiple posts, but once I rmmod snd-sbxfi, running m=
ixer does
> > > > fine.  It seems if I have snd-sbxfi loaded and I run alsamixer, it =
locks the
> > > > entire system.
> > >=20
> > > So, do you mean loading the driver itself doesn't lock up?  If so,
> > > it's better than I expected.
> > >=20
> > > Did you run ever PCM playback/capture before that?  This is more
> > > dangerous :)
> > >=20
> > > Also, please give your hardware details, as there are different model=
s
> > > for X-Fi, and some are handled pretty differently.
> > >=20
> > > [BTW, please stop top-posting, and avoid HTML mails for ML.  It's eas=
y
> > >  to switch to normal (plain) mail mode on Gmail, just a click.]
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> >=20
> >=20
> > I think perhaps from uninstalling pulseaudio I got further.  I can use
> > mixer now, and it even has a "Master" device, but nothing else...
> >=20
> > however, I do get a lock up later.
> >=20
> > I get this from running aplay, too, if this helps...
>=20
> Thanks!  That's rather a stupid bug.
> The patch is below.
>=20
>=20
> Takashi
>=20
> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> index 8066bf4..8a0eea0 100644
> --- a/sound/pci/sbxfi/sbxfi.c
> +++ b/sound/pci/sbxfi/sbxfi.c
> @@ -831,7 +831,7 @@ static struct sbxfi_port *sbxfi_port_alloc(struct sbx=
fi *chip,
>  	port->src[0] =3D src;
>  	port->src[1] =3D src + 1;
>  	spin_lock_irq(&chip->port_lock);
> -	list_add(&chip->port_list, &port->list);
> +	list_add(&port->list, &chip->port_list);
>  	spin_unlock_irq(&chip->port_lock);
>  	return port;
>  }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

--=-YT3Wbo7wPkhE/qubmYHH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI75w8oB+26npOQg4RAttcAKCCtkFPuy2voHts5+5KF5RnyqIlHgCgxSTx
0y5AcwQ59yTiNSRA+woign8=
=tYuL
-----END PGP SIGNATURE-----

--=-YT3Wbo7wPkhE/qubmYHH--


--===============3694997692761833097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3694997692761833097==--
