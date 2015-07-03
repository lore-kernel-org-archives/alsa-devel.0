From: Nicolas George <george@nsup.org>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 3 Jul 2015 11:46:06 +0200
Message-ID: <20150703094606.GA1643220@phare.normalesup.org>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
 <558BA1D8.8040508@intel.com> <55931EE8.5000604@gmail.com>
 <20150702184035.GA1418140@phare.normalesup.org>
 <1435913462.2478.14.camel@loki>
 <20150703110838.2cef7f669102bd60b5ee1b8c@ao2.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6501772865424072238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nef2.ens.fr (nef2.ens.fr [129.199.96.40])
 by alsa0.perex.cz (Postfix) with ESMTP id B9524260476
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 11:46:07 +0200 (CEST)
In-Reply-To: <20150703110838.2cef7f669102bd60b5ee1b8c@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@intel.com>, Tyler Yeomans <tyeo098@gmail.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6501772865424072238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Liam Girdwood <liam.r.girdwood@intel.com> wrote:
> > Can you try the bytcr_rt5640 machine driver as the byt-rt5640 machine
> > driver will be getting deprecated (since it only works with a small
> > number of FWs). The bytcr_rt5640 driver works with a wider range of FW.

If that means just "modprobe snd-soc-sst-bytcr-rt5640" instead of "modprobe
snd-soc-sst-byt-rt5640-mach" then it has no effect at all: the module is
loaded but does not create any card and does not print anything.

If that requires changing the source or using sources from a different
repository, please be a little more specific.

Antonio Ospite:
> When testing the bytcr_rt5640 machine driver give also a try to the
> latest firmwares:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/inte=
l?h=3Dbyt
>=20
> I had some success with fw_sst_0f28_ssp0.bin

I tried overwriting the fw_sst_0f28.bin-48kHz_i2s_master file with that
file, but it just gives me this message:

[  390.704580] baytrail-pcm-audio baytrail-pcm-audio: wrong ram type 0x7 in=
 block0x0
[  390.704591] baytrail-pcm-audio baytrail-pcm-audio: invalid module 0
[  390.704596] baytrail-pcm-audio baytrail-pcm-audio: error: parse fw faile=
d -22
[  390.704610] baytrail-pcm-audio baytrail-pcm-audio: error: failed to load=
 firmware

It happens when loading snd-soc-sst-baytrail-pcm, i.e. before loading
snd-soc-sst-bytcr-rt5640(-mach).

I guess I am not following the instructions correctly.

Regards,

--=20
  Nicolas George

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVllneAAoJEHGVSyPKTcYM3+gQAICdSaPStoeAxgXGSSG0wjcd
mX/6LdAZYOoAI7cV7Zpyz7bwCSO5IyTQSzVZ7F95r+izlK7BNOZpknSmkrlphbEJ
1MQj/iBml2ZPElcGcJRrLAJrKDZ1Iqubn5Z2CS1aVbeUjEpcJIzaimYnUZecOGkt
71UbOTtzgkw3GCV9dyikmK8yWgQSFF5sulTGgymLtJNyEqp8vEJCN9EuvmjTvYZG
iV3c5eDDYGCxF4tQELapsdivQj0l4kzxi9fZEZ2SU0K//mLSiz82hiSzqMCKLf2a
d3xh8uoIwzRl19Jh0deQwa4aBONBSuAExeKPEMRULrXTt34sQftolPO6ZtiiXvFr
tCNwjad3gFSDgEwB+DCkHZvXi5YJrIbZBYpVYYu7ijCAoas6pzZvgJgSOV9m9RKR
vmCq9Bo7Xwmi0EZlLLunp88fLtlV6aQwOk0hgM3AOlBppsJqa+jvQfG6pcvAosqS
GEEQXJXlMbfOk/GlVFJCopqvKGkC6YxBgb4hOS62Ad/mC1/0zpY2GB//cVWYGHIr
5/KcsyOf7s5CHGIO/VH5RSEhOti6XrE2tIzq+/OCO7tDy7/BAKbK1g90VAh3Umg+
3epHwuGR3b+gVQKndSOALyre+EihO68VHMzpSxZ3ogIUCVrZ2WHdTq+F65JV0a3M
7Pjfw9ls/ng1oNUnswBm
=OLw9
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============6501772865424072238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6501772865424072238==--
