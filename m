From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Tue, 18 Mar 2014 12:42:43 +0000
Message-ID: <20140318124243.GV11706@sirena.org.uk>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
 <532588A3.4050301@metafoo.de> <5326F891.7090906@ti.com>
 <20140317165214.GT11706@sirena.org.uk> <53283DA4.2080609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5766448201357401207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E95A9260818
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 13:42:50 +0100 (CET)
In-Reply-To: <53283DA4.2080609@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5766448201357401207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LDKKMwhyHHnvsTPO"
Content-Disposition: inline


--LDKKMwhyHHnvsTPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 02:35:48PM +0200, Peter Ujfalusi wrote:
> On 03/17/2014 06:52 PM, Mark Brown wrote:

> > It's sounding like if we should be doing it this is a general
> > thing which we should be constraining presumably it'd apply to all
> > drivers, not just this one, and so shouldn't be being fixed in the
> > driver but it's not obvious to me why the period constraint isn't
> > sufficient.

> It can only be done if we have fixed FIFO for the dai. Right now this is kind
> of true for McASP. In HW we actually have 64 32bit word FIFO and currently you
> can set the desired FIFO depth via DT/pdata. I'm not really happy about this

Sorry, what I meant was more the bit where you were setting the
constraint on both the buffer and the period than the constraint itself
- that seemed somehow redundant.

--LDKKMwhyHHnvsTPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKD9AAAoJELSic+t+oim9nXYP/2FWMCkO9knjZm0Dj+koS3XN
YPvaKyUA88wk+R6y7f4MO4587BCvBDGa/SYBqIjqoA7JBTelMxTQ6uKJkhPfewbB
lkyrYUQXTtOo6S+/bIQwbVjjAqiBz6/W7ACVns4mio46axmFrPzBKq2imgzYN7aT
0rPOHYSPhRAidL5VlUUBhznvdE6uf1GEZTnSPNwx7tvC3pfQLWpDsnhez1icPUbs
goY6Rl3sRt1LJO6jYWm9uiSCTv+BAzRfMYvF9vxL0YK9Cmgs4dScHMAseMiWtqSV
DAkBQNKEZ9bNW08MvHBUY/2vrIjl0GfQNd3eD6KAs6oVRx1dE6vbKBSLVaGVYMez
qg/uIbAC6LGKQaQ+ndA9MATCiAG56MA4Ah2Qe3lE7jrU4VstG+k1oyYUbEwmyP+s
TEoE28hRZKzeZVUbTzTO+fD7ajEdTPOj8MFghD7X//i979oCsHBnMBLYqxn0WRfP
1/df9zcsBnp0i8humUTe1g+foTtUC8xRNfkb9Pe+3yURltKUKq2Uthv+qkrD7Zvz
GRrca7qQnSbJgwqHSBFbHX2Cj+fqeUAes2KOlzu735+kvLSaYSIG+4OMioF3OOP9
4g9pNVTJyYUP7oW45uqjEjuvCwpmqp4lg+IzKFJN368E5ZvvRzSX6kCv3/PntBEg
uRF8uYDVVu/JtwswoV8W
=VMEP
-----END PGP SIGNATURE-----

--LDKKMwhyHHnvsTPO--

--===============5766448201357401207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5766448201357401207==--
