From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Wed, 21 Nov 2012 09:43:58 +0900
Message-ID: <20121121004356.GC4673@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <20121120032659.GC4483@opensource.wolfsonmicro.com>
 <50AB9E56.5050509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8955366237947510575=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7769026168C
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:44:05 +0100 (CET)
In-Reply-To: <50AB9E56.5050509@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8955366237947510575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 03:14:30PM +0000, Liam Girdwood wrote:
> On 20/11/12 03:27, Mark Brown wrote:

> >With coefficeints we have been moving towards a model where we just
> >expose them as binary controls rather than doing the enumeration thing.

> For ABE we have different coefficients tied to each enumerated EQU
> kcontrol setting and just configure the ABE coefficient depending on
> the kcontrol value. We load the coefficients and EQU kcontrol at the
> same time since it's enumerated text strings are coupled to the
> coefficients.

So, the text strings for coefficients were what drivers used to be using=20

> We need to store on file, either an array of strings or an array of
> u32 values for the enumerated kcontrols (based on soc_enum). This
> gives us a fixed size file entry which is easy to read, write and
> count. But maybe I'm missing something from your question...

The issue is that when we have the u32 array we also need the strings to
be able to present the control - I would suggest just having the format
always include both the numbers and the strings so we don't need to
worry about the special case where the numbers are 0, 1, 2...  or
matching things up if the idea is that we have two separate records.

> >>+	dev_info(sfw->dev, "ASoC: no handler specified for ext widget %s\n",
> >>+		w->name);
> >>+	return 0;

> >Shouldn't this be returning an error?  The same is true for a bunch of
> >other functions.  Or shouild it be a dev_dbg()?

> It should probably have a comment. This is an optional callback to
> component drivers in case they want to use set the widgets private
> data at widget init time.

In that case the log message should definitely be dev_dbg().

> >This one is going to be especially bad for example.

> >>+	if (se->dvalues)
> >>+		kfree(se->dvalues);
> >>+	else {

> >Braces on both sides if they're needed on one.

> The last three points are personal taste, I don't mind too much so
> I'll change them ;)

They're all kernel coding style rules (the issue with breaking log
messages is a particular bugbear of Linus IIRC, rmk also gets very
upset).

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrCOGAAoJELSic+t+oim9rdAP/1Nly1D/tiodYklRv8NAQn2c
KIwlgSfROLAps/K3I2EQZdbbtuz4U9qhhhkHT+0xRuYI3pJJWEMyQIsCkhsF5nHO
af3oZ4k9uKSbuXcN6C4cqE19tOEN/ByPmWUcCWLEf21Eq2XSl1GIx6S/oF9QVZWL
N20ojUX72py00c4ccSMRv/smPW6FhXHSMmUDHrIzpG4WRui7rZrfi+8tkWt3ExcR
tbIWjGGr9w2Dah40qeCy26PFiLqLMkZkRNiB/0yfDDako7bCqN6ceZJ47JdWNs6k
3Hy7FtWFHe+uVHefMrcr7y53szXJJ4dUls6nc3DQh9fh2Deywx5NZExpAFddwivX
FoW2mWDSDLqWd2l/ScWc8kZ7GZfytfHGsCjYHVRZK8T/l78VmfRShOVF/hSgQq1X
xxJIy8/4qXtCIWhQJ1ytCpzlfdIG0RI04fI0bVQ7ci/dlS7GcEHdJfFLU/ZIIbP7
+pH5PHwxTf1+d1veRchRH6fHwbsNOAMQhaA2tVNSdMCCC4R2Xv9WIpxA/V+LtzBf
Og1/VKUYDtb273I8PYoScqbNJTouwOIa+0bKZ+V7ZKFCJ3bo7Orc8y0JTp6RS8Iu
Vljrio4OeIg6p/V5Ytv6q5mJ4bkQo8QVjbNhQrVJACcyCqptBGNXziJkTbriy1yv
6pC6zo8oE8hASlBkScyB
=014u
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

--===============8955366237947510575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8955366237947510575==--
