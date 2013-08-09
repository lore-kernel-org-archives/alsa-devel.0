From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
Date: Fri, 9 Aug 2013 19:00:58 +0100
Message-ID: <20130809180058.GM6427@sirena.org.uk>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com> <20130809113940.GY6427@sirena.org.uk>
 <20130809130932.GS23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3386653728428842729=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 321562610CC
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 20:01:05 +0200 (CEST)
In-Reply-To: <20130809130932.GS23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3386653728428842729==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CinbraM2ncepWOqm"
Content-Disposition: inline


--CinbraM2ncepWOqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 02:09:32PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 09, 2013 at 12:39:40PM +0100, Mark Brown wrote:

> > So extend Morimoto-san's work on the simple card for this - that's what
> > it's there for, it's doing exactly this job for non-DT systems but it
> > just didn't get DT support added yet.  All the trivial cards should end
> > up using this.

> It's quite rediculous to request that the simple card stuff is expanded at
> this time, when you're also telling us that we must use DPCM for Kirkwood,

That's the place to put the sort of shared infrastructure for trivial
cards that Sebastian said he wanted to see - if you guys are saying that
the machines should all be able to use a trivial binding with shared
code that's where that code should be.

--CinbraM2ncepWOqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBS5XAAoJELSic+t+oim96n4P/14jD71UpJ3qtuZbFQlvgFMP
u1+6lS5ONC/BpRSJWt/+2BZJ7wyIX/3BkCkCfntIPAtlwsZ54iax/ZNhQtkq+Kw9
cqc0KgJh7m3OXoyLbnSyog/KlH7kB/kKdmwhO8q2mcd+KVaNkjz5TBmGBXQHjo2w
ywySeetNrBtQG7hUp6mimy5fDqaWuLJ9cBaG9Tfi+QeYwLA5za4kJ68RwdmboiB0
XKWCvcefpb/y28QSqDgW/SwRCIEKvKR2mf4/dBbFiiUTwSIgeZGg3WXFOyKpL0le
cS2tnpnbGa6epAAlDfZjjRQQdNSscNd2xtLmqXhafQL+25ZLfOcRNCavZqnUx1V9
/izsw+Pqk9fq1lOPBSVVWrpL5uJ3rABSc/rZCgS/UT+sNI26/GzQcHBoEH8oSjNR
uw30Qmlpux97pF/+xJ/Tv2saczFTS+W9vFIOKGgD1tNpuUQR3eYy6ooX2FoGLnlK
17uMeKJb5GaM88sx+2aHbeZFZp8KIsxQpvoUyKP7nnBuIaC2QBkaRcrVMJeRPjQ/
FdCUXeErGmJT+sQO70XCYNoMXkr8MdiriLLxBgyrqJusJLEXF7eSTmj80swXKxBC
br3CdT1yrCn0SLnYjL9ys5eILGk5cLhmhHLFODWiB0NSDrwD1Yky86FP8F4Vrv+0
jLsIyiFC/yL+CxpQZgQG
=JNhp
-----END PGP SIGNATURE-----

--CinbraM2ncepWOqm--

--===============3386653728428842729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3386653728428842729==--
