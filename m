From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 12:09:26 +0000
Message-ID: <20140310120926.GE28112@sirena.org.uk>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com> <531D756A.6000505@metafoo.de>
 <20140310091250.GD28112@sirena.org.uk>
 <531D84E1.8050706@metafoo.de>
 <20140310101038.GO28112@sirena.org.uk>
 <531D939B.4050102@metafoo.de>
 <20140310110502.GW28112@sirena.org.uk>
 <531DA21D.5080402@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3373574661130821616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B70265086
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:09:39 +0100 (CET)
In-Reply-To: <531DA21D.5080402@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3373574661130821616==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="70aYSAmNnA9rpJel"
Content-Disposition: inline


--70aYSAmNnA9rpJel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 12:29:33PM +0100, Lars-Peter Clausen wrote:
> On 03/10/2014 12:05 PM, Mark Brown wrote:

> >The only driver that I can think of which did anything like what you
> >describe was smdk-wm8580 and that was still only using one component,
> >it's just that Jassi preferred to split the input and output paths since
> >the DAIs were separate on the CODEC and he felt that was clearer.  It
> >didn't make any practical difference, it certainly wasn't due to startup
> >ordering.

> Take a look at e.g. omap/rx51.c it's doing what I'm describing and I
> presume it does this for the reasons I described.

Oh, rx51 is just generally fun - I'd be a bit surprised if it still
works.  It's actually the out of ASoC probe stuff that's causing
problems there, it was trying to do multi-component prior that being
supported.

> But it doesn't really matter. The important thing about this series
> is that card level DAPM elements and controls should be registered
> with the card not the CODEC and I think we can agree on that one.

Right, it's mostly just an alarm bell for review (I'd not looked at the
series yet, I tend to defer things until the people working on the
driver have had a chance to look).

--70aYSAmNnA9rpJel
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHatyAAoJELSic+t+oim9vqQP/RV7kPJ5LGS0rdU8JajZ3wPP
jG6khMrGU7ekdlyC1/9gdLWkxkpez8e7k8gWdEDX4VsNURoUiAVw7M8vmonq3fKk
8uimA+m2PMBdYOxpEOGzhKil0YT7S27YKwet1GWrS7QTuCgsMFE+b1hXCbyLeFza
xSKjNHHynC/63F9rfZCwWv/JIbBO3FUr3LDj9K7NTJiDHuBhO8L+xIfnYPoyVSxb
XtfHOb6MKh7vyaQYWkAOw5rtJxRd0IuNHJ3vpJn9LgTfVpMbLiasHV+RiZkxsvfb
Ffwk18WUCLp3BF/rG2gWFyv8kwL+HURYM3cj8T1WjFew9xkZ+Psvzl5oD5GOxdkn
wmQK7Vk5US+9iKmAbhgXMxJ/aOZSWkNTnCKzB7Iqs6SjRa/drOJv1oLkskVFk+kI
5d62B1rNT7g5hH2R5ogr+OlHD7D32TZx0GfXoj8sN2NQmYmfqJpo7aZD2n3lpVNV
A+EG5c9VTgsUq3eX4MT0jCSubTHsbeTaQQa4xDJ0FK+UAtrnYB2JY7mYI/rzcvL8
USfZGKwJHgFIlCGXRvSvASIVUKiWfLe/xsNTXQgGLeBu5oKqF73oJoTW4zl2twkY
lw3tr3vw6oMSbPv/lPlmlfn6ZObBqPkiD8nvLPDqtDXP5xS+BpIj6dzWculenqZt
Pb3eXORLK4wqVnhcwfC7
=Ttlf
-----END PGP SIGNATURE-----

--70aYSAmNnA9rpJel--

--===============3373574661130821616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3373574661130821616==--
