From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: wm0010: Fix possible
	out-of-bounds array read
Date: Wed, 30 Oct 2013 14:32:13 -0700
Message-ID: <20131030213213.GO2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-6-git-send-email-tiwai@suse.de>
 <20131030163857.GF2493@sirena.org.uk>
 <s5h8uxak6ko.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4497375578621384385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 92BDB261740
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 22:32:32 +0100 (CET)
In-Reply-To: <s5h8uxak6ko.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4497375578621384385==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMHqbYJb993HXwLR"
Content-Disposition: inline


--XMHqbYJb993HXwLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 06:32:39PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Wed, Oct 30, 2013 at 08:35:03AM +0100, Takashi Iwai wrote:
> > > Spotted by coverity CID 744701.

> > Applied, thanks, though once more please do CC the people working on the
> > code.

> ... for blaming people who wrote such a buggy code? ;)

So they can review the change, learn from it and take the fix into any
vendor releases they do.

--XMHqbYJb993HXwLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScXrZAAoJELSic+t+oim9k1MP/2hdnmU+IweLXyxzm0qcpq02
OprysAkf6n3m8ptqf/RAFqE3ccZ/Q809zAnaDgGi440zhwj53WrpE7WqiFwsyh8y
g+xMoUi1ptwIvO+FPUlzTzG9g90Sv88o5AZD96VReQ4CAbx1TdrxdsmppJbeBACv
4Uw8qovBXCEKOx/IjUUbvxIcD/6m/VgQ2BJXwe64QMwwtSQ47Rz6E33gbp1GUiVs
ew1ZhVYLm91+e9PCoLJUr7pHTp5BRDrkjn4P8BBuPcMx8w0X7f/RWs85pNfjMj/x
SNN5rG+/GjxvJzx864iLsJu5bydAueh65SiHMywjQKOe5e8x+D7UYyBwTaYyXjI3
20c7FakLxe56+F6jQg9aBu7cKqTn0mYugYKP+f+NAj1Nk5nLL7+56t73QnMWxYYc
DCfFDDsadKxdG5H0fr0BAcm/7C1lDI8kBLxMb3/zIoLxBKLX0pHaCm9j3tJPqTkv
ALq1w/N2GNgGS4cH2AEWEW3TvpuSWZ7R/AddudfOwqPxxujImbWr2/iTHvALsp3T
pz0pAe7vI0mwWYIYwEmi3ui1QTx4f9jrjtp2S6+4ecAMbxKeQPXzAjRYKEU+Iwvn
hTYyJRA00LKLdh36zE/wCFZZ7SR2e1k5x1syzMjREcnth9IYR8olZ6YFXLSfRcxu
tBnha6Zw6QhQgkXzTihP
=s4Fa
-----END PGP SIGNATURE-----

--XMHqbYJb993HXwLR--

--===============4497375578621384385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4497375578621384385==--
