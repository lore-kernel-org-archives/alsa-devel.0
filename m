From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Fri, 21 Sep 2012 15:37:40 +0200
Message-ID: <87haqrijiz.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1416055137522293391=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 09A55265D1C
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 15:38:18 +0200 (CEST)
In-Reply-To: <s5hwqzna4pn.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
 21 Sep 2012 15:24:52 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1416055137522293391==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21 2012, Takashi Iwai wrote:

> It's something like:
> 	hda-verb /dev/snd/hw0D0 0x14 SET_EAPD 0x00
> to turn off, and

This completely shuts down the speaker: no noise, but no sound at all if
I play something.

> 	hda-verb /dev/snd/hw0D0 0x14 SET_EAPD 0x02
> to turn on.

That makes it back to normal, with noise. :)

> Also, try to mute all sources in NID 0x0b,
> 	hda-verb /dev/snd/hw0D0 0x0b SET_AMP 0x7480

This seems to not change anything at all.

=2D-=20
Julien Danjou
;; Free Software hacker & freelance
;; http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXG2kAAoJEGEbqVCLeKXCcFwQAKHO8rc2Tn8mo8jbwNZcKkkU
XUdGkxfPHDnZuMcWu5XOWr1rFkWcazdIq/fvo/CHxK7EdSrivGMPEajy9W6sLfXb
/0s0EhH7AJ1wWhyb/4JyzKFKRShWPfHsclA2Phve5vdvcP/RR1+Aenou9+EUQE0G
vuqokOz/+MmuNhJEI+xX8znTobVhoxIE+hhc2QMWPxjYpRLZHutGIo4QHjzRF5Jl
57i5t56yOnyf+VkP2HVN8FtMjKKOQ0d0hoHjxyHiOGFW+QClN2PzgmEu2iWIVfDm
bof6JlZ2vEy4aawdnrWWbJGXHHLRrX+YNxeVO5AYTFi4k2t1zIDvLqoGOukZ8Ip+
JwgL9U0KMYgNn4lXfc6JDjqVdos0F6kjTk3aGcHwjkAHj2VHjRsjj2iksXaQUmOJ
w1bpSXXCuODZBDktpIAkZlF3AAbOr4o+cvKPhxuRGPKSNBLeDHh7dEU/vpFT7yCH
nMsC/QffyAv5KFW03lHEYYKYwgon/KOPhGEOUy3rpqk6gPccZvvdULUZorYsmNdm
6VSvgnZQWJAR6cnVwSEdp+hBLwEa38vj7CpW0j9dCfdk0p5v73Yw2zFo48fdeu5G
IOiuZUVeQuJ7dJymBwkQ3GqQpltaWzJ55p9KyM9j0lm0qPHU1Q/6ldZ7q9bgdtrE
V/91c6hfM+JccdnLTBww
=ahk3
-----END PGP SIGNATURE-----
--=-=-=--

--===============1416055137522293391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1416055137522293391==--
