From: Mark Brown <broonie@kernel.org>
Subject: Re: tlv320aic32x4 Codec ADC and DAC must shutdown to
 alter clocks
Date: Wed, 12 Mar 2014 23:31:37 +0000
Message-ID: <20140312233137.GB28112@sirena.org.uk>
References: <53207878.2060107@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7926798077566663603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B9526509A
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 00:31:45 +0100 (CET)
In-Reply-To: <53207878.2060107@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7926798077566663603==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BpK73wlLlEVLFqq7"
Content-Disposition: inline


--BpK73wlLlEVLFqq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 04:08:40PM +0100, Mike Looijmans wrote:

> What I cannot fix is that changing the parameters (like clock
> frequency) must stop the DAC core.

> The DAPM framework just sets the BIAS to "ON" only once, and does
> not shut down until after a time out. Which is good.
> But if the next stream to play needs a different clock setting, the
> DAC must be stopped first, the code must wait until the DAC has
> powered down, and then the clocks can be stopped and altered. When
> all settings are done, the DAC can be restarted.

As a first order fix the driver should just refuse to reconfigure if the
clocks are active.

> I can detect the change in the hw_params, and on the first stream to
> play, this is called while still in STANDBY or lower levels.
> However, when the codec is already in ON bias level, how do I tell
> DAPM that I had to shut down the DAC in order to change the
> parameters? Just toggling the related bits will keep the DAC powered
> down. A routine to store and restore the power state is possible,
> but very ineffective. Especially since the "I must shutdown"
> conclusion can also be in the clock setting routine. That would
> result in multiple down-up cycles.

The big problem with shutting down is disruption to other activity - if
there's something going on using the clocks.  For some devices that
don't have long startup times ignore_pmdow_time may help a lot.

--BpK73wlLlEVLFqq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIO5WAAoJELSic+t+oim9wnQQAJNkl6FUxaoqDnGd+wrwbKot
+O9cE/qXHi6s9zbeB9qTBtXOIatW+cx4vwZ9DnyywfIdLJoJrycEKYdWFbRVWQ+B
PWPDldzypIosbpqEnIAlxBIuJ5K0gdQ1COCtk5Yvs3Q0ZB751VIHHazIJD/OTh/X
b034Q3PQVEsqZuAiujTHlvg4Zs/Rs445fcldKfHhY4cy6xl7IuZx0x+tPzku68Ho
EUqEPL0FdeCekQMDAobER7WTR3ZPbwINr0KHBGb/yVAUr5xKZd/mq8k50mUm6Lx5
PateDWip+mGXK2oUBKGvhVjo7LT+Ilu0Kj38r82ayaCZVXvU5xs4rOJ6/diieP7d
35pDpTo1R4R0rtCKbOzwx1Q7ljzMUhKGeB1zK45sd7xq8ZmZDJ8BssFrd5iM3s3G
uaCVwtEx1WYySi+qjk3pclvQ6QfWYaVsLkIerjqfxO8CCO4bgrEFITNr9wj+xNQe
VOmdKKvGJhnQF9keo3Z6lkEzLPwNmylqM5h6rFUHM/SZiI+kqlI8wgTdy7dz93y0
gXuqdjNau/9U9lM+KgkmBpFXWpL7bNDTTUbzHPQPCLL9VPY6K+zm8EAUzVihu1mY
QmCqJhmy3wiOnfYPkjbg2xJd+oydRXapZ/g1+F71nAD0C2Dar1uup6vjaKQ6QYoR
bVPCErdg/KcjCz5HCJLR
=bCVL
-----END PGP SIGNATURE-----

--BpK73wlLlEVLFqq7--

--===============7926798077566663603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7926798077566663603==--
