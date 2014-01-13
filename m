From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Mon, 13 Jan 2014 15:44:57 +0000
Message-ID: <20140113154457.GY29039@sirena.org.uk>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
 <20140113123721.GV29039@sirena.org.uk>
 <20140113131828.GC12183@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9006544428363405977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 740E6264FDF
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 16:45:06 +0100 (CET)
In-Reply-To: <20140113131828.GC12183@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============9006544428363405977==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y4JO1JP6mbYWtFW3"
Content-Disposition: inline


--Y4JO1JP6mbYWtFW3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 02:18:28PM +0100, Markus Pargmann wrote:
> On Mon, Jan 13, 2014 at 12:37:21PM +0000, Mark Brown wrote:

> > Applied, thanks but you should really also add this compatible string to
> > the driver.

> Oh, I didn't notice that the 320aic3x driver actually has of_device_ids.
> I was using the 320aic3x4 driver which only defines i2c_device_id but it
> still matches with the compatible fields from my devicetree.

> So perhaps it is better to drop this patch as it is no explicit
> compatible in the driver?

Or you could add the compatible string to the driver as I suggested...
I don't see any reason for the device not to have a compatible string?

--Y4JO1JP6mbYWtFW3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1An2AAoJELSic+t+oim9jRAQAJvCrlCt+/VsqX2uP856iTzI
5olsUMkldggeUoa2di/RJ2DMjK9/YEKDmN7hT7T+1Vk0ULd5jMhjiq4sdiIKKNQH
c9h9ot7UUuBMv3k2Nls5kEnJBjzeBqL3gxFR5Rz6IsGUB6gCkpF3WWohoyzpl3YP
CLgjCb9SEQ/XsdGwWDr0JSjx8O82eQxF/WzZ1sZMc95pVCck9qZDuRLSvO/GxXjq
S2Ey3EOhfs/soUIFFCa0nhER5W6Ws0xtBxEo1pUKrT9j5byp0cLDoIThxpoD9boX
/mPP53QaHagLC5i/+vBET0UF3fQvGg6FxIHSZFwOznDihjkDLqXAzBQ+ajsBHG9W
E/lkFnKQ6gh8uRbqQ6mCA1sYH1ghI2g6dlCXWXyk2cyKqKr1xHvy9tsG9DnlOF1R
b3kezxulhqpHj5BoqU1Ps8p5TSKSSPbHawXOdHhN1dwIoqO701FS4zQvJLpvPx3D
9yOFn++UJn0nCIVvoWrq0zS235cQOVP3HxlwHuRne0laOrB1t/DNI1lr588KA1J+
6Armof9QWIRi5h2vIcRYkYhvdtG+JiObSSWZyTfB/fOkDmCx4LiudX+ozMovDkyT
TxJXLhtzP3PVBiikEeh/pgrUQdxnJKlrgBiR3fkpBbxPgdffxHOBMrJCxAqCFTcM
nKAFyoY6fp2WfyANkTRe
=6VhC
-----END PGP SIGNATURE-----

--Y4JO1JP6mbYWtFW3--

--===============9006544428363405977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9006544428363405977==--
