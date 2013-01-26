From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-compress: Cancel delayed power
	down if needed
Date: Sat, 26 Jan 2013 16:52:36 +0800
Message-ID: <20130126085234.GB30594@opensource.wolfsonmicro.com>
References: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7525364130753770081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D9392616E7
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 10:02:53 +0100 (CET)
In-Reply-To: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7525364130753770081==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2013 at 03:38:19PM +0000, Charles Keepax wrote:

> +	/* cancel any delayed stream shutdown that is pending */
> +	if (codec_dai->pop_wait) {
> +		codec_dai->pop_wait = 0;
> +		cancel_delayed_work(&rtd->delayed_work);
> +	}

This looks racy - the check for pop_wait can't be doing a huge amount
here, the work might already have been scheduled.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA5lLAAoJELSic+t+oim9FLQP/je8JbSLKx/qaL+AtBsNkJV4
c+GWV5hLTtDOdTFB0ewtpxgqQJaTtjEzUC7qEcCNXBOMEGBnOuGTM/ecCiUbJx6x
WgLK885Ibm3y6l3CFN3kFDK0ci2HRtlIUvjwBgX53eEQ9/f2PBJLZTddD3YaWYlB
lc5OefzV8b5kg413jZ1GgZS5lhmXAxix+DGZeglpHmiqx+PEoPFfMMkfc2TexSDE
5OXEQGpv43wck11nux/YfuMyGoq6X63cf6+4vAFTqXk7CDPCqDuRH98Asb9wPIej
gE+Qi/zUFNEpLFreKJETyuetK6ketvBEm/MsQr1Phz/TI30GE+qiqEasB/d7pVta
xmT/vov01L4tyalZmUOfrCEdRLvmAJzFi/ohL8yWQEOoJM89TacDMtOyRce77hxB
b4r1mHyiMCOmzDh9A5NliqPyBxVntCOXdMuCVg/GuR2q5c0Edf5q08c3GjQR/ja8
y4W6SmuA1ldsU/NNii2R41cSGzo8+ZNxlKvDMZhAXDLwRoB1JAYjlBHNIb82Q/nQ
IfmbxPcTLGWF/od8yQ3ojNt/Kk5rNVHoYwrkV+EPcotynOi/ZhQJqpFHZDw38qeB
MvRL5AIsV8b1UeSuNXaJldayFjhTFNGM5lE/EDWhgATUFx+T6XORGnj1rwGTrqQj
NlUiqTtv+0dk6TZbE6wg
=SNoZ
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============7525364130753770081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7525364130753770081==--
