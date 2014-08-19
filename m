From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: txx9: Don't opencode DMAengine
	API calls
Date: Tue, 19 Aug 2014 11:44:33 -0500
Message-ID: <20140819164433.GO24407@sirena.org.uk>
References: <1408463287-5546-1-git-send-email-lars@metafoo.de>
 <1408463287-5546-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6580254503072386080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2C126531B
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:46:00 +0200 (CEST)
In-Reply-To: <1408463287-5546-2-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============6580254503072386080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 05:48:07PM +0200, Lars-Peter Clausen wrote:
> Use the proper wrapper functions instead of directly calling the DMAengine
> callback functions.

Applied, thanks.

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT837tAAoJELSic+t+oim9aNMP/AhixAnwt6ZhPuv7o+PyXmqx
tzXNwXVYLk0pIb61/of0Ys3ksQOKVDAhizkQNiCZ97NJkPMcr49LLuDI472gz6mj
JJ2zOSlQrx6ztWLDvP/eRXfkSmsZMQIhUD/eWMZQSPSgPGAJqdCil/DdThpCYa95
WwScXoRUPCOpUSeAloxa7Ub7ZKacQhdfXv3mNjbK4S+2Lh9mw30u18uPcLV3101y
Vp2B5sRhtp7u/G49hWO9o5MivYPTixPlET/gymAn4LjhEa4bUCHfDdVakez0ZVNP
9mqE5Ahv3BPkp5/CZF9y3lramMQ6a4dLvhGdR5YU3ldLkEbscc9e1Ht97h865g2N
S8YmaR/0rul0ugKUIr1GHHTk3IEHTd7LwahQg9Rfx4Ukd7KeCwDr01Qclvt0rezu
xo5bzVz+pKG4jzGY7q1juabY+lAOyN8U3ZhAw0n6q36G55nxwY5gJ28xSRzGcv8d
RISxwmN9FVU3c+2QKEQkHneCjXWROzLeoNjULev78LWouvyfkNDTH69f2XWjzKAv
6GgjjcWtpo4nWAAmSIK36oXWpvE/ytEmfbdWwefeJN12uu5SV0r7azjzODGBaqpG
r/MDWC5naQA18jmfHCQSt06rtjckxY+JDoAyFYBgJ3//zAQDJlHq3b+k3XRYqlkM
Dx5Ni087rug5RdHnZwO2
=CGq6
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--

--===============6580254503072386080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6580254503072386080==--
