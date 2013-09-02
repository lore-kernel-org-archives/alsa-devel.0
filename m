From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Mon, 2 Sep 2013 17:41:34 +0100
Message-ID: <20130902164134.GU3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831191414.GG6617@n2100.arm.linux.org.uk>
 <20130831193431.GI6617@n2100.arm.linux.org.uk>
 <20130902144713.GR3084@sirena.org.uk>
 <20130902145207.GY6617@n2100.arm.linux.org.uk>
 <20130902145722.GA12808@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1435786085009475536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 66DF12651C6
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 18:41:42 +0200 (CEST)
In-Reply-To: <20130902145722.GA12808@n2100.arm.linux.org.uk>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1435786085009475536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+VeMz1SRxFChf6vr"
Content-Disposition: inline


--+VeMz1SRxFChf6vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2013 at 03:57:22PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 03:52:07PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 02, 2013 at 03:47:13PM +0100, Mark Brown wrote:

> > > > This is caused because substream->ops is NULL.  Why that's the case,
> > > > I don't know, but I believe the PCM which is trying to be operated on
> > > > is the one registered against the backend (by snd_pcm_new_internal).

> > > Liam did provide you with a workaround for this one along with a
> > > suggested proper fix.  Have you had any success in using this
> > > workaround, or with implementing the proper fix for that matter?  I
> > > don't recall seeing any feedback on the results but perhaps I missed it.

> > I am not aware of any such patch.

> That was a little hasty - I should say: I have not received any such patch
> and I have nothing which suggests that a solution to this problem was even
> outlined.  (I have checked my mailbox for anything from Liam, of which
> there are a very small number of such mails.)

I was thinking of this:

   http://article.gmane.org/gmane.linux.alsa.devel/111647

where Liam suggests setting some ops as a workaround and that the
framework should just check for them before dereferencing otherwise.

--+VeMz1SRxFChf6vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJL+7AAoJELSic+t+oim9XO8P/00BLZvhglyGoEk4K+2/KlpT
nGopY76tafxxmE52S3VxUlsFgdAAa+50HnVqZ5si3quZXIy+mPm78AyOlyBFESBB
ZF6WirkEPItUf0RgzvNL7L2sDztHUnv7JBXUhzIVgpbW1JLrGMTUM2/DvvzM5ulH
+2On46EPHNSj7SYXdhRUZw9sNZY8pGKahwGqEmMZ+1t3vvqRDu6SYnwLqGV6qatJ
EOdRkK+H08xoaRAZ1wH+MvujfY4iYhhJWu1MDngvxGMfPhuDAri59BbMR4CfSF7X
OHQ4z4fz6Kb5Gb4t/Vy5H76GbMr94F4YFUdxPUBgPZu94P+OiPDkMAUHjbYQGM9m
gnC2xwAmtcX0eoywL4rNGzwH5DM0RmpZjsEZANKdVcVBbaPAkaj7Xk6YR1uWrXck
kYYB7ouskbW3gi1ZTVnNGlf+QfGvUtE28/DyLDdZE4y3FK+HtTF7HMEiHQmL3Zxg
Nb+ja14Xv5VoPeqHssGR/EKUsZSbgy2IOy44+QFXOrrvgj+VIitThezSXvTBo9QG
A2DTXjzXXBI4Rj5sJKGolwwD8JKWLWQm0/esbUgoqfTNp1C9JL0YX9AQ4N03tPW0
rqFpbTVEqwnTAh6+AtO1+/wBPbjoT7njsy6DiB1scIuyBx+1tlr3pSf/MdSYbx4V
R/BLdiBOpV70sXS0wkOk
=Vau4
-----END PGP SIGNATURE-----

--+VeMz1SRxFChf6vr--

--===============1435786085009475536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1435786085009475536==--
