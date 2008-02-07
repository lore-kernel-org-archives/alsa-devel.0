From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Thu, 7 Feb 2008 23:04:00 +0100
Message-ID: <200802072304.01096.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<200802012202.59047.mailinglists@martin.egge.info>
	<s5hr6foybx8.wl%tiwai@suse.de>
	(sfid-20080207_172440_885022_B88445EE)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8220417792656852530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 5058324661
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 23:04:02 +0100 (CET)
In-Reply-To: <s5hr6foybx8.wl%tiwai@suse.de>
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

--===============8220417792656852530==
Content-Type: multipart/signed;
  boundary="nextPart4460599.ksoRhyx2si";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4460599.ksoRhyx2si
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Donnerstag, 7. Februar 2008 schrieb Takashi Iwai:
> Hi, sorry for the late reply.

No problem.

> At the next time, please add my address to Cc so that I don't miss
> your post...

I'll try to keep this in mind.

> At Fri, 1 Feb 2008 22:02:51 +0100,
> Martin Egge wrote:
> > Am Dienstag, 29. Januar 2008 schrieb Takashi Iwai:
> > > Could you try HG bisect?  It'd be greatly helpful.
> >
> > I've tried HG bisect this evening. It took me some time to discover that
> > the problem is not within alsa-driver or alsa-kernel but within alsa-li=
b.
> > This is the result of HG bisect:
> >
> > The first bad revision is:
> > changeset:   2397:d1e9a2f92e7b
> > user:        tiwai
> > date:        Fri Jan 18 13:42:51 2008 +0100
> > summary:     dmix - Enable auto format detection as default
>
> Thanks for checkign this.  Now the thing gets a bit clearer.
> The problem is explained like this: via "default" PCM, 32bit format is
> chosen now because the analog audio-out widget supports.  But the
> SPDIF out widget doesn't support that format.  Thus it's not played
> properly.

Oh I see, but why has this behavior changed since 1.0.15?

> If my guess is correct, you can propbably get SPDIF output via "spdif"
> output.  What happens with the below?
>
> 	% aplay -Dplug:spdif foo.wav

You are right. Choosing plug:spdif plays the sound cia the SDIF-Out. Of cou=
rse=20
this does not play the sound via the internal speakers when no SPDIF is=20
connected.

But I'd prefer the old behavior from 1.0.15 where the default device was=20
playing sound via SPDIF when connected and via internal speakers when SDIF =
is=20
not connected.

Regards,
Martin



--nextPart4460599.ksoRhyx2si
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHq4BRVG/GfU56d2wRAr+sAJ4qhPrHdMxagKq50hyxQnz7lGWpswCfUgE2
hJ2LmBqdeGf49BnjVlN/Xbs=
=O6ST
-----END PGP SIGNATURE-----

--nextPart4460599.ksoRhyx2si--

--===============8220417792656852530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8220417792656852530==--
