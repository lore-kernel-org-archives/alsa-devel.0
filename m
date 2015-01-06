From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/20] ASoC: rsnd: add Synchronous SRC and
 U/O error salvage support
Date: Tue, 6 Jan 2015 18:33:19 +0000
Message-ID: <20150106183319.GS2634@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>
 <20141230171032.GQ17800@sirena.org.uk>
 <874ms6rraj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4819785805967248730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E57402604F7
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 19:33:31 +0100 (CET)
In-Reply-To: <874ms6rraj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Tim Cussins <timcussins@eml.cc>, Liam Girdwood <lgirdwood@gmail.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4819785805967248730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iASP2QDfFF5MN+I5"
Content-Disposition: inline


--iASP2QDfFF5MN+I5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 12:42:27AM +0000, Kuninori Morimoto wrote:

> 2nd "dynamic" rate convert which is this patch is used as revision.
> I don't know detail of use case, but, according to HW team,
> sound clock has small accidental error.
> Because of this, if we used 48kHz sound in long term,
> but, the real sound can be 48001 Hz or 47999 Hz or something like that.
> So, if we use it without revision in long term, the sound will has
> small noise. This will be problem for TV or radio (?).
> Thus, sound player wants to revise it by "dynamic" rate convert.
> I guess DPCM is good match for "static" rate convert, but not good
> for "dynamic".

In general it should be fine for anything - the driver for the SoC
shouldn't need to understand why the rates are being converted, it
should let the system integration worry about picking the rates.  That
way we can more easily make the frameworks smarter and get benefits over
all machines.

Though having said that I'm a little confused as to what exactly this
control is intended for - am I right in thinking that what's actually
going on here is that something in userspace is measuring the actual
measured rate and feeding that information back to the DSP for
correction?  If that's the case that does seem reasonable but also like
we ought to have a general control interface for it.

Adding Tim and Pierre since they might have views if my guess is
correct, I could be wrong though.

--iASP2QDfFF5MN+I5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrCpvAAoJECTWi3JdVIfQMlkH/37KIwQ2OJ0m+csCSXyZyuZE
XNcNdNUIc769DUm7O+IldArSsUvTvYI7cwKyCbQJNO8gpGVNZi21JFtDP7yQMh/G
Dhtdned3uh7voTbMJwfgE0dJwwwIefZaBU+AlQg8wV5mHtT7ZYWn9z2nwZt8UU6f
/3eAT4wWaAu/L5s3qfZ1dOiq27hhyk25LAs2A/xF2V95UFV6E4UIuehLExLPnC75
9JwxSBEH3C1eArbgm2HBYaXR9fdsh6qEE570mot4EA1XNSALt+Vqcg2VrSmCDE36
5PbJAyN2smjj6ZRnD6cejuE8ipasaePPSh9XeZjaYjrP8sJBAsnHW1vhomGvK0I=
=xEt1
-----END PGP SIGNATURE-----

--iASP2QDfFF5MN+I5--

--===============4819785805967248730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4819785805967248730==--
