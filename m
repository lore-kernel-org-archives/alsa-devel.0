From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Mon, 10 Mar 2014 11:09:26 +0000
Message-ID: <20140310110926.GX28112@sirena.org.uk>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
 <20140305014259.GR13126@sirena.org.uk> <5319BF67.3060403@ti.com>
 <20140309081102.GL28112@sirena.org.uk> <531D98D4.7080806@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4405393151126461446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 287992650AC
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:09:32 +0100 (CET)
In-Reply-To: <531D98D4.7080806@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4405393151126461446==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFYJDJkv0E+Y9r9L"
Content-Disposition: inline


--oFYJDJkv0E+Y9r9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 12:49:56PM +0200, Jyri Sarha wrote:
> On 03/09/2014 10:11 AM, Mark Brown wrote:

> >No, it shouldn't do any inversion.  If inversion is required one of the
> >drivers is buggy, they are CODEC bit master and CPU bit master so for a
> >CPU driver the sense should be inverted when parsing.

> Yes, that is the problem. The same code in simple-card parses the
> codec node and cpu-dai node and they produce the same
> SND_SOC_DAIFMT_C??_C?? flags for both codec and cpu-dai drivers.

Sorry, thinko above - the master flags are specified in terms of the
CODEC.  Anything interpreting them that isn't a CODEC needs to be
inverting the sense.

--oFYJDJkv0E+Y9r9L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHZ1iAAoJELSic+t+oim9w+8QAIr/ZVIvmgx7zQbTl7Kbo7Xm
9BkCY9Dn0nRo7CpwQKzP712CdjwsLVgorZm0wpFvT5Gci4PyH37TP9unhV9R+B8k
uWBp5KCW5LC/mp4vVWqjSDEAnCSGdfL70k4zYm93iQJByHQossPPxCmjJn/ImHPB
S6+JnfYluror4SLDvtwQ047V7NGsxROKuTzbsTBOjDJ8kGKBLFDaE6OCUGzpzy+o
4iUqse9C7M1SIgWgmYm8OTzR0PasYlbnl89jWB+UUFZRhDDRpN48jghk6OcS19nj
XsXYmSkwxhOXyLm4fnTCHZmhsh34ZtniK0gIw5+On5Gea+tUbF2muZoscIFCm4nn
L+meWyWy5pms2J49P+eRlH4H9UCZHxD5kmlksSLZu/5uynLQhOos+1nLvxEz7MDh
kp2k2tDFwwQjuZStAkUauEam6+KNhYhG1R+wAcXMAuzHEktNNg8Cb89IMAHIHc5l
4RAd+B/Qk+VfX6F62ZjLfpXMciD4qne57jiPLURXshBVGjfpebuTu9F867ti6rPY
3yQMEZRd0X7xw/YKgpHwnmVDuVFkjCxAPtXwermH0I9HkVHn4pg/4+EO6OL4ExVx
RMAOJWXc/Z/Vo4Y7SMLt4r0MqTJdx7NfyWVVVpOIbUdqr/D3uzTWWu9DsMuW1JEj
gpeBmL+RzlveSTIX5fCM
=NEYO
-----END PGP SIGNATURE-----

--oFYJDJkv0E+Y9r9L--

--===============4405393151126461446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4405393151126461446==--
