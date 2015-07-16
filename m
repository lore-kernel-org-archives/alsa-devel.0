From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:fix/rt5645 1/1]
 sound/soc/codecs/rt5645.c:2947:3: warning: 'return' with no value,
 in function returning non-void
Date: Thu, 16 Jul 2015 16:07:02 +0100
Message-ID: <20150716150702.GP4039@sirena.org.uk>
References: <201507162001.z6afFgHb%fengguang.wu@intel.com>
 <CANMq1KD5YjN1Dv5cEJ0YQMxMyEnSNZb=8AK4t7p_Uw3418V_Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8333267258428106174=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76730260575
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 17:07:15 +0200 (CEST)
In-Reply-To: <CANMq1KD5YjN1Dv5cEJ0YQMxMyEnSNZb=8AK4t7p_Uw3418V_Dw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============8333267258428106174==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K8zN2sh9fO5jmbe4"
Content-Disposition: inline


--K8zN2sh9fO5jmbe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2015 at 09:03:29PM +0800, Nicolas Boichat wrote:
> On Thu, Jul 16, 2015 at 8:32 PM, kbuild test robot

> >    sound/soc/codecs/rt5645.c: In function 'rt5645_irq_detection':
> >>> sound/soc/codecs/rt5645.c:2947:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
> >       return;
> >       ^

> Are you sending this patch to stable@?

My git tree is public...  I'd not Cced it to stable but it looks like
it's supposed to be a bug fix so I applied it as a bug fix.

> This happens because I rebased the patch on f312bc59 "ASoC: rt5645:
> Remove irq_jack_detection function" (which was your for-next at the
> time), so it probably shouldn't be applied in its own branch...

> The return value is ignored anyway, so the code should work as
> intended, but a "return 0;", or -EINVAL, would be more proper...

Please send a fixed version unless the issue doesn't exist in Linus'
tree.

--K8zN2sh9fO5jmbe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp8iVAAoJECTWi3JdVIfQh+YH/0PEwvZZhcq8Mgz3Nujz9Lzn
RM9kHAWwoZOAV9GkjJu7FmiS9BY99NHXnIXofjzp5MBkqNEDL69wIuG2Z9reTQQd
nxrf9ROMQegG3AO1P85o4O+kmXHdsxWmCR8j1ZucsOBll/Z/Gbo2KIBOCFbCYaxI
dZPs35kgdobiHsFvNh5JpMqOsUHeIsudyEh1AThH6HeSaE6gbF6ShclH0nL0PVeg
Q2X8OSpSmeD8Qur1d9Hj4a89NW6n2xIu742nIb7rYt1NM6+hjULogYNWBzCTERwf
Wk96jlbIPxw3PNHA3s0W7HPctZBpbI2yoOpzUo+R+bba8AOWPYfgV/EAc0wrwPA=
=0S9L
-----END PGP SIGNATURE-----

--K8zN2sh9fO5jmbe4--

--===============8333267258428106174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8333267258428106174==--
