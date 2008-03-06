From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: OSS4 X-Fi driver port to ALSA
Date: Thu, 06 Mar 2008 15:37:12 -0600
Message-ID: <1204839432.2939.22.camel@petrie.sacredspiral.co.uk>
References: <1202160350.3719.76.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
	<s5h8x1ytuku.wl%tiwai@suse.de> <47A99513.1040906@superbug.co.uk>
	<47C40F55.3060609@superbug.co.uk>  <s5hve4bua14.wl%tiwai@suse.de>
	<1204035157.9659.657.camel@petrie>  <47D061EC.6010102@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8071133760493500961=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id ECF0E103861
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 22:37:13 +0100 (CET)
In-Reply-To: <47D061EC.6010102@superbug.co.uk>
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


--===============8071133760493500961==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WrckWOY+LemFvnL1rKXq"


--=-WrckWOY+LemFvnL1rKXq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, 2008-03-06 at 21:28 +0000, James Courtier-Dutton wrote:
> William Pitcock wrote:
> > Hi,
> >=20
> > On Tue, 2008-02-26 at 14:23 +0100, Takashi Iwai wrote:
> >> Will anyone start porting from OSS?  It doesn't look like so much
> >> amount of codes...
> >>
> >=20
> > I intend to port from OSS soon. I just need to learn more about the
> > driver's internals.
> >=20
> > William
> >=20
>=20
> I now had some datasheets for the x-fi.
> I think the first thing we should do is create a GPL version of the=20
> header files.
> Shall I do that task?
>=20
> James
>=20
>=20

Yes! That sounds great. I have two different X-Fi cards, so let me know
when you have the headers ready, and we can merge them into the OSS4
driver as an initial effort. That way everything we have is
theoretically free. I'll have to recheck what is in OSS4 though.

William

--=-WrckWOY+LemFvnL1rKXq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH0GQIoB+26npOQg4RAm8LAKDVikuPdFBhCNlGKRzDGtPLoIywuwCgmOoL
hrwNPeVxlFUFyhKo6WfYt/A=
=sYI2
-----END PGP SIGNATURE-----

--=-WrckWOY+LemFvnL1rKXq--


--===============8071133760493500961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8071133760493500961==--
