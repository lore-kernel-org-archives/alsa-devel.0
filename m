From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: Problems with the DP MST audio support patchset
Date: Fri, 31 Mar 2017 06:29:01 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19524866B0@SHSMSX103.ccr.corp.intel.com>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524854BD@SHSMSX103.ccr.corp.intel.com>
 <49ff23f3-7c58-abf1-f1ff-87822f0b0585@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E45C6266BCE
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 08:29:06 +0200 (CEST)
In-Reply-To: <49ff23f3-7c58-abf1-f1ff-87822f0b0585@pa-w.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>, Pascal Wichmann <pascal.wichmann@pa-w.de>, Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Do you have some suggestion for this issue.

Hi Pascal,

Please see my comments below.

>-----Original Message-----
>From: Pascal Wichmann [mailto:pascal.wichmann@pa-w.de]
>Sent: Friday, March 31, 2017 2:12 PM
>To: Yang, Libin <libin.yang@intel.com>; Libin Yang
><libin.yang@linux.intel.com>; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] Problems with the DP MST audio support patchset
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA256
>
>Hi,
>
>> Get it. Basically, 5.1 audio should work. What format are you using
>> for testing the 5.1 audio?
>I do not use a specific format for testing; the issue occurs using speaker-test as
>well as using any application with audio output as for example vlc, rhythmbox
>or a browser like chromium or firefox.
>
>As mentioned, when configuring the output as digital stereo or 7.1 surround,
>except for the second issue explained in my first mail (which actually is more
>annoying) the audio works.

Yes, that's strange. I asked about the format is try to make sure you are using the
same format as 7.1. As you are using speaker-test, the format is not the problem.

We tried to reproduce this issue here and unfortunately failed. We can't make
the HDMI work through our AV receiver. 

I checked your alsa-info.sh output and didn't find the problem.

Regard,
Libin

>
>Regards,
>Pascal
>-----BEGIN PGP SIGNATURE-----
>
>iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAljd8yIACgkQ6+YIa34W
>/zY3Bw/+MW4ziQgRwY8/ElLytL9ewBQaft4DZLZoVaJomIwhgpr1y135rpJRnmM
>B
>XkQk9Qr7qMTmE8/wTssEwJwZ38HFcrn5sSGlhIPIcqy3J3D4EM3ANTo0xzl2yoYc
>zLxPuu+t+hPBeWOZgK34IjhQzuRZLXx5lsPFNpCAzJKbP8RTExw1Zu+OvbZQAieU
>YM7T6nf3s98BF2/1DLdXjl62PDxVQ08olPM/euEhi3DzsZs60hIkI6ebNsXy6xnN
>Os+bHh5Mgc5vdjjDEQ9+or8aPFd9FeOo1qSZemNPe3h8OLCtuUt53SkmJwqpW
>3qH
>L8Wa/xjOxPFDVw9Ehyp+jD51s4lY+xk0h4+De+lL1pq0srNM1NdDEh0+x5kjCBf9
>l2XaXN0sxmDmJkIRzdPYrQ1NB3ieNAhqHGcj+Zb4x/gzH8WJ8Z/+VQZVu4sntorj
>4JcIzmw7U8LdU2t3ytqZ6JTlrr1t+V31gIDQuB1M5G336Qj7F5XVJxVc989uEOkP
>qWIMLXrWXUhKqMSBfpQkTAFKGbD4xR6A9Em/efRdXFkZH+AXiZxTSfZt1dSFqO
>Z6
>OtVhL3Ew4RW7xSXTwILB1eh4uoFnztLm9VCB9JGoge2OQII8QcNMUbdoNtoNjL
>xh
>XkMkWCnd8iPYH0ix0dMKdaTI0c8JUCWZKjun2Tx9jePLoMuqE60=
>=JrNV
>-----END PGP SIGNATURE-----
