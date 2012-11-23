From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] ASoC: Samsung: Updates for v3.8
Date: Fri, 23 Nov 2012 23:59:46 +0900
Message-ID: <20121123145945.GU4529@opensource.wolfsonmicro.com>
References: <000001cdc95c$c1d7ec20$4587c460$@com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7991999301132464378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DB3A26031F
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 15:59:49 +0100 (CET)
In-Reply-To: <000001cdc95c$c1d7ec20$4587c460$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: sachin.kamat@linaro.org, alsa-devel@alsa-project.org, 'Sangsu Park' <sangsu4u.park@samsung.com>, 'Padmavathi Venna' <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============7991999301132464378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fzb4MfPSWK/5QThu"
Content-Disposition: inline


--fzb4MfPSWK/5QThu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2012 at 06:27:19PM +0900, Sangbeom Kim wrote:

> Padmavathi Venna (2):
>       ASoC: SAMSUNG: Add DT support for i2s

There's some problems with this binding.  The main one is the gpios
property the format of which isn't specified at all.  The requirement
for an alias is also very odd, where does that come from?

Some of the code also looks very peculiar, like the fact that it's
generating a clock name i2s_opclk%d rather than hard coding the clock,
the physical clock would normally be resolved based on the struct
device.

>       ASoC: Samsung: Register the audio dma platform device

This isn't the normal approach here, the normal approach is that the I2S
device instantiates the DMA device it needs - see the Tegra or i.MX
drivers for examples.  I'm also concerned that this is going to collide
with the existing static registrations that non-DT boards do.

> Sachin Kamat (1):
>       ASoC: Samsung-dma: Fix potential NULL pointer dereference

This should be sent separately as a bug fix patch.

--fzb4MfPSWK/5QThu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr49aAAoJELSic+t+oim9YkEQAIkCRauHX56GLkciC3C62NG7
Pd3wbiVr8+5x7NLCZMqKUGTzlQET9kPzLR6olXs/nwJqGjbAAtsGJMR+BHs81Snw
2ib4YJ4210tsKu4qBs9ENemuLaEpRMDEVfaulvaqEuSwyQl5rATUwA5o+tKQlxpb
0HHDWtFihNSZTdrbwQN31YJCX9IR/wkdrl5t4HnuMXGWL9zvWjwTTB3PhXWNzyeP
PVWHbwaVvhpbEFeVL7+QZr06LpUf65S7giezDWmnYmWmst2GhGpPE8b23ZsAruQM
Skp7nbeiK0qMpof4+UwinVpTGbyP4l9xZsoTuJBuRTfJ10E+iwABNMOpIhq1CdWh
7etB9wmV5Jr9UMwjKGrhnnuZBXoPsQKggpW1ZhhzmKjgi8N1mElU15nyRVJarGvZ
chbNM5mBK6iRaayVeGkCRLrdTpqDDixnLCjA7m2Py9H3Lz1nfhRZCRNbLQvCONN8
lS2XmRDBy+YH2B/rS+bogslvIY/CH+YbaKFniW+fmVVer6tSGgy/cX9jfSugpzpa
hYE8pTEHMpSMmpvBTvW0c63k/K5naV6cm6swY9+Z58SB4Eh54UK7t3Jkz5fpfqCN
u23S8TbrRJus0TLKnAczrs4gcDgxkBEcvMf59/+2HAgpYKj1xk90DBiJYK4mlAOY
8WAWVnNqnD0K+HN7x7fQ
=5LVx
-----END PGP SIGNATURE-----

--fzb4MfPSWK/5QThu--

--===============7991999301132464378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7991999301132464378==--
