From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp
	software reset
Date: Thu, 23 Aug 2018 10:51:07 +0100
Message-ID: <20180823095107.GA5207@sirena.org.uk>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
 <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7338840042996712031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5D352676D8
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 11:51:11 +0200 (CEST)
In-Reply-To: <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7338840042996712031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 22, 2018 at 05:31:04PM -0700, Dmitry Torokhov wrote:
> On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee <ryans.lee@maximintegrated.com> wrote:
> > +       mdelay(10);

> Is it really necessary for the CPU to spin for 10msec here?
> usleep_range() would be better solution.

Or msleep() for that matter, it's not going ot be the end of the world
if we delay a bit too long.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt+g4oACgkQJNaLcl1U
h9BrhQf/Zim+9StJ1iLMas05ZDR6IOmI8Vk166JzDc5Cl04crEzXRGtkjTjIPszh
nO5s0JhVanRN0I2RXQvD1nXHDeXIAOt88susgnBH86u7HFLGO471NnvZW/R7W8JD
hMUNwL3RfbRAMbkGA11dlvU/pQ/Q7nAE4NPmMIBS5Z3W3ZIb3yIXeEAO7osAtAbU
5ggStp5ly2w8A2kPEsDVuaYTDKPloD2DP+9QWl8b3c1N9PD5+kAFjGEgNR+7o3A8
cCw9zFfpkQekbYQHqsVw8iV2tWJClPqNvtwl2qbq35/MeMbfnaePaFVWDe/jBE93
LiB34dB+w7sqy1wv9Ahq+zUra29Lfg==
=Jim1
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============7338840042996712031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7338840042996712031==--
