From: Vasily khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v3 1/1] ASoC: Add HP iPAQ H1940
 support
Date: Fri, 15 Oct 2010 15:52:41 +0300
Message-ID: <20101015155241.73a34753@gmail.com>
References: <20100920103813.GD3414@rakim.wolfsonmicro.main>
	<1285573668-5415-1-git-send-email-anarsoul@gmail.com>
	<20100927150609.GB13754@opensource.wolfsonmicro.com>
	<20101015104927.596c0153@gmail.com>
	<20101015113738.GJ14782@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1011107794435228731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2614410380F
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 14:54:41 +0200 (CEST)
Received: by ewy9 with SMTP id 9so331710ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 05:54:40 -0700 (PDT)
In-Reply-To: <20101015113738.GJ14782@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============1011107794435228731==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/=nH3Di8n92cTAhtUx4QF.s2"; protocol="application/pgp-signature"

--Sig_/=nH3Di8n92cTAhtUx4QF.s2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Oct 2010 12:37:38 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 15, 2010 at 10:49:27AM +0300, Vasily khoruzhick wrote:
>=20
> > Dependencies was merged into linux-next tonight, so I suspect this
> > patch can be merged if you pull from linux-next.
>=20
> -next is an integration tree which should never be merged into other
> trees.  I really need either Linus' tree or a specific branch I can
> merge into ASoC.

It's next-samsung from Ben's tree
(git://git.fluff.org/bjdooks/linux.git), I suspect it will be merged into
Linus' tree during 2.6.37 merge window, not sure if it's safe/ok to merge it
into ASoC right now. Let's wait for 2.6.37 merge window then.

Regards
Vasily

--Sig_/=nH3Di8n92cTAhtUx4QF.s2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAky4Tp4ACgkQRM6pQpltKE4ACACgrmJ4pcWyjBACjXT6nGw2WlI+
Kf8An2BwTlhJx2+H7oekKbCdlJbncGvL
=YKgu
-----END PGP SIGNATURE-----

--Sig_/=nH3Di8n92cTAhtUx4QF.s2--

--===============1011107794435228731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1011107794435228731==--
