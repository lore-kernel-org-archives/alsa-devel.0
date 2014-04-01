From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Fail probe if we fail to add
	dai widgets
Date: Tue, 1 Apr 2014 13:30:46 +0100
Message-ID: <20140401123046.GU2269@sirena.org.uk>
References: <20140331144712.GA6263@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3406637237241739322=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34C232652BE
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:30:57 +0200 (CEST)
In-Reply-To: <20140331144712.GA6263@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3406637237241739322==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BV9bEMyK3jSSO1UG"
Content-Disposition: inline


--BV9bEMyK3jSSO1UG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 03:47:12PM +0100, Nariman Poushin wrote:
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>

So, I've applied this on the basis that it'll at least print an error
but...

> +	list_for_each_entry(dai, &codec->component.dai_list, list) {
> +		ret = snd_soc_dapm_new_dai_widgets(&codec->dapm, dai);
> +
> +		if (ret != 0) {
> +			dev_err(codec->dev,
> +				"Failed to create DAI widgets %d\n", ret);
> +			goto err_probe;
> +		}
> +	}

...this doesn't actually do any cleanup of the widgets that were added
if the failure isn't the first one in the loop (which is a prexisting
bug with the handling of errors on probe()).  We're also not checking the
_new_controls() immediately before (but again, that's a prexisting bug).

--BV9bEMyK3jSSO1UG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOrFzAAoJELSic+t+oim9HO4QAINsB/mO94yqWJbvtwjfsM0f
Q4PJb1qJb7Ymcq+lXmgueug7l/m1wyPqyu2qbVkcCsBGrWGM1UY1FgTV3gB3gUts
tu0uoAhs5nZVMdM46zEPWECCMGjn7L3tT7DFMf79c0A7yZt7ndNAFpGnDHYfohdb
eKgdqZ1wfL+xsbXDrxBNsL2b8C26ukWA+iAMmP9t62wyEoVfEpdtzYdjJi08fEJQ
c4+yWuD8RskExOLkCRET8tFSsDFJV8fwogAjp0U85c9ln9EOyR+p13/4VyESp+mM
B+w9d/CN/655ERw+YMZ4sNRcsIPpR57UAPBOL1PhlCafhyxSJqtZAA5NFSF6jwSG
9Xrcy3OsKfEUsSrWbmvSuj2kckG5vvZCihCrnyKXNSyLfJW0Xsag/i245U2DKy2A
efrniE4QUXhJ264FEwRCqik5OB++NlsORwcFJobdkIj6cIvKXi4n8+5wfiMVwZWa
dE6KkjGikSjaTWc8BYq4/gm4pfo4bstn57orcymjhuIWG+TTrARd5FK0JJMvOfkb
idCL4Zrj9WCCpZW3Zjmp7Vr31HZ6SejeyqOg6LcYX1+7sGWJZ/yNxiQ7VaE1bvCl
lffDvpNhd+58U1hFJJXnE/oyOoHiSaOlLuIw0RTKmjQwewO6FtD/nyzTd+rCTxI0
OsGZijkhpzC9HMLeqhrT
=P0LK
-----END PGP SIGNATURE-----

--BV9bEMyK3jSSO1UG--

--===============3406637237241739322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3406637237241739322==--
