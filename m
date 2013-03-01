From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Don't enable FLL on REFCLK
	configuration
Date: Fri, 1 Mar 2013 19:12:35 +0800
Message-ID: <20130301111232.GX25302@opensource.wolfsonmicro.com>
References: <1361553037-423-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8184335050037439415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFCB6265DF4
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 12:13:03 +0100 (CET)
In-Reply-To: <1361553037-423-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8184335050037439415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RLVVO53zhS75EYih"
Content-Disposition: inline


--RLVVO53zhS75EYih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 22, 2013 at 05:10:37PM +0000, Charles Keepax wrote:
> Enabling the FLL when REFCLK is being configured is not what the user
> would expect and can cause issues if SYNCCLK has no specified frequency.

Applied, thanks.

--RLVVO53zhS75EYih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMI0IAAoJELSic+t+oim9sdwP/3u2H9HbQAsQXDswCn3ZNeu2
Ym5WzKmKkhdwTaNnU9l5tdz9FFy0L8M40iIrFA/vVBpvYCEP8/KVKkLmbCQNAX0o
PP049+9EE0BF+rBbRyT7C8s9CJxgePzCEVJZn3jGTv0WsphENmcchgJ1xtihn2J9
mCZY6SBd/Jd5A6zUrXlu4Ql1nwLhlz/RQrymFPnmtNM9Bumcv1BCsN+QKkP7Hj+9
/SGcm44QsrYFLDClJ6RJ43qpxK238ay52RN3qWn4TKQggCSP3rZGGcPxwv+qiIAL
yuggLX1RARMvNjrwp05bu0MYIjukbKG4yks70lwXoTX5W5XrmKTjeVhPHzeBQpC1
UYXNIl2wO0f4VBNgfNeGydPePArzQo+wKuzamZ3AOZcXvBkTFQV2emP8WoK4BWla
UJpWwCNkaZRXC1+1JQKSq7W6FVRl5fR+GI+tZRTZl7QIIPAnqaxuh3kYVWL4r/8x
KHDgDyfLWO7WH9dUIQQoCsk+59D4c83gGE8dBYFkhD59eyqFU3HKuSy8ME6nGpFr
ZpqCtU1DXYA6ec70zuoF+CfKAgHvqC2XFRj5hlsqnfLypxwQZMyZ4SbKDACJq+dP
c/spemxCeFWob5vp63gKxwB3eIWnWBQWuPC6YbMCApl/OHhE2C/Za1kVUdBA/Lg0
ZlY0qxXAQPgNlL/ciXIQ
=bjFG
-----END PGP SIGNATURE-----

--RLVVO53zhS75EYih--

--===============8184335050037439415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8184335050037439415==--
