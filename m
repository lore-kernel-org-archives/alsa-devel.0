From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] sound: soc: tlv320aic32x4: Add rstn
 gpio to platform data.
Date: Tue, 30 Oct 2012 16:02:53 +0000
Message-ID: <20121030160252.GV4511@opensource.wolfsonmicro.com>
References: <1351610974-18395-1-git-send-email-javier.martin@vista-silicon.com>
 <1351610974-18395-2-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1841751512664061327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D7BB260309
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 17:02:55 +0100 (CET)
In-Reply-To: <1351610974-18395-2-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, w.sang@pengutronix.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1841751512664061327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GMArzDD+OGn24EFp"
Content-Disposition: inline


--GMArzDD+OGn24EFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2012 at 04:29:34PM +0100, Javier Martin wrote:
> Add the possibility to specify a gpio through platform data
> so that a HW reset can be issued to the codec.

Please use subject lines appropriate for the subsystem you're submitting
against.

> +		ret = gpio_request(aic32x4->rstn_gpio, "tlv320aic32x4 rstn");
> +		if (ret != 0)
> +			return ret;

Should be devm_gpio_request_one(), saving code for cleanup and making
sure there aren't any leaks (I think you have some in error cases here).
gpio_request_one() is better style in general.

> +		gpio_direction_output(aic32x4->rstn_gpio, 1);
> +		gpio_set_value(aic32x4->rstn_gpio, 0);
> +		ndelay(10);
> +		gpio_set_value(aic32x4->rstn_gpio, 1);

This looks weird - you request the GPIO active high then immediately
transition it to low.  I'd expect the code to set the output low when
putting the GPIO into output mode.

--GMArzDD+OGn24EFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj/ogAAoJELSic+t+oim91Y4P/A8zAFbDrpoKjt1b4PKaSDxT
pq0SzShYrjArGncrO7S6xKUXsSAkFaETh0Jf+d2jeCLMPQIuM1yT3qfDpFh11E03
usbkRu84rfC9tykhtvHrxNq1gZm0wCapw5nCqYXlnLDkEdM1woJ/zIe9FUGYRM8c
RBDht6obciGfiWSdNDJnQMKS4x01gxh7EuuAURuFQTg/pab7/O4dXnIuthNWTJGW
9fCM1FxZp/5zbaNMP7cSy1/huzXxErCZV4MQATE+xwjBFaxIIYpz49I1Fu54lzCf
daWmKHBL+vJME+7Op8c6qfMEXdBDA28t5M4NylAZOWHqRlCx7dJyKIkH3CbzqhHH
JvJgDU7VvomvucgScjo9w6CnFZFPSMaTCtHMkYK7SRbMy9aFPEpjSMglwhRBHhvh
8h9hK9m0YX2w+4r1dtbCwgP4b2jIsUspXOOiWWhZOej4WW1IzXxK6S8FJ0LRzfD3
fNwY+1l9U2xxxYwP+FFcl7EBfMiinqfMPEUFLblTdpdJ7jf8lq0Ulj9OcGCpuQcd
MZj/x4uk8+5Q5miWJxti1l0jLjdcMEY7d6HkNFNieqXki4oRlB76A9ZZ59Fhpn6F
GxtXCQMx/gdpOl6L4KA9SA6MLmH3KIXuXXCZul0NNo06RnKQ/tQMwU0j9Kdr3hdd
ucMJPQBANSFXxrMhWWGj
=hcOP
-----END PGP SIGNATURE-----

--GMArzDD+OGn24EFp--

--===============1841751512664061327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1841751512664061327==--
