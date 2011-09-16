From: Valdis.Kletnieks@vt.edu
Subject: Re: [linux-next] ASoC:
	sound/soc/samsung/neo1973_wm8753.c build failure
Date: Fri, 16 Sep 2011 13:02:09 -0400
Message-ID: <56969.1316192529@turing-police.cc.vt.edu>
References: <1315991893.17271.2.camel@phoenix>
	<20110914191917.GA30518@flint.arm.linux.org.uk>
	<20110914232808.GC2953@opensource.wolfsonmicro.com>
	<20110914233838.GB22946@flint.arm.linux.org.uk>
	<20110915094640.GA7988@opensource.wolfsonmicro.com>
	<20110915110056.GA32615@flint.arm.linux.org.uk>
	<4E71E720.7040008@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4716200286069315332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lennier.cc.vt.edu (lennier.cc.vt.edu [198.82.162.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 86A4D103D2E
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 19:02:16 +0200 (CEST)
In-Reply-To: Your message of "Thu, 15 Sep 2011 13:53:04 +0200."
	<4E71E720.7040008@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@gmail.com>, Russell King <rmk+alsa@arm.linux.org.uk>, Liam Girdwood <lrg@ti.com>, Harald Welte <laforge@openezx.org>
List-Id: alsa-devel@alsa-project.org

--===============4716200286069315332==
Content-Type: multipart/signed; boundary="==_Exmh_1316192529_55056P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1316192529_55056P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Sep 2011 13:53:04 +0200, Lars-Peter Clausen said:
> On 09/15/2011 01:00 PM, Russell King wrote:
> > [...]
> > We now have a sane policy: entries which aren't fully up to date are
> > automatically dropped.  Entries for which there is no platform support
> > file merged within 12 months of the entries last edit are dropped also
> > automatically dropped.
> 
> Partly unrelated, but what about these platforms which can be fully described
> with DT and don't need a platform file?

Then those platforms won't notice if their now-unused entries evaporate out of
the platform file, right?

--==_Exmh_1316192529_55056P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOc4ERcC3lWbTT17ARAmjWAJwIcfH9HqMH9fpYfHq20Q7oyapV1QCcDMic
mdI3buT+ZL199AOtx8JWznE=
=/Nsl
-----END PGP SIGNATURE-----

--==_Exmh_1316192529_55056P--


--===============4716200286069315332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4716200286069315332==--
