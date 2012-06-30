From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
 connect
Date: Sat, 30 Jun 2012 12:38:39 +0100
Message-ID: <20120630113839.GS28922@opensource.wolfsonmicro.com>
References: <s5h8vf6w2ae.wl%tiwai@suse.de>
	<448837001.345549.1340986175853.JavaMail.root@advansee.com>
	<s5hzk7mulyz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8335445653689628943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BB542412D
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 13:46:15 +0200 (CEST)
In-Reply-To: <s5hzk7mulyz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8335445653689628943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2012 at 06:22:28PM +0200, Takashi Iwai wrote:
> Beno=EEt Th=E9baudeau wrote:

> > I saw that too. Is it the stereo case that should be added to put or re=
moved
> > from get, i.e. is it possible to handle a stereo case with only one con=
nect
> > flag?

> I would assume that connect should be up when either left or right is
> on.  A stereo widget doesn't mean multiple connections.

Actually I'd really expect it to mean exactly that.  DAPM is fairly
fundamentally dealing with single channel audio streams and I'd expect
that if we did implement stereo controls they'd allow these streams to
pass through without getting merged.  There's a couple of things that
stop us doing that right now but I don't think we should add stereo
controls that don't do that.

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7uU2AAoJEBus8iNuMP3dv2UP/2x2gA1nH1e+NY95xnqPBN3D
sjELAtBWxQ80wzDR1hq/eVAT48DEEYrDzSEavdNaHaijoWjvV8Uxo3NaSmQYpk52
myqbVoB7AK9R5D4awBHhOFyRKPLjLtn+BxdCP3HXzQzj1yokAAOy6b0cP5gAUD+b
8AsCpvCapNCzwnSaGtwREGUrBh1ZbR/7NiH6f56uOjA19ALIdEA0DcWgg1cG+XiO
xG3MRa6iAPD7UdZrYmWrgtMl6NDUTTeOCjqdMP8Wk8BCF+x/Lx1Uzd1zSfGUFnzB
U+kcPc4KashxsuWENOQTPSVNsstBRhUb9fP98g68+yfiXOzPK6sXUgL/1U/GvUkf
R5/y7KNzQQoigWTd1bNf9bESdJeJUNSB8EOXDsw92qtbru4RjfDt7tDrB8EquYgP
xMOOvWYHp9dEaFGMk+neZnIAtmJx/AiWAeUPw0oqLnc3FxjaVOgchyYY/pGDOfK+
IIydVe48o6E9oDZlnDUk7zzP90bucwIUpaAbjJncDtI6MpRZj1rIdYM00mGOqeR2
RBnep9si1XxmSB5LLZU4EvW9chngVL4dpn+GypSEEzAeE+PQamzViNYC0j0bW6h7
wZD3iZRoVJYCfLbKjqG2FyGAVvw86LQ1rShxt4eWNrm2kb0sgKwYDApZOoi54iCO
BZVNnJL5vWkduHTTd8/Y
=nhlh
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--

--===============8335445653689628943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8335445653689628943==--
