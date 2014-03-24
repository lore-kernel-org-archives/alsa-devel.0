From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/13] ASoC: Track which components have
 been registered with snd_soc_register_component()
Date: Mon, 24 Mar 2014 11:33:30 +0000
Message-ID: <20140324113330.GI2269@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-9-git-send-email-lars@metafoo.de>
 <20140324111805.GI1665@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6735236475151927499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BF52261A38
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 12:33:57 +0100 (CET)
In-Reply-To: <20140324111805.GI1665@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6735236475151927499==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2014 at 11:18:05AM +0000, Charles Keepax wrote:
> On Tue, Mar 18, 2014 at 09:02:11AM +0100, Lars-Peter Clausen wrote:

> > snd_soc_unregister_component() takes the parent device of the component as a
> > parameter and then looks up the component based on this. This is a problem if
> > multiple components are registered for the same parent device. Currently drivers

> Do we have any thoughts on what might be a longer term solution
> here? Is the parent device actually the right thing to pass to
> snd_soc_unregister_component, it feels like that is probably not
> going to be enough to accurately identify the component?

It's not clear to me that in the longer term it makes sense for anything
that is a single struct device to be registering multiple components in
the first place.  In the short term we register things separately so it
makes sense to continue to support that to ease transition but it's not
clear to me that it's a good idea.

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMBgHAAoJELSic+t+oim9j1IP/iHvt5nF0pmwaWYOVpWB6Cio
KMauK+4+52gT8/80qEZradVAIbqCGh4RBSqoPU5E652uv4k6jU5F+YctCiwfoK9G
oEKUU5FrZeQ+/qgVh6BQ/zt9Q2Dn0xATXfiNa8fzycqFw1zpxyatgR66Xemlfu5l
YuxgP5KohJANpOQB9lY1nBma3kjlHzvaBf1Rp9xWN2LB4vsqfHgXQeieR3YB3KML
lzyUmsz8b3OFlS7BxvlwsHDYPrcIQY/ZO+TE6WnzBCIufPTzRZQju0JkTi/B4UMv
BqCFVjqDghaOGSWNjDZv9j2WmpPNw3lnDnHCrCaPpN5Aup0BWUQFY/VtH98Npy5r
aFWlhkDwuRir6aa50N3FNYVZfvecSuDgWlDxY9rAly3ek8TdJVehI8PO2OzJi7MX
whgPHaBGGOfa6aaMWzBX5xz1/i+P1h8JUbyUh9QACxctlmZ76yNvt81g5EOiq0s+
eN21Ed8vAQsZaC87mUn5dJwx4mPJFeBKnBcQ7zHN/KM8OzVih+eB6mwEkMOoP16/
z1GNbdvqyJuveES7NECRQjmLpHlEbrcFuVTx07WzDtJgzhuEtgAShQG2Ag+Tizfz
KupykBgIapsKAZGGD3F6J+g1S5/OR4JH+StM17gFfEVoU8URzX3lpACu3Jn+izWB
ZJMTzfzTVFNf30XO88r5
=eSkz
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--

--===============6735236475151927499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6735236475151927499==--
