From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 11:05:03 +0000
Message-ID: <20140310110502.GW28112@sirena.org.uk>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com> <531D756A.6000505@metafoo.de>
 <20140310091250.GD28112@sirena.org.uk>
 <531D84E1.8050706@metafoo.de>
 <20140310101038.GO28112@sirena.org.uk>
 <531D939B.4050102@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4973538633005903527=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6407F265132
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:05:23 +0100 (CET)
In-Reply-To: <531D939B.4050102@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4973538633005903527==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U52+7H1OQL9AQ16A"
Content-Disposition: inline


--U52+7H1OQL9AQ16A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 11:27:39AM +0100, Lars-Peter Clausen wrote:
> On 03/10/2014 11:10 AM, Mark Brown wrote:

> >The only thing that should be registering
> >things for other components is the card and the general idea was to
> >register everything in late_probe().

> What most machine drivers did before card table based setup is to
> have a per-component callback in which they did register the card
> DAPM elements associated with that component. E.g. routes from the
> CODEC output to a speaker, etc. You couldn't register the card level
> DAPM elements for one component in the init callback component of
> another one since the routes depend on the widgets being registered
> first. So those board drivers kept separate routes and widget tables
> for separate components. With table based setup for the card the

I'm sorry but this just isn't what was happening at all.  Remember that
most of the code that you're looking at only ever had one component so
it really never made any difference which callback people happened to
pick so long as it was one of the ones that ran after the CODEC was up.

The only driver that I can think of which did anything like what you
describe was smdk-wm8580 and that was still only using one component,
it's just that Jassi preferred to split the input and output paths since
the DAIs were separate on the CODEC and he felt that was clearer.  It
didn't make any practical difference, it certainly wasn't due to startup
ordering.

> routes are registered after all components have been registered,
> which means you can register all the routes via one table since all
> the dependencies are ready. Same is true if you use the card's
> late_probe callback to register the DAPM routes and widgets.

Right, anything that actually cared would be using the late_probe()
callback.

--U52+7H1OQL9AQ16A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHZxbAAoJELSic+t+oim9Bn4P/2bBM6MFSDsvic/LkZNrnf2U
9SK1i5c80o7gaj6g7rbiQxihBvFl3mNnn+DL70wMdbVltektdggTgqfLJAP8FsDG
r1fPBrY+Q3Rx5okjbv6EKY4rjpykPnE+omrTltkpZ14fjr8iDo3TRC0YvTCi0Erp
wMtKb/euxdGpXKFGaxAC+Mn8sTe6sqcDBrhDP7PlcOR3zJ9IsVStNX99zvYnJnFu
rK+IdgHtOQTMcEC+ZVUq5oNKcDxAJIyfEr4U32BbB4Spe88SCNBwWP0hKZ1EoRDW
2vfZveyamFLGikVspWF1/JYhMavBY6DT7+70AVIuiSzXLhpI4YjC25HUXA0+fjMu
9MX/xzcUBhHEurK0TTjqvgotUQ4Mj8f29v0hQkU30RC3DJhcEjrYQoXnpEaX+LYu
EoWDPKLuJ+uAdrdjDnHIUG3W28HOMxNAbC1C6kBqkxJ6mE7I8JnmOauaOoQN6net
bsoOj8UEc1CtGDq/O6x4nhK+TK6G6ZIvlMEksZqqolPy3fQlJOiBbIIl0CnXWGZ+
yqYDD9f1nL0HCZU6CSZ4b5ve156RO3AFQfE/+ojL0tNHvRl1cl3kAwzBI0gGywt4
iuFgNWwKWNp6fy+ATHMG1+E2/0/u8Ci7kkjhpkvu77DW1quAzTrT7J1+Re/2DHax
9Kje+uqnxBCrGN5l2mTB
=Z2VY
-----END PGP SIGNATURE-----

--U52+7H1OQL9AQ16A--

--===============4973538633005903527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4973538633005903527==--
