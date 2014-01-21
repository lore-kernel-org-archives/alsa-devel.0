From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Add info print to note that
 the DSP has shutdown
Date: Tue, 21 Jan 2014 17:37:53 +0000
Message-ID: <20140121173753.GE17314@sirena.org.uk>
References: <1390320337-29339-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3256215213076082976=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E73EB2617AE
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 18:38:03 +0100 (CET)
In-Reply-To: <1390320337-29339-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3256215213076082976==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CnCWQepWw43huI++"
Content-Disposition: inline


--CnCWQepWw43huI++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2014 at 04:05:37PM +0000, Charles Keepax wrote:
> It can be useful for debugging purposes to see at what point the DSP has
> powered down, so add a message to inform us of this.

> +
> +		adsp_info(dsp, "Shutdown complete\n");
>  		break;

I'd have expected this to be _dbg() rather than info?  In general stuff
like enumeration or "we might crash immediately if this goes wrong"
would get logged normally.

--CnCWQepWw43huI++
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3rBtAAoJELSic+t+oim9km4P/3QpCNtXGvXXQE84lOKcM1YB
yDrVPZkWPJPMHTlIpToOTx7CBSXhNRjF7w9mgUdagmT658wXsOPh6bNgNqkxkgUE
LIFjm+yXJjGKVhSaTJ2/gfVhSdhCM/jC62lTet2jPnMqd7r/ew3wRA6zT+YmQQ1P
qpV2E1RVrb5Xf+7RAVZZ3YkxY2kBJEvGlZQ91qoZHsxiNkARNLbzvYYRZjiOY9Bs
CiMgK4uTJ50yRjJZCOwDKZJ71Lxb+n2LB2rYvYbE1/8U0rgsH+AjrNB1WEJBFeeN
VdUJ9aWhWFI4qEOSpWnReWshj6LesGOGorYb1J3TcID5sdYTuzoLscHonwJ5RrnX
camWcHMAeU6iwKOd7NFvQ8I09JfYefnx62uS7CFeto10I0iX8n26pqaFf70jkUqb
HL2OllFqx1DJxHZKkWMrkMs2EZtJ6J4NCQXpXCNJ2vd6i/tWoH15NWpYuuMywPAH
Q5Z47BZuYmNG6OoFHyPnzjMhKljQZzptzA21IOvEJY/4vbL0rGr0SneJz59RrQrs
zqZS5/z/ouiAD++s1zZmE0tfnmt31u83lgfgKXq2u4XxvwRs/JrRNkTSNLAsX/mT
a3RlHSokjsngJKyfaBK0U+LHC8oO9f94kIziR6o3ac+Vpw5uWfn+bB4diQPy/cTD
Q6nsYKoCexVMVdaVTERz
=0q1+
-----END PGP SIGNATURE-----

--CnCWQepWw43huI++--

--===============3256215213076082976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3256215213076082976==--
