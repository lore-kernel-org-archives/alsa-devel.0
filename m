From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Add support for DAI driver DAI
	widgets.
Date: Thu, 8 Mar 2012 13:21:04 +0000
Message-ID: <20120308132104.GM3638@opensource.wolfsonmicro.com>
References: <1331120862-16161-1-git-send-email-lrg@ti.com>
	<1331120862-16161-2-git-send-email-lrg@ti.com>
	<20120307203722.GL3107@opensource.wolfsonmicro.com>
	<1331208420.3782.17.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7810330471678387424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 448CF10BA1A
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 14:21:07 +0100 (CET)
In-Reply-To: <1331208420.3782.17.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7810330471678387424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZihrQ6eCIduWT38"
Content-Disposition: inline


--dZihrQ6eCIduWT38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2012 at 12:07:00PM +0000, Liam Girdwood wrote:
> On Wed, 2012-03-07 at 20:37 +0000, Mark Brown wrote:

> > So what this is doing is the above which is really about synthesising a
> > name for streams where the driver didn't provide one.  This isn't
> > specific to CPU DAIs, it'll apply just as well to CODEC DAIs that don't
> > specify a per stream name for whatever reason. =20

> yes, but it's more about creating a DAPM DAI widget for DAIs that are
> not named by their drivers.=20

Yes, that's what I said :)  It just confused me because it applies to
any DAI.

> > > Also add a snd_soc_dai member to snd_soc_widget so that we dont have =
to
> > > use the widget private data.

> > If we're going to do that I think we should just drop the private data
> > field, this is exactly the sort of stuff it was added for.  Currently
> > it's only used by DAIs and regulator supplies.

> ok, we could add a regulator * in place of the void * in a separate
> patch

I guess.  If anything I'd rather be pulling stuff out of the core widget
into private per widget type data structures as we do end up with a fair
number of widgets but at this point we're a long way from doing that so
either way is fine.

> > Isn't this going to get complicated to use when building up the DAPM
> > routes?  The device is going to need to know its own dev_name() to
> > supply a table of routes which would mean you'd have to dynamically
> > create the routing table (or just specify a name and skip the whole
> > thing I guess). =20

> I'm not needing to dynamically create the table, it all works as
> before :-

> This is the machine driver DAPM table. Here we are connecting the DAI
> widgets for twl6040 (using existing DAI widget codec code) to the ABE
> and the ABE to the Bluetooth device (using this patch).

This only works for the machine driver, not for the driver adding the
DAI itself.

> The intention here was for CPU DAIs only, the assumption was that the
> codecs would have a DAPM mapping to DAI or DAC/ADC by default. I can
> certainly change this to ignore the codec DAIs and leave them as is ?

Why not use the existing infrastructure?  It's more general in that it
covers other things like the regular controls which some CPUs have but
mostly don't currently use (digital gains and the like) as well as
allowing the DAI driver to map its own widgets if it wants to.

--dZihrQ6eCIduWT38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWLI5AAoJEBus8iNuMP3dru0P/16uWPjfZIXAZ+cjBGCr6+ST
WOMI5m2U6U3B6Le5UC1EHByG/LXFlgLWjETX71mMHk/e2y7z5H+DbE7vu60+snr/
b2sdticbz7kOa2DpP2ptrOqsM0YHLcTTZsJC075LQ9pnk00d5jfUxI8ESm8J2kc+
Jj60qCR7AN9FgAJ3UtYtDhNDxsayw3QGVsSoN/7fJ9GuoFm8XNyUyFDBDO+juTKj
7KlwfYRtkT05rl6zZnG4QIWiesqEiz2jJ7qefyFHgJe1jGvjtY8V5JabAcKW9jrX
akSY5yytKJPbZvKQzgrdF53W6ET9xVP/sDi56qrIHvIh64sTRNSkyQNia/S7EaWS
vfD8zl0alPfkAe5//Q5kYQGzhCyJD797gV/vuaKVbVckZmBz3zH3JC0zWImEOrxH
dG5L9rXJ4FIl/8EMQiHKAl+5ErH1dajrXPRqOxqkjAyKwRbHfaCymGI4xjHETlte
KhnZaEzUSYJ95jDUBym0ZKbH5boxxDHBy/mMQcZBCTfUo8blV2NbUUPF+b4KNAuQ
Xm3PCrR/iq8Qq2N52wq/7RC/BCu5ubDt7ue6ih9Ym5xX4WDTJTWlHSbRGeU0dDkd
sRXb41VOAzmaLQmGQ01x09l1EvGYdX6a9bhkO0YVIZ9HrHgTju1lfS0detFxTfME
wYnsFL7C6TPcpUaIZg3b
=T/IE
-----END PGP SIGNATURE-----

--dZihrQ6eCIduWT38--

--===============7810330471678387424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7810330471678387424==--
