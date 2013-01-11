From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual switch
	controls
Date: Fri, 11 Jan 2013 13:57:54 +0000
Message-ID: <20130111135754.GB20956@opensource.wolfsonmicro.com>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
 <1357833977-3682-2-git-send-email-lars@metafoo.de>
 <20130111121912.GY20956@opensource.wolfsonmicro.com>
 <50F007DF.9000606@metafoo.de>
 <20130111124535.GZ20956@opensource.wolfsonmicro.com>
 <50F00BF1.6090702@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2487677220449239147=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 965D8264ED1
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 14:57:55 +0100 (CET)
In-Reply-To: <50F00BF1.6090702@metafoo.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2487677220449239147==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zKD0QXBepZ0ysD7Q"
Content-Disposition: inline


--zKD0QXBepZ0ysD7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 01:56:17PM +0100, Lars-Peter Clausen wrote:
> On 01/11/2013 01:45 PM, Mark Brown wrote:

> > Virtual enums do actually end up routing, that's not what a mute control
> > usually does.  You can do the above in the manner I suggested, just have
> > the register forced to a particular value when the DAC is disabled.

> Well, that's what the code does. The alternative is to implement more or

No, it's not (at least not according to the changelog).  It implements a
totally separate virtual control.

> less in the driver. Have custom put/get callbacks for the controls, which
> write to a shadow register, only if the DAC is enabled the shadow value gets
> written to the real register. And listen to the DAC powerdown/powerup
> events, when it is powered down enable all hw mutes, when it is enabled

What makes you say that this must be open coded in the driver?  We can
modify the framework code...

> restore the shadow register value. The virtual control more or less
> implements it in a generic manner so it does not have to be implemented by
> each driver which needs this on its own.

I'm having a really hard time seeing the equivalence here.

--zKD0QXBepZ0ysD7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8BoiAAoJELSic+t+oim9o4kQAIhjI4SowsNDCWI8NeU93uZo
rtURnkog4dSierJGuOTgveNTX+0H/yFJoBbK36HvF4ISR+heaa4RWhko7DUeXeN1
fMmjIo3rgjX9skUb8yoimsPAgqjNFbXNLD1ULI523agkg47IwOvIZl1/anmWUYGb
Ol6SLZgNMtUkW0yDEDkfQm9fVQtyLEqDRbIJMQcWfAujInWViTtRerARGzxLfAf3
+7nh+r/HMdtMyHTysXMrk2tiBmVGosGpd4SGpePjP+TO0j+5sirzGxBcV2w6grxn
ttZ5Vtjz3tsv3C5WVtQHhe6UmaV/KrF1c/kprdFLXzTteREc8JmffJtoIYv/nnu3
VBzlmxRrbp5wMIyzOATSVBtQllNlsa7WViUaBHM05GklO59s+TPeXeo19T6qoatQ
9wirJVDCbGyiKyhq89BaDJIwtD+sQIhXefFU5WnDd9pLdECxr2NVnr3KY5pwg1Ez
5JmBhGrSLg1jNLEwT9Y2dsuDErfCxyZXt6D8mvSXCyx06ipaZVT7NmKuqciBpJmK
8AavoneMEIezQpm6/gFHWjlG7qym2LSJspCLUkipsECFjcrSsj0jUcuy9k9WIhar
zDAuq/2XQ0I46MfBIh0uepr6znWza4MCb++d/krR7hANMXHo+DM+Lb3EwjsGF+ad
5Od24uOnOUTY9uMKWSgo
=3DmN
-----END PGP SIGNATURE-----

--zKD0QXBepZ0ysD7Q--

--===============2487677220449239147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2487677220449239147==--
