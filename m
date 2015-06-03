From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: Intel: fixed TI button
	detection
Date: Wed, 3 Jun 2015 19:15:51 +0100
Message-ID: <20150603181551.GR14071@sirena.org.uk>
References: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-3-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4082159185722485382=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4BD3260703
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 20:16:09 +0200 (CEST)
In-Reply-To: <1432925772-117760-3-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============4082159185722485382==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cKagJxsNNshY2zoa"
Content-Disposition: inline


--cKagJxsNNshY2zoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 11:56:12AM -0700, yang.a.fang@intel.com wrote:

> +	if (event & SND_JACK_MICROPHONE) {
> +
> +		pin_status = snd_soc_dapm_get_pin_status(&codec->dapm, "SHDN");
> +		if (!pin_status)
> +			snd_soc_dapm_force_enable_pin(&codec->dapm, "SHDN");

This seems wrong - either we need the pin enabled or we don't.  If it's
currently enabled for something transient like playback then it might
get turned off later so we should still force it on.

> +		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
> +		snd_soc_dapm_sync(&codec->dapm);
> +		/**
> +		* SHDN is max980090 shutdown pin we can not disable
> +		* it in case we are in the middle of playabck or record
> +		* we mark it unlock only so dapm will take care of it
> +		* next time
> +		*/
> +		snd_soc_dapm_disable_pin_unlocked(&codec->dapm, "SHDN");

This is wrong, you're mixing locked and unlocked versions of the DAPM
operations which can't be right - the difference between locked and
unlocked versions of the operations is that the locked versions is if
the locks for DAPM are already held and clearly there's no locking code
here.  This last operation shuld be a normal _disable_pin().

I'd also expect it to be before the sync - there's no telling how long
it'll be till the next sync otherwise and no reason to leave the pin
forced on if it's not needed.  If it is in use due to some other thing
then DAPM should ensure that the state doesn't get changed by the
disable.

Indentation is broken for the comment too.

--cKagJxsNNshY2zoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVb0RWAAoJECTWi3JdVIfQbnEH/3oKbP2YGZzY3gIeA57Hfwva
FFdqG31AtAOStjwML9E8NRgVh6Ms9mZCuDUDQzpnXw3m3+w3C5ExQfaudqDfaqi0
LXZ4URySWneyxX0GMicbw5r6FJGQy96EES3vsFZKxL3bWAbqmzp+T5otDGo5EEcy
YaOCxHdqMJQL31ykWTZ7KivLS4B54ss558HJd/aDGRnvIC9SqO5akEx264zhjRJe
0jviCtmwygsR/IDmxaT5lpRNsQivSkAVJTuApcRlrCazAvbY7O8rBwi+ToGeSW12
PVnv6ASLxVeUD3qe0pBnuLA+f4okgRaczdINPwv2wSut1Xj6x/DRQZv6zILoQdI=
=mks7
-----END PGP SIGNATURE-----

--cKagJxsNNshY2zoa--

--===============4082159185722485382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4082159185722485382==--
