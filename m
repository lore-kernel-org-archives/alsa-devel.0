From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4 v2] ASoC: wm_adsp: Move DVFS control
	into codec driver
Date: Sat, 21 Jun 2014 21:50:37 +0100
Message-ID: <20140621205037.GB24291@sirena.org.uk>
References: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1403275273-22713-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7601088319745193354=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BBC72264F34
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 23:10:37 +0200 (CEST)
In-Reply-To: <1403275273-22713-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7601088319745193354==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 03:41:11PM +0100, Charles Keepax wrote:

> +	case SND_SOC_DAPM_PRE_PMD:
> +		ret = arizona_dvfs_down(arizona, ARIZONA_DVFS_ADSP1_RQ);
> +		if (ret != 0)
> +			dev_warn(codec->dev,
> +				 "Failed to lower DVFS: %d\n", ret);
> +		break;

I would expect this to be _POST_PMD since it happens...

> +	default:
> +		break;
> +	}
> +
> +	return wm_adsp2_early_event(w, kcontrol, event);

...before we even give the ADSP event a chance to run meaning the
voltage will be ramped down prior to halting the DSP.  If there are any
connected outputs still live this might result in audible issues as the
device goes out of spec briefly prior to being halted and there is some
remote chance that it could cause problems on next power up I guess (it
did go out of spec after all).

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpfAaAAoJELSic+t+oim98BMP/1P0ASit9+bYvOVkLYKFsZhO
MkoFqpP2QWnlpMF67/kvjBOBqOZ/SP5v4isNBt7U2uybY7WhH70qTQoYEuGz1dX/
HyeZXa+cBdEiVWcpttHQONyCaLE/28eJQ8GH9lCo8H9ecBJ31myaYy26kL5CMFqY
uveQuXoIlGHHzDrJih3FUIokWoBUBFQNKddFKVxYIfWfw3fF9SzmUXwBqNR54T9J
j1n+WzBp2qW8fHRmJkZ/mTeyXN0Kk9/48YzVUEjkyRFtCtjw5ub9JgNko9CztoC9
Pklmo646Z8pn26X8NsMYBwtbLHg0G1m9MXk/y0XlElGVLdjZwBPs/b9qdFMin0VW
OZjNmUY2dUTe/F6rjRIfHLbwdjmhiC2LkMmbsrCCLlnQlYQAblemcm+yeGxs9yl7
Al8jpefHg6GHVMhnc7825YwPleCMcpo89UKXNltChBL1sBrQb6SCtdcgSscEHzHG
Rxfx4EPCGcGFLjWmzZlOP5tq2AlQcdd+i6tgOGRgmoU1/cP2azHM7wey/iHxiS8+
NhTrGynZPMqzbJHAP1WcmQMfMAX6Zf1+yRMgL382En0fB+zyJq454+Vobk2R8XWz
ruA614Cv8rdNdlcJYU0Jdtg1wGcp5lQGa+tRn/ICsCs+MXfrW7UYqlfPCbeS6jY8
srm5OAnyKQQxzQUGDskD
=jhYX
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

--===============7601088319745193354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7601088319745193354==--
