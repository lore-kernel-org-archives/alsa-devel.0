From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add TDM
 channelselectfunction
Date: Thu, 16 Oct 2014 16:54:04 +0200
Message-ID: <20141016145404.GL2200@sirena.org.uk>
References: <1413367334-12615-1-git-send-email-oder_chiou@realtek.com>
 <543FB7C6.90600@metafoo.de>
 <7EB0DE829A537248AF2ED30C97D12694F29E4C@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5142685151289202395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56FFD2605C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 16:55:09 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F29E4C@RTITMBSV03.realtek.com.tw>
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
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5142685151289202395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 01:52:53PM +0000, Oder Chiou wrote:

Please fix your word wrapping so your lines are less than 80 columns
long - something like 72 is good to allow for quoting.

> Yes, it is for channel to slot mapping, and it is not only for 8 channels mapping, but also
> in 2, 4 and 6 channels mapping. If we want to use the 2 channels in the stereo2 adc path,
> we need to set the setting to item "2/1/3/4" or "2/3/1/4".

This should be implemented in DAPM rather than with a regular control -
we're routing audio from the AIF/DAC/ADC within the device.

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP9wLAAoJECTWi3JdVIfQRWIH/1vCFWTRUxDGw1JTmp09EDms
BUoXdPFYUaSYPUv8zw557Vp9T9Ca0ioB1Sf3FESyk1xEa7OFLmxj7YG/ttkksKab
KYOUt6uY0T51sjGuI7fg0g+iVV6Xk/ZDugnx6GlXOB46BOLLyK9NIQ6uLNzVr92+
gBERon3AdnxKmVZJogubRSF/rtp2lR6vkzGtIG+YNr9Fgu3NrsTu0/I0v+8YNOjQ
I0xgHThHXjyrkYvHwM0FncFuKiDKbj5nRPNdE8pKHFKWsoRq2Tu5wBMy8YNaUvcS
PIxuoE56SrFTrlbSJOSPGFBqBt6uIXWHBwY95kHMaPbBbLW9AhXTquQv8mTxQ1A=
=rm2x
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--

--===============5142685151289202395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5142685151289202395==--
