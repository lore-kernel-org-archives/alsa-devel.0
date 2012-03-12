From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Mon, 12 Mar 2012 10:42:15 +0000
Message-ID: <20120312104205.GA3110@opensource.wolfsonmicro.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
	<1331316853.3789.4.camel@odin> <4F5A55DE.8020609@freescale.com>
	<20120311125558.GG3233@opensource.wolfsonmicro.com>
	<20120312091206.GA19513@S2101-09.ap.freescale.net>
	<1331544472.13303.2.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8965957248594316418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20D7124462
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 11:42:19 +0100 (CET)
In-Reply-To: <1331544472.13303.2.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <b04825@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8965957248594316418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2012 at 09:27:52AM +0000, Liam Girdwood wrote:

> snd_soc_dapm_stream_event() should not hold the codec mutex here.
> Something is out of sync between my branch and Mark's, maybe I've missed
> something out on a recent patch.

Summarising IRC discussion for the list: you identified that the issue
is that the CODEC locking change actually depends on some of the later
locking changes in your branch which didn't get in for 3.4.  Therefore
we agreed that I'll revert this change for 3.4 (nothing actually uses
it yet in 3.4) as suggested further up the thread and reapply them for
3.5 with the other changes that they need.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXdLyAAoJEBus8iNuMP3drdEP/1J0ShElOnM2DNHPx19zyCVY
7pK7wBGKlkChoPNLL2JVpa3/4DXnQKzrYXSnIxiVxLbyu6V8dszP3p7t5ONN4kSE
7XejS2E1lJcGpCDNbvO3FcyRtN7PdjkBOyXFGQJyP1LzZnmpf36RjBu38BGUZzYr
KkbGaCCLdCQ+/4W0zlaJxKTlQtjn03XuVOWBdImGIiFkNg4CQy2to3H0u+yl6Fo3
k9BTEJ8LsNRxPJtZdTkfxnYAp16zZhJ5dkBkwE0BA/MkNmDW5INRr43VMZiccETy
yjxRu2PQhiel+0NKFa3ANiPGPWIZ8aT1DpV6gYeSClap8EJBQ3X3RB5J+Evmc33/
qRwu11Jc8KF7vTqjBqfqfh56Rya7bL/qSEhwhu73YUtsbzKQqCYPVZo2AYnJQJqR
1xn+GSdtMVrzDWnGrh49gtb4vq4Fsh9SJ129Btb/vwNOVVgI2tHtwcc+l3IXkwrk
FcjvvRjeMVsV+m3XkmBjxdIy+YF5waU2qIOybvWT6xzNXfXTzVUZCI7jUSCB80MH
78SdIh4GztC8LMFDnpjVCHLhE4JzcazrGxvrMf9o7oisgu+KGWUcMDtbk6UCC6g+
a9NGqCJMzue8SNWkh4a183jPbgVKtAo2eUy6bWwme1B/IOTSJ4PdGEJXTBUr2F6f
/kWsD9tZLjW27p9IBQ1h
=iCw4
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============8965957248594316418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8965957248594316418==--
