From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/9] ASoC: Intel: Skylake: Driver updates
Date: Wed, 14 Sep 2016 17:50:43 +0100
Message-ID: <20160914165043.GD27974@sirena.org.uk>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4837790667989129711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F23A02664FB
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 18:50:52 +0200 (CEST)
In-Reply-To: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4837790667989129711==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24, 2016 at 06:03:12PM +0530, Vinod Koul wrote:

>  - The module instance IDs are manged in driver now.

> Dharageswari R (5):
>   ASoC: Intel: Skylake: Unload all the loadable modules
>   ASoC: Intel: Skylake: Create dynamic instance ids for DSP modules
>   ASoC: Intel: Skylake: Use private instance id of modules in IPC
>   ASoC: Intel: Skylake: Table for module instance id and private id
>   ASoC: Intel: Skylake: Override the actual instance id's to pvt_id's

I really don't understand what the point of these changes is at all,
sorry.  This makes it really hard to tell if they're doing what they're
supposed to.

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2X/iAAoJECTWi3JdVIfQkPYH+wQQg9PESq5lUCib5+NXbFAl
LuNr5TxqbLe39kl3qQk0H/xF2kRlDuvCyAbZL2HrudJyAHivYqQNE0XNxiN6cENP
Ar4/lKdRpW0zmBN/BpwpzHtVS1UBxQ1wnSwQh3WSS0IUGp/wvSkXBMeCZNBy9mLJ
VXb3+ncTvmq5sKCUzcE0G503VgPTnrf5bQrYn2NDtFigk3lcwBmCyeOZqQe3NQzx
AXFeYDyI1wDgsvFxzHx2G0Up2CVsscauJBPXzjggHt0h4OMPJ8Iqzj7trim2cPdY
vXTGtSnCs9gV8EEvUU3cw7nVMcwHRNcJKfEHtnAz1+eAGqIHmQxUBI0lBBLcO5I=
=BS/Z
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--

--===============4837790667989129711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4837790667989129711==--
