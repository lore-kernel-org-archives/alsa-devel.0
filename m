From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] ASoC: Intel: add BYTCR machine
	driver with RT5640
Date: Thu, 6 Nov 2014 13:46:00 +0000
Message-ID: <20141106134559.GJ8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-6-git-send-email-vinod.koul@intel.com>
 <20141106124854.GC8509@sirena.org.uk>
 <20141106131141.GD1870@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4129592087355977775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 261FF2606C1
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 14:46:20 +0100 (CET)
In-Reply-To: <20141106131141.GD1870@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4129592087355977775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fo1QyUNofDrBKNDB"
Content-Disposition: inline


--fo1QyUNofDrBKNDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 06:41:42PM +0530, Vinod Koul wrote:
> On Thu, Nov 06, 2014 at 12:48:54PM +0000, Mark Brown wrote:

> > Don't bother with the wrapper functions, they're not adding anything.
> > Why are we using prepare() and complete() here - other machine drivers
> > don't need to do that?  Comments might be helpful...

> due to I2C. We have seen that codec is resumed but I2C is still
> not ready causing i2c failures, so moving to complete and prepare helps. I
> will add this comment. Will remove wrappers.

That doesn't sound right - this would affect almost all systems.
Deferred probe should ensure that the machine driver can't load until
after all the component devices (including the CODEC driver) are
instantiated and we should be suspending in the reverse order that we
probe the devices.

--fo1QyUNofDrBKNDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW3uXAAoJECTWi3JdVIfQEfkH/iJn3MLmxo6PCUeZMb7Xq8Ko
Ltr5naJlADLK2D1g/5YHs7zVCPxTfqSN4Dr5hyiDrPRiMfXi5EP06/NjZ0U4t3Qu
crUFcv33qv7Al+Lfkwzl3X6/gTBCkB/rEfQy5TyXN5ZPF5rX+xRyefPpCNSUAb3n
BozHZMLid7v+I4j26HpceunMunzHOsUzPUhuk6ZxVtYYnep8VsCPFtyGHjSym8vo
BFevXy6N7Xb25UQdYK7IVFKK/gDMroTo4SeykjiTAM6r4KgXHti4LHQbgA5J6YZs
NL8RYBfY0tb6Xov6hM6W3KdsvPj2rxY+beA08aG1CD7xexaAeQ9doMaEDFidIGg=
=8RAI
-----END PGP SIGNATURE-----

--fo1QyUNofDrBKNDB--

--===============4129592087355977775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4129592087355977775==--
