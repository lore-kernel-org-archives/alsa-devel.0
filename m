From: florin@iucha.net (Florin Iucha)
Subject: Re: [1/4] 2.6.22-rc3: known regressions
Date: Tue, 29 May 2007 09:41:20 -0500
Message-ID: <20070529144120.GC17474@iucha.net>
References: <465C2225.2000100@googlemail.com> <20070529143459.GE25278@duck.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757959AbXE2Olc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070529143459.GE25278@duck.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Thierry Volpiatto <tvolpiatt@neuf.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, linux-fsdevel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Andrey Borzenkov <arvidjaar@mail.ru>
List-Id: alsa-devel@alsa-project.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2007 at 04:34:59PM +0200, Jan Kara wrote:
> On Tue 29-05-07 14:52:53, Michal Piotrowski wrote:
> > Here is a list of some known regressions in 2.6.22-rc3.
> >=20
> > Subject    : Oops in dentry_iput with 2.6.22-rc2 on AMD64
> > References : http://lkml.org/lkml/2007/5/22/4
> > Submitter  : Florin Iucha <florin@iucha.net>
> > Status     : Unknown
>   Actually, the bug seems to be unreproducible and it has probably been a
> 1-bit flip. So I'd be reluctant to call it a regression...

I agree with this statement.  I'll ping Michal and Jan if the oops
resurfaces.

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGXDuQND0rFCN2b1sRAqIhAJ4s/oxJ8GixFXZuJ7FuFLWhuPoelACfYby5
hBfO3k4IafmLhzKeXGBluZI=
=799Z
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
