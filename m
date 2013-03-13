From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: add
	snd_soc_register_component()
Date: Wed, 13 Mar 2013 10:13:15 +0000
Message-ID: <20130313101314.GA25610@opensource.wolfsonmicro.com>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87ip4xtnka.wl%kuninori.morimoto.gx@renesas.com>
 <513F9F85.7050301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3281598362236358878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 206A72616FB
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:13:17 +0100 (CET)
In-Reply-To: <513F9F85.7050301@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3281598362236358878==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2013 at 03:35:01PM -0600, Stephen Warren wrote:
> On 03/11/2013 07:27 PM, Kuninori Morimoto wrote:

> > This patch adds very basic struct snd_soc_component,
> > and register function for it.

> Perhaps as a separate patch: It'd be nice to add file
> /sys/kernel/debug/asoc/components that listed all the registered
> components. Anywhere else in debugfs/sysfs/... that CODECs are enumerate
> might want to cover components too.

Yup, definitely - this will certainly need to get done at the point
where we can bind CODECs as part of the card setup.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFErAAoJELSic+t+oim9YNMP/2n9dDWYVKtHADnzZCte/DZd
WBLY1RfnVjxffUYuRPB7Zdg9b5tNl7MVKI9PfhvOJ2OML/00qz5N+XESmWgMg8sp
wDKUMut9VNqa0ggW0iVjDRSsojBzqgpT7aM84jByyIb8Q6DcwIbSf0zhsSJXOZ5f
dGi3qa8nWpsh4tO1gWFC/pYlci8ddBP3bu1lq00DpD8xTegq0Yi2O8WJ3WQai5yX
LwMxYf+z+APvj7CGZVWpittEnX3JPBRv4W/9z+NXV5nLaWR9CAZmYJigxmPladAY
1GcSAiRgpZrkgzWgpFxWMqEuNOqJTu3rpJv5+k6nz4dI8pRtYl4xts3s90HlTt8V
TLhD4I5DE6a7F2MozNgsqGZ9gKFBNwki8sNCGg98rrbbGrxvJ5J21EZqtJXlCttb
7mMc/1Lh12izNn+eOXKnnO6O9ukPxNK0SXw8Hq/6AOQlwNDgUOg5jdqQWmXAthOB
lwM6563/ToMrQBgkj9kPO1Z7wsXOeHNCm5ZE+Z89F3G7aHW99+KTx4JuY+6Ugxzo
tjRtXY4mcgLC0BZgTf+dif4x8ZwG78m05o/syC1Y06x1cu8NNuIAI6C7JE3eyce9
Vx70w7MMw2Km3k8jqI13leQ2h6pOS3wy3K0MAYPCC9urWs1rkVXq8tNeW6fiHnrE
n8ZhIbC0L1up46vfBZyU
=Sdsp
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============3281598362236358878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3281598362236358878==--
