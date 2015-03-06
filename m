From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: Intel: add kcontrol to set
 parameter to sound effect module waves
Date: Fri, 6 Mar 2015 11:35:09 +0000
Message-ID: <20150306113509.GK21293@sirena.org.uk>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
 <1425281778-17513-7-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6169549162797352548=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AE29265D6A
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 12:35:14 +0100 (CET)
In-Reply-To: <1425281778-17513-7-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6169549162797352548==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hT+tXqDUvcIbAiTv"
Content-Disposition: inline


--hT+tXqDUvcIbAiTv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 03:36:17PM +0800, han.lu@intel.com wrote:

> +static int hsw_waves_param_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	/* keep an empty function here to match alsa-lib calling */
> +	return 0;
> +}

No, if it's valid to omit this we should be able to remove the function
- but I'd really expect to always be able to read the current state of
any control.  Applications should be able to do that and then write the
value back without changing anything.  Either we should actually read
things back or this should return an error (which is presumably what the
core does if the function is missing).

--hT+tXqDUvcIbAiTv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+ZDsAAoJECTWi3JdVIfQ/aUH/2qJlEQu0mK1S/LnaOtzXa1+
9eCqQwT6XmbRs9Gj60NV7q8VrmdYHzT8xmOFOT2uf5SZYbV0bBfWHPa0XHLyEK/p
hR5Hd+0jF5ACFnUfKze1wjvR9z+8vBeiS7k7eEY9uT6aJNjVWEru4yfNOluHxw9y
1ujf9AEPFth5WWQKthud5tnKKjabHFFDeuCTFHgqhGymL8XwhbTXsEhMXmWbX/Zi
SWdzorspJjoEWIXn7qk7vcRXOD/mSoBR3TmLoC/QQrTnQUkSigAzi1iQfPCQEX7X
SgJ+jB1wQ38GmjzGM47cPO5PJFUs+6NKRSQ3WAD696Ohc7Ikza4Txs/P43TKUa4=
=6aIv
-----END PGP SIGNATURE-----

--hT+tXqDUvcIbAiTv--

--===============6169549162797352548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6169549162797352548==--
