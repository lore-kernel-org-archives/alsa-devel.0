From: Valdis.Kletnieks@vt.edu
Subject: Re: [alsa-devel] linux-next - strange audio bug
Date: Thu, 02 Apr 2015 22:21:40 -0400
Message-ID: <4518.1428027700@turing-police.cc.vt.edu>
References: <57781.1428021275@turing-police.cc.vt.edu>
            <551DE25C.6020201@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1428027700_2100P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: Your message of "Fri, 03 Apr 2015 08:44:12 +0800."
             <551DE25C.6020201@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1428027700_2100P
Content-Type: text/plain; charset=us-ascii

On Fri, 03 Apr 2015 08:44:12 +0800, Hui Wang said:

> It sounds like the suspend or resume of power management introduces this
> problem. Probably you could reproduce this problem very soon just
> repeatedly suspend and resume the system.

I don't do suspend on this laptop, I poweroff and reboot when I get
wherever I'm going.

However... device-level power management? Hmm..  I *do* remember that
each time I found it dead, I was coming back to my laptop from doing something
else, so the sound would have been idle....

commit c4c2533f802d6877803c4d778def43d8a122f27b
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Mar 3 17:22:12 2015 +0100

    ALSA: hda - Fix possible runtime PM refcount unbalance

That landed in next-20150324 - which is broken for me.

Looks worth trying a revert before I bisect, thanks for the hint, will
report back (probably tomorrow) on what happens...

--==_Exmh_1428027700_2100P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVR35NAdmEQWDXROgAQISqA//esdta7q7PcQZ6HF7Za/8VjiBpBY5pgNy
f4/qwZtX9zcCgiYthlA1x1XaXnbv88FvXX71lyzjGs8Db9umb4plWGpMm0jIYf5H
25IussuZiY2XlaRlKK61hz8FHq1dpEDb1TQqDTNwDrXBT3zIh1HznI/eHd8kGK8p
U1jjCNpUNYrP29E8749D3VPaHwqkQK9IGwh0HKWzhJImjwHV8LOHteFmqdfF68fB
Eg4bhr5XkoIw2qSseKdFmKoUDxJjnq9pKWmq+YF2H52YgvSLj8WSk4n+8sMfRgFx
FPR4ugfJTrk6bpC8YeGFLDHveanyM0/eY+2J5tDGyU4e4H6OLoAfJWX+aNXvp+pK
p3IWTOYCzVq2/Rp4mmUz6dBo0gu7I/fL5EclpNZpDjxk8oYDZ7nMSk1bEp+lvByB
cgJ4jIUEdKh4LAib/Urve1bAMbkI6R97pvoynxWfHExoDTphal80wfJEgBv3XHSA
OAfHdUFK9v2gg27LPjnqrxrCc3RUYCJ3hbzkvOlNj6gezMNQI9UFaxRukp2AJgv4
uu+VBGURXx7bqU0D7DnihJnAMgxvLi0qYMGz1lkRg46MxAXCstN65iBhAOASap+X
7ztSbYi2tn5GXZgSGmFXYYlt54Q5UXfGaicrrcgAxXrF4zWNfd4LP1hLap/uy4Mr
X8tqvlZHVAQ=
=J/UZ
-----END PGP SIGNATURE-----

--==_Exmh_1428027700_2100P--
