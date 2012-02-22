From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Wed, 22 Feb 2012 12:43:02 +0000
Message-ID: <20120222124301.GA7340@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
	<1329914154.24656.95.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1063400972592603195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 79637103EA7
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 13:43:04 +0100 (CET)
In-Reply-To: <1329914154.24656.95.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1063400972592603195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 06:05:54PM +0530, Vinod Koul wrote:
> On Fri, 2012-02-17 at 14:10 +0530, Vinod Koul wrote:

> > > Currently we only generate these for CODECs, mostly as I have no systems
> > > with non-CODEC DAPM to integrate with. It should be a simple matter of
> > > programming to add the additional hookup for these.

> > If I understood right, then instead of creating AIF/ADCs for codec paths
> > now we need to create the DAI widget for each path and associate that
> > with the DAI, right.

Wrong, these widgets are automatically generated.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPROK9AAoJEBus8iNuMP3dkuoP/iNhG93W+h8NCHk9KlICIuWg
DpHcQmeZ9CI+lS1ht2H1vP8saSqs5IXcVgTgJ6I1b5vjby+Ayl2Q2yXIdgXjtuxq
rO5GpG+uCNK7I75lBxm8B/aUisbj0hChGWm/Uq/vvI1Hf/unIuPYbwZcVJz3KwNe
4e6fj6lqe8s3wlBG4mg8NAsUCycO2c4Viudobnw34q6t+mLUkWODvoPcxd57JTW1
mcWulyz43GYzXDCo/He44cG/0ZpuxdC76KGp+m8R/DLT9wqnIUfrpFPhqU/V7af1
7s/kyblmYwLq0o+bBvNmdmTWWj8LvTmO1xCt8ifUxxnzjaVvvM3S7cJZXF/pnFSQ
+17ujxwFgvc4ExUY7hiuZLgcGJfCgXEpMyOJY5D4wa9LXWxNWyr6j/rG5Asm64ct
8kvOnLlG668EgdQXqo0AlRrSbX7BsNIFSiyZbsajhTxqBuHHFJRnHCKZPhSdGT7Z
xcoJBF1X4pwGYfObaj6GQYcGtsuKo/+/yfjNtOAMQR6lEt58RYSYMGYril7AFCsK
A413vepxnGttZbo31vfx2JJC/NCJxf+adI4yG8L9VTI/0koU3L7b8aYiqTpJ1UbP
ZijhMwPnLXNgROle5D5OL9lfjWT0G6VZoNJFJsz96R3BebPYSNjJ+5aMf1fAszbJ
Qet5FwaFlUusjwW1GDd5
=5bfD
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

--===============1063400972592603195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1063400972592603195==--
