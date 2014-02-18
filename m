From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 3/5] ASoC: Intel: Add Intel SST audio DSP
 Firmware loader.
Date: Tue, 18 Feb 2014 10:35:10 +0900
Message-ID: <20140218013510.GV2669@sirena.org.uk>
References: <1392643930-6030-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392643930-6030-3-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6179067160792581942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 927AB26508D
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:35:44 +0100 (CET)
In-Reply-To: <1392643930-6030-3-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Benson Leung <bleung@google.com>, Jarkko Nikula <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6179067160792581942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7XuS4gr/+Xj300Yp"
Content-Disposition: inline


--7XuS4gr/+Xj300Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 01:32:08PM +0000, Liam Girdwood wrote:

> +	/* copy FW data to DMA-able memory */
> +	memcpy((void *)sst_fw->dma_buf, (void *)fw->data, fw->size);

There aren't going to be any issues with alignment requirements for DMA
with data within the firmware?

--7XuS4gr/+Xj300Yp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArjLAAoJELSic+t+oim9Wj0P/i0+dhhnSwnXJTWZv0EbBnut
ZEM19EcYtiUn/T8Rz0KdCn/m4FEVUrrgzBxISqlLehmzGjhIurEypVWcYiwCietC
6onv4t2VBrCF0zae63o01O0NBUa4KA+K9rdNQLBSFDK8mr7/bat3W5DVaEL2MmpO
pPFvafPgevkWpgvdWHvc5aM/i+s3SxPanCq09+QN4Xp0NDpR+C7nqnAya21anVh6
pM+gqSlv3gdb1T4VB5QQSRuTiBtWt4TetyR+pf++opJFNw6fVY5CMcw7dOhD3BTK
0F3Kth2WJwkAjfx8E5XR1AA9H+7nKUvzU32BqFTsRqqxLtegVZx4TKW2uxFHMM0t
8N7si02mdIc2SjmZV2x08QK7LASTYjIYN/sdzjbZx4/hObVDuW7Qdz4er0T47vYy
iNLLe0jzW+KRFU3tpuPBlxnfLX7M6sOCM0UmdVEj3w3sobBghP99VVQXG1mlqdv+
91RLgS1CDqL33XLL8et0wquW6+b0mfM7ZduJ2CGsmAMcbOdc96X33b3vUnMWSScx
gEW1KiFdVsLcFW+F+mzN+W0XisWtX4H/ImToecIvzk5bpPiUcNbksilnUESqQpeZ
R3Eusv6CYvFS/phNS8tTVxIMRrs5nfMM614ZZUs6uGz5nkMx2NhYBy00aSk6QW/0
cX7hJZc/x9LRCZgbaZJZ
=KEKt
-----END PGP SIGNATURE-----

--7XuS4gr/+Xj300Yp--

--===============6179067160792581942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179067160792581942==--
