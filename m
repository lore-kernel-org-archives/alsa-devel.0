From: Stuffed Crust <pizza@fucktheusers.org>
Subject: Re: Inspiron 8200 and the CS4205
Date: Thu, 12 Sep 2002 13:16:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020912171636.GA30317@shaftnet.org>
References: <20020910184038.GA2240@spherenet.dyndns.org> <s5hznunnqp6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hznunnqp6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2002 at 06:00:21PM +0200, Takashi Iwai wrote:
> > Here is what i've learned about all my experiences so far with the
> > Inspiron 8200 and the CS4205:
>=20
> which driver?  maestro3 or intel8x0?
> and which kernel are you using?

I have similar problems with my Inspiron 4100.

It has an ICH3 (i830M -- intel8x0) and a CS4205 codec.

Basically, some apps stutter immediately on playback (kinda like the
helicopter noise he was describing), and others start okay, but sometimes
start and stop stuttering seemingly at random in mid-stream.

in particular, mpg321 (via libao) seems to do this fairly often, while
ogg123 (also via libao) seems to be immune.  SDL apps (using the alsa09
backend) are intermittent, as are a couple of my own creations that hook
into alsa directly.

This has been fairly consitent across multiple ALSA and kernel releases,
including alsa 0.9.0rc3 and current cvs, and kernel 2.4.20-pre5 that I'm
running right now.

Though interestingly enough, if I switch the apps to use oss emulation
instead of native alsa output, things seem to work fine.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
I'm not broke, but I'm badly bent.                         ICQ #1318344
Patience comes to those who wait.                         Melbourne, FL
               Quidquid latine dictum sit, altum viditur

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9gMv0PuLgii2759ARAnGrAJ9BXzGozuwIC3s2HTOqgCBh6IRaJgCfRv+r
zXmZKHqoTgnUGqdMw4IJm0s=
=ltzw
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
