From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/5] ARM: dts: sun8i: Update
 audio-routing with renamed widgets
Date: Mon, 20 Mar 2017 16:30:47 +0000
Message-ID: <20170320163047.3xizwkq6pogi73gp@sirena.org.uk>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-6-mylene.josserand@free-electrons.com>
 <20170320113817.rcphcvrizi4yphhe@sirena.org.uk>
 <CAGb2v66ZLeoSQt0y2QVcDEBujS7JLQAptDq1WL8f8rkwSni6uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3173900721030755844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77792266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 17:31:12 +0100 (CET)
In-Reply-To: <CAGb2v66ZLeoSQt0y2QVcDEBujS7JLQAptDq1WL8f8rkwSni6uw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3173900721030755844==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gyokpzpzpw6uxcee"
Content-Disposition: inline


--gyokpzpzpw6uxcee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2017 at 07:53:37PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 20, 2017 at 7:38 PM, Mark Brown <broonie@kernel.org> wrote:

> > Given that these are fixes it probably makes sense that they all go in
> > together, can I get some acks for this and I'll apply it?

> Acked-by: Chen-Yu Tsai <wens@csie.org>

> Though this patch should go in through the arm-soc tree.

Well, ideally but I'm not sure it's a super big deal to get the odd bit
coming through so long as it doesn't conflict, it's more of a big deal
to make sure that we don't get the ASoC side without the DT side and
vice versa.

--gyokpzpzpw6uxcee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljQA7YACgkQJNaLcl1U
h9CjoQf+Je6RtQfGkq0vooHmdHRZUzlJTnC4LWrDoC/+zF8ji5CtfqwNFZGD92rH
U5h3nk52dFH+ucdSOPjtjQp7EFnTo5mJ2U2ufMACFYvidVhZh2Y2NUMpQyjvXF1d
7kulTZqBJyy+gG77W9vksy/e08gwc67H/9Ykm1Fr6D8y8/WocZ77KWFcTd+eRHf4
DkqlT0wvDX5dags8ictYr3JXi41uI1Sr2CbrKQtbm9ISo0l8HiMGD/8OhhwUuJL2
xyASCFWfX5NsiDl+0dy/ww273JKl5LHAvog42KV+LX2tqnKeFYvOR2N22Upk5lxo
Ej3kNUvcXB/2fpeXlcQ9yMoO3NBhEQ==
=OOu+
-----END PGP SIGNATURE-----

--gyokpzpzpw6uxcee--

--===============3173900721030755844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3173900721030755844==--
