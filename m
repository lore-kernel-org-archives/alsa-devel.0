From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v3.18
Date: Tue, 7 Oct 2014 18:14:36 +0100
Message-ID: <20141007171436.GA23707@sirena.org.uk>
References: <20141006115105.GL4609@sirena.org.uk>
 <s5htx3hxtjy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5106244840157887960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B802F26056A
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 19:14:50 +0200 (CEST)
In-Reply-To: <s5htx3hxtjy.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Sachin Kamat <sachin.kamat@samsung.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org


--===============5106244840157887960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 02:37:53PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> However, this resulted in a few new build warnings, and some of them
> look correctly reported.

> *  sound/soc/codecs/mc13783.c:787:13: warning: 'np' may be used uninitial=
ized in this function [-Wuninitialized]

> The call of_node_put(np) is done unconditionally even for non-NULL
> pdata where np isn't initialized.  This may lead to a real crash.

> * sound/soc/fsl/eukrea-tlv320.c:221:14: warning: 'ssi_np' may be used uni=
nitialized in this function [-Wuninitialized]

> A similar bug: of_node_put(ssi_np) is reached even before ssi_np is
> initialized.

> * sound/soc/fsl/imx-es8328.c:196:13: warning: 'codec_np' may be used unin=
itialized in this function [-Wuninitialized]
> * sound/soc/fsl/imx-es8328.c:195:13: warning: 'ssi_np' may be used uninit=
ialized in this function [-Wuninitialized]

> Ditto.=20

> Relevant people put in Cc.  I hope I'll get a new pull request soon
> later :)

You missed CCing the Freescale guys and Timur so you're missing most of
the relevant people here; adding them now.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNB97AAoJECTWi3JdVIfQ3+gH+gPPf1+T0cEccp9+0MkgsKZw
XZTfEp/8IGSQ4HqBsOOdEYu8OLSpRGSCrBoHT2OymD7+fNSwl0euDBAYlArVvsi9
MTtGMFVMCERYqMkmXZytuDUnePvLpLHvns5rKWc7q/t2MbFsIBQeKok3rmHbMaru
8m3Uw8SNO+9uwHQeEuwmtceVMJd5I85+bjzg1ZXfmRWK+n+oNUiBrxcQpveiFoDG
wBxBsHJUxFr6vEvEPnUgbg5+EbwQQoguhCj0/RyqnQxNoESJtJYEJ6Taj7JaMzFL
nlyImKQ7dD6flcB9zgATQk8VapvD+9tRuLuv/YMfstvw4d6XQAv9iG76+pGYT9o=
=M/kl
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

--===============5106244840157887960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5106244840157887960==--
