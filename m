From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 13:46:01 +0000
Message-ID: <20130111134601.GA20956@opensource.wolfsonmicro.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
 <20130111115207.GW20956@opensource.wolfsonmicro.com>
 <50F01644.30703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3468773736201921953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F559264ED1
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 14:46:03 +0100 (CET)
In-Reply-To: <50F01644.30703@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3468773736201921953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utUizcr4eQAkV3Ky"
Content-Disposition: inline


--utUizcr4eQAkV3Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 02:40:20PM +0100, Peter Ujfalusi wrote:

> Since the core saves the previous bias_level in before suspend I can just do
> this here:

> 	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);

> If we were in _OFF before it is going to do nothing, but if we were in
> _STANDBY it brings the codec back.

That'll work, yes (though removing the function when idle_bias_off is
implemented would obviously be better).

--utUizcr4eQAkV3Ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8BePAAoJELSic+t+oim9q5cP/1jgutLyS/MWjhKlBoKZMNTB
Q06tJ/sdk/Wl/zTH3HtI/7EY5sdOtXyu3xJ+YBpi5f0fnmOeix0rlqyHyww4dk9H
VwiHl/QVVO5hmBUvnydWlJ9mo+cY9cLvDoJ8DZF+ZFO7he5WXNFoM4vjhGcvNV5l
RzrcQpS4Ekif8cS9mBR4n8jFWdSRbuIu3sCRR3+TcecHjSOg/Xq/3rktZIJGS9Zu
jJgM7XE4BeZw1gXy4CfetPvLO5dVQWmWSZvEYuiA4U96U8QzFyxDUQhNfmdzC6s6
mjejV2ahZm03/xPjXrbNAmuG9UjVaKRAKntJM+kgBu3Gu5CdtKufsWtnzL8zTfso
4lpwl2O6SnGDsI3dQK+a7a5+O2C3k2QoXKzX3aX9wLGCkzpxAlvEUyLhMfKTeEz+
tU8ZIt3iHHRj3AYJYH33bFPUCSMIL/l3JLaHYjkyxqIO1vUSucChoySNRPx3fTMr
mq3cXtrXxFD6cc7WMOXXFkml0zuTnU1ihCs7s2sOU8Vq//j0iZtbO7K9eNHXcLKy
T5SIlliUeWxrgtvsyX+Fy4OELuxnTLlcBINOJdmetQyVAwrUzh2R+GDCDiJ8CPlJ
nwNG/7dBpA5+DpVCsSFFgivLcj0rJIEEjaRWudVRSioqltCI9Lfo+U5l9fGwYYvL
1NDXY3ULQyJmxbmXn/mY
=j19c
-----END PGP SIGNATURE-----

--utUizcr4eQAkV3Ky--

--===============3468773736201921953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3468773736201921953==--
