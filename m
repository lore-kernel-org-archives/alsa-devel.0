From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: ALSA always writes _whole_ periods, right?
Date: Sat, 16 Jun 2007 23:35:15 +0200
Message-ID: <1182029715.2605.12.camel@localhost>
References: <1181751818.5752.13.camel@localhost> <s5hlkemkefd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2058914132608430984=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 7159F10381F
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 23:35:18 +0200 (CEST)
In-Reply-To: <s5hlkemkefd.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2058914132608430984==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4jrCxch95AwH72cx3DsC"


--=-4jrCxch95AwH72cx3DsC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

thanks for your answer,

On Thu, 2007-06-14 at 12:39 +0200, Takashi Iwai wrote:
> > I have a quick question regarding the filling of the usual ring buffer
> > in RAM (used by sound controllers via DMA), just to be really sure:
> >=20
> > Is it true, that ALSA always writes (via mmap'ing) _whole_ periods?
>=20
> The whole buffer is, of course, used.  Otherwise you'll get obvious
> noises :)
>=20
> But if you're asking about the timinig, then no.  How much data is
> written at which timing isn't strictly defined in mmap mode.  The
> PCM core just checks the available size at each
> snd_pcm_period_elapsed(), and reports XRUN if needed.  That's all.

Ok, ahm, I think my question was not about what I really wanted to know
- sorry. I have to reformulate it: In fact I would like to know, how the
ALSA-library mmap code behaves regarding the last chunk of samples, for
example: Consider aplay, playing a wav file and the wav file's
size/number of samples does _not_ fit to a multiple of a period's size.
Then, does the mmap code copy these last samples as is _or_ does it copy
one whole last period (which is filled with zeros)?

Thanks,
 Joachim


--=-4jrCxch95AwH72cx3DsC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBGdFeTZY86bR8HqNwRAiBTAJ4hO9Y6vMS1FFCGh55g9pzBKF5VBQCaAw/a
tz+Af7wmYoiS+wjZhTkmEGw=
=3Z7A
-----END PGP SIGNATURE-----

--=-4jrCxch95AwH72cx3DsC--


--===============2058914132608430984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2058914132608430984==--
