From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt5645: Add the HW EQ for the
 customized speaker output of Google Celes
Date: Mon, 12 Oct 2015 17:45:38 +0100
Message-ID: <20151012164538.GJ4238@sirena.org.uk>
References: <1444274494-15512-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6914642922749827685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF83264F3F
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:45:46 +0200 (CEST)
In-Reply-To: <1444274494-15512-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6914642922749827685==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6K2R/cS9K4qvcBNq"
Content-Disposition: inline


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2015 at 11:21:33AM +0800, Oder Chiou wrote:

> +	if (!request_firmware(&fw, "rt5645_hweq.bin", codec->dev)) {
> +		rt5645->hweq.num = fw->size / sizeof(struct rt5645_eq_param_s);
> +		rt5645->hweq.param = devm_kmemdup(codec->dev, fw->data,
> +					fw->size, GFP_KERNEL);
> +		if (rt5645->hweq.param) {

I was expecting to see an ALSA binary control (I believe I explicitly
mentioned that...).  Why move to firmware?  If nothing else it's more
cumbersome during tuning.

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWG+OxAAoJECTWi3JdVIfQjxkH/2HwrSnbvSfBa2FViQ5cOQLu
1sdc1EzpQYqARcvVF3kYSva23XBLsXNme5iDnW7xgAAsiPnwplXBynCOg8hf/jIU
A5wwBtvEbgp+crQ8+4Lqf1uWuKPMqTbflQL7kT0hwxb4EoZ9ezCLTN8YjbQ3R4zn
aezmitfxem5LqpB6hvzJH9I6CmLTP1hC+JyilDT3RTeDXwGzre5WeKnVNO8aqUzV
CaSBhVAeWyOCjaeIAal/sCN5y9YZfSrFDG6RdWHEz6WbSEVS5Zvs21TzeeL9AITu
fWfLJDY3skVD48mPixJPE4GiMPUmmsMIwHnDzyAzSREI4uz9u+7CiB4od4g74gI=
=Vc5L
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--

--===============6914642922749827685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6914642922749827685==--
