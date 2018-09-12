From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:for-4.20 333/424]
 sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration of
 function 'pci_iomap'; did you mean 'pcim_iomap'?
Date: Wed, 12 Sep 2018 11:41:45 +0100
Message-ID: <20180912104145.GE6062@sirena.org.uk>
References: <201809111307.iuux6Toj%fengguang.wu@intel.com>
 <s5h4lew34fv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7706539642208710299=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A3A0A267806
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 12:41:50 +0200 (CEST)
In-Reply-To: <s5h4lew34fv.wl-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============7706539642208710299==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2018 at 08:59:16AM +0200, Takashi Iwai wrote:

> I can fix it in my side, but the problem is that the change isn't
> pulled into my tree yet.  So it must be fixed in Mark's tree, or Mark
> send a pull request including this change and let me fix it.

I'll just apply a fix.  I was kind of hoping the Intel people would care
about this but guess not :(

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluY7WkACgkQJNaLcl1U
h9AXRAf+LAhJ2mQnUdORQHaUtZCv656WWsOuYPC9/rhj2C4wONbLMliPpQatMjLI
XwE1m2JD+oaSSClonIkFTdETax+8Oqx4lIQh/WMbBIYT8yzSwCXg0KwaXjHLb8WK
UP5QkS/ZthdOgKmnuH/tz77PbkNiGNt6aqNQqSWD5ePCNIGT1FxjVthm4FXoTXMY
OSvE1W3yd4Gl8NKgHNEW1dIcMKEFeeWm65sVOD9sAs6/kFM3XIQJErMLgGeVcyGY
lAp3K87V8V01pWMBg5awjgqnW1Hb7qHTn5gei3JZDJSRi+Wbl/LvwqCWqsyIwDZj
+xshoFJusap6jFovafeAELleuhttAg==
=kOod
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--

--===============7706539642208710299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7706539642208710299==--
