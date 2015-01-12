From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Add the slot_width "25"
 support in the TDM mode
Date: Mon, 12 Jan 2015 19:13:33 +0000
Message-ID: <20150112191333.GP4160@sirena.org.uk>
References: <1421040895-15345-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4194616800922105143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 000642608AF
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 20:13:40 +0100 (CET)
In-Reply-To: <1421040895-15345-1-git-send-email-oder_chiou@realtek.com>
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
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4194616800922105143==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2015 at 01:34:55PM +0800, Oder Chiou wrote:
> Add the slot_width "25" support in the TDM mode for the Intel platform.

>  	case RT5677_AIF2:
>  		snd_soc_update_bits(codec, RT5677_TDM2_CTRL1, 0x1f00, val);
> +		if (slot_width == 25)
> +			snd_soc_update_bits(codec, RT5677_DIG_MISC, 0x80, 0x80);
>  		break;

This looks good but I'd expect to see something which clears this bit if
we're not using a slot width of 25 in case someone comes up with a use
case that changes formats at runtime (relatively unlikely, but better
safe than sorry).

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtBzcAAoJECTWi3JdVIfQM1oH/3TIibYlJi49D5QwXM/Uj/0e
C1MPddAulocv6VoUTCZfL9/73k9ShcrlMgRLC5Q9HL1xOURaOtMwrVCwWTNvZZ93
+8Bpg4JUeICGK2/210eqml6NGCpzSeZBqa4EXBxxw6UimDB/4cxkhV/UvXRqVwIA
ypCP4CwkfwP2S3mat110C2AI2az8mpEAuzCjkvXohsTByIRPVEDZAs4Jiidd8GLr
Tlh/4tSrbyki/ogH6o8xgxuTAaV/C881JBLPbwLxemurgfWAPMHl9Bkn6YIGJjZ0
BhJOI+LBub3NEoZCU/oW/h8IO+utsLyhE4OLApSE9snvyu03RkVvtDSIAAmRuks=
=5toP
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--

--===============4194616800922105143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4194616800922105143==--
