From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5 v4] ASoC: ep93xx-ac97: Fix
 platform_get_irq's error checking
Date: Wed, 29 Nov 2017 10:53:09 +0000
Message-ID: <20171129105309.2wqsbzuzjez5272k@sirena.org.uk>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
 <20171120133717.kscrjsb3y7gnvd2t@piout.net>
 <5A12FC64.3020205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3432626182151049446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 54F1E266E30
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:53:14 +0100 (CET)
In-Reply-To: <5A12FC64.3020205@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, linux@armlinux.org.uk, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3432626182151049446==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="it7nn7vy6hvysgbj"
Content-Disposition: inline


--it7nn7vy6hvysgbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2017 at 09:31:40PM +0530, arvindY wrote:
> On Monday 20 November 2017 07:07 PM, Alexandre Belloni wrote:
> > On 19/11/2017 at 09:45:00 +0530, Arvind Yadav wrote:

> > To ensure this doesn't get applied: platform_get_irq can return
> > -EPROBE_DEFER and this must be handled properly.

> Yes, you are right. We should retry to get an irq for device. But ASoC
>  driver is not retrying. if platfore_get_irq() fail here, Driver is throwing
> an error.
> and this patch is only to fix error checking which is not correct in Driver.

> > >   	irq = platform_get_irq(pdev, 0);
> > > -	if (!irq)
> > > +	if (irq <= 0)
> > >   		return -ENODEV;

This is just squashing all error codes into -ENODEV, we'd be handling
probe deferral properly if we just returned the raw error code here.  We
need separate handling for irq == 0 which is an error but not an error
code and for cases where we've got an error code.

--it7nn7vy6hvysgbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloekZQACgkQJNaLcl1U
h9B7AQf+MEw+3M8uwNZt0x66Wsy3kExx4cA8WQSWP7Shgi3m2OdalB3RSdmWxjcw
oPLtT1YCe8bXhC7rSCUMokb2ZYj0lLITuuFDcIaS2GsmrMVPu+WuOOgtQtSUawEx
9nU1aWPN/t2mZJdSe0zO173MfWF7GsYKLgpcP/6lcQ0l/2qMFCH8mQWnYDQHBPQU
eztFCIQ2Bt4Or2mPt9764yaZLVzQqvPKXtog2/B63qIeVGPR24OyTO5hlBmiM3pT
dcR6tz0is6YL7bdLmVt+I8zqeZfLWoB99uDAFQWn1VxdZaFRBqg4VehBOFI3aNON
Rrp/BI2xUO3hihm6pHiTOPBQedAetQ==
=sxGi
-----END PGP SIGNATURE-----

--it7nn7vy6hvysgbj--

--===============3432626182151049446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3432626182151049446==--
