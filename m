From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: OSS4 X-Fi driver port to ALSA
Date: Fri, 07 Mar 2008 10:59:01 -0600
Message-ID: <1204909141.2939.76.camel@petrie.sacredspiral.co.uk>
References: <1202160350.3719.76.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
	<s5h8x1ytuku.wl%tiwai@suse.de> <47A99513.1040906@superbug.co.uk>
	<47C40F55.3060609@superbug.co.uk>  <s5hve4bua14.wl%tiwai@suse.de>
	<1204035157.9659.657.camel@petrie>  <47D061EC.6010102@superbug.co.uk>
	<1204839432.2939.22.camel@petrie.sacredspiral.co.uk>
	<47D1701C.3050403@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6972206742343121405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129]) by alsa0.perex.cz (Postfix) with ESMTP id C7CFD2462C
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 17:58:55 +0100 (CET)
In-Reply-To: <47D1701C.3050403@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6972206742343121405==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VVNq459aAz4mXt+kcORq"


--=-VVNq459aAz4mXt+kcORq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2008-03-07 at 16:41 +0000, James Courtier-Dutton wrote:
> William Pitcock wrote:
> > Hi James,
> >
> > On Thu, 2008-03-06 at 21:28 +0000, James Courtier-Dutton wrote:
> >   =20
> >> William Pitcock wrote:
> >>     =20
> >>> Hi,
> >>>
> >>> On Tue, 2008-02-26 at 14:23 +0100, Takashi Iwai wrote:
> >>>       =20
> >>>> Will anyone start porting from OSS?  It doesn't look like so much
> >>>> amount of codes...
> >>>>
> >>>>         =20
> >>> I intend to port from OSS soon. I just need to learn more about the
> >>> driver's internals.
> >>>
> >>> William
> >>>
> >>>       =20
> >> I now had some datasheets for the x-fi.
> >> I think the first thing we should do is create a GPL version of the
> >> header files.
> >> Shall I do that task?
> >>
> >> James
> >>
> >>
> >>     =20
> >
> > Yes! That sounds great. I have two different X-Fi cards, so let me know
> > when you have the headers ready, and we can merge them into the OSS4
> > driver as an initial effort. That way everything we have is
> > theoretically free. I'll have to recheck what is in OSS4 though.
> >
> > William
> >   =20
> Why put it into OSS4?
> I would put it into the alsa-driver hg repository as a new driver.
> The header would go into the alsa-driver include dir.
> Then, start by writing a new alsa driver to just playback to the front=20
> speakers with possibly a volume control.
> Once we have that in alsa-driver working, we can then add features=20
> gradually.
> I don't think we will be able to use the OSS4 code, that is only really=20
> useful as a reference.
>=20

I concur that putting it into OSS4 is a waste of time. There are other
files marked as not being GPL. So, we need to start from scratch.

William

--=-VVNq459aAz4mXt+kcORq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH0XRVoB+26npOQg4RAhsbAJsFuAJmgDxhJ5ObKaTVX38bU4M5RgCfbkbB
KiraTzuiZCAVqqZ0UBDFbQk=
=9xZD
-----END PGP SIGNATURE-----

--=-VVNq459aAz4mXt+kcORq--


--===============6972206742343121405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6972206742343121405==--
