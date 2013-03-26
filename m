From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/54 v2] ASoC: switch over to use
 snd_soc_register_component()
Date: Tue, 26 Mar 2013 21:56:41 +0000
Message-ID: <20130326215640.GN18316@opensource.wolfsonmicro.com>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4478435486822988769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76ADA2615C5
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 22:56:45 +0100 (CET)
In-Reply-To: <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4478435486822988769==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yOym6oKMddBvWW1X"
Content-Disposition: inline


--yOym6oKMddBvWW1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 07:26:34PM +0900, Kuninori Morimoto wrote:

> These are v2 patch set of switch over to use snd_soc_register_component()
> instead of snd_soc_register_dai[s]() on all drivers

Applied all, thanks a lot for all your hard work on this!  I think I got
the latest version of everything, if not please send incremental fixups.
Seems to work fine on my systems.

--yOym6oKMddBvWW1X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUhmKAAoJELSic+t+oim925MQAJqGyzbNCeVE1+iKy5eKjqKz
jxawybkcKbARi33rwcJYGvQiKN1ty72nq/x93q5w5z/K+SLMjlQS0daWNAC+3nF+
wxTEC4K/3Jhkau7C23EQriJKXK8Tr/GA63+exWtCHo/VI71ob+bvsB5thfr89+SY
5d1JArQYZv5PFxhXA8mfmXpoM+/fzoOX0Az/4jhbO8xaYa24qRF0yS1QdDXTsTCo
K9AY470qVQHyi8utE+p+b6q47SgW76zSAV44B4Jphisp+dNUKcy+jla9+6LWEq2E
4MJ0MxvUPhbZsZUjrGDZyW4A/bx4oGPxhr9xlIe176pG4MZkkpoyS9MqJrFi+ci3
Y20qaR4bbTnslcxkkWB4EOOzjRARnVOxXNIqowO6/0RJy9T7Oj3mQkqAXabPj79X
Z8yrikL1y8NIqXKrFMZDJFGxIb0xtJQDH7CicqmhiWEL7zDXItDmv6viXjk5Vy81
JktUVsgd++cRhhnTjhjOX02fIRCtNPsUbpHw512aH1+dqvHxGyP0hl2t/6Bp8XAW
l8tykbViT17MTNNHJ0wflzjX3OWqMbHlROivVR/UG6JQNj4NlI5GSnxZyYitoo7x
fYmFfS9rDkG/IqSrwHZM2Bt3KgUbAwKJI8W7IV7FqO3wjJam16n3XL482jPlltb4
2g9PszxHVj3qi5+jNj3T
=SmOm
-----END PGP SIGNATURE-----

--yOym6oKMddBvWW1X--

--===============4478435486822988769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4478435486822988769==--
