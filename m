From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack detection on HDA vs SoC
Date: Mon, 6 Feb 2012 11:06:00 +0000
Message-ID: <20120206110600.GA3070@opensource.wolfsonmicro.com>
References: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
	<20120204132029.GA7438@sirena.org.uk>
	<20120204140209.GB7438@sirena.org.uk>
	<s5hmx8wqomb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8885899708601385283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE8E2103A5F
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 12:06:03 +0100 (CET)
In-Reply-To: <s5hmx8wqomb.wl%tiwai@suse.de>
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
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8885899708601385283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 10:48:12AM +0100, Takashi Iwai wrote:

> In the current release, I left ctljack.c as is before the integration
> with jack.c simply because of different use-cases I faced: the
> input-jack provides the multiple switches for a single jack while the
> current ctljack.c provides only a boolean.  Although the ctljack can
> provide an enum instead of a boolean for representing a similar model,
> I wanted to get the global overlook and a consensus at first.

That's not the case with the standard jack stuff at all - it's not using
any enumerations.  Everything that's grouped together is bitfields, it's
just a set of booleans all the way up to userspace.

> Meanwhile, the boolean implementation is enough for most of PC
> (especially HD-audio) stuff and the ctljack implementation was
> demanded.  Thus I decided to merge the branch for 3.2.

So are they just booleans, and is there a naming standard for the
controls?  I've never seen any clear description of the semantics
and I'd been assuming from the fact that all this had been done
outside the standard infrastructure that there was some deep HDA
specificness in the current somewhere but it's not sounding that
way.

> Definitely the integration work is necessary and foreseen.  The
> biggest problem my workload for other tasks.

TBH it looks like it'd have been less work to start off in the core -
all the hooks were already in the drivers.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL7QRAAoJEBus8iNuMP3dJNQP/13FbfRPX4IJdeYDf0Qh8nth
0IlOmUXRfCixlMwDuDS4PKP6tWxOwRC0TV7JY3jr1CbrzBodVm9x7Ar0u9sFMqnt
Agl4qdqL2TLPpSPXqLxUPznnlQurVi/tQUEUnwtQK9ytlGt+IgXCyYoHkPoQE2jz
MPdIOTMdPa7IktsXAWwAGiNw/S+3xdNQ+SDsXocqxcCnC/6lKYuK9yvbYTQRhy5/
TFc5aWzeA+oryw5SPawmctwLmxryaCGKpbpGTyikbxG+Et23HWp1wWc/Y4o+qKRE
gMxr5IukD0NXBxhjgRf/NCH7jKb0SgwAzryzkljNAvLyGUvF1Nmanc2StVXBjkfT
ORmNuuGnqGjLM+q3PW3iOIAvxbjd6YJLZRzs8Q2oxbTJt0CqgZke6wIxe35aECPh
EYGCOh5eJamecaA6y5ZUVzagmzf4Xj0gHKuIz7d36bi5btk9/46zKg+ewqAekD3R
nCaEVBP3P3/WtOow/JEyH86IgOr7wQXhZAk1cLaKT6/RaHwvtqJ2FHqX33q58tNv
7IhqxW/mRONTAkqNXabCfKTQ1U6R7B8Aw7Dq5UcQlxG9ZeiTuC3yiCsYuEADnD9r
/9F8WugMDinGW9jw5399rioi/yalaXq/COjgvBU3Eji4lKSSN+9A+5COzRGsCvSz
i7yhDplF9/FLlTIYTgsR
=X38+
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

--===============8885899708601385283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8885899708601385283==--
