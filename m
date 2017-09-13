From: Tom Rini <trini@konsulko.com>
Subject: Problems with Chromebook Pixel 2015 audio
Date: Wed, 13 Sep 2017 10:55:48 -0400
Message-ID: <20170913145548.GC25597@bill-the-cat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

Entirely unrelated to the regression on this board that we dealt with
the other week, I have (and have had for a bit), a problem with audio on
this laptop.  After a while of use, I'll have a problem like this:

Sep 12 20:59:30 oliver kernel: haswell-pcm-audio haswell-pcm-audio: FW
loaded, mailbox readback FW info: type 01, - version: 00.00, build 77,
source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
(everything is fine, audio works, is in use)
Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
error: audio DSP boot timeout IPCD 0x0 IPCX 0x0
Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio: ipc:
--message timeout-- ipcx 0x83000000 isr 0x00000000 ipcd 0x00000000 imrx
0x7fff0000
Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
error: stream commit failed
Sep 12 21:24:04 oliver kernel:  System PCM: error: failed to commit
stream -110
Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
ASoC: haswell-pcm-audio hw params failed: -110
Sep 12 21:24:04 oliver kernel:  System PCM: ASoC: hw_params FE failed
-110

With those last 4 messages repeating constantly (~3 sets per second, and
the above are from v4.13, but I've had similar for as long as the driver
has been mainline I think) and it only stops when I reboot.  Rebooting
may or may not clear the problem, last night I had to power off to get
audio to come back up.  I'm not quite sure where to begin debugging this
issue.  Does anyone have any suggestions?  Thanks!

--=20
Tom

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZuUbzAAoJEIf59jXTHXZSCfUP/31c4pdOIpWAGm1swjwrkCAx
uMY5N881nlwUhHauvHY2wjyBMW0dYqLWPrnNTRmQlXQZ6Cg3Q0TePepGUb5cSLyI
ZW8qfMb7WTGySdtsB62WH6xEQHi3sCgrb/JVq0ScFe3dN2jEK7DiGCCL8SgdBEH2
rSWXigMOTtaPuBoT1Jj5z1Os5Pd4QAztP/JvZ6E8oYU97nJyLsEWHcmvKx6nCCdZ
Ji++4evV6nZv7yzaz7KFDGzHvZc/6lF80lRT95ZT6WRfPTvJX2EzLj4Bbk6UufDk
t9M1ELlotUoiLv1INvOkZJLOFGJABeaNGNWHS55w8o61skwLrcGmh2MchnIt0OnP
FL0S5LonPbNP6L2B0vZF918HKM2hqWvGisUhMPhIARo33j1QuypOCw1EVRd4c6cD
MdAtK/z84dEXltmfwMnQt1O+7EfGQqqYmyJ/8oOdniBjPCamWA96ntsW6KAXcYsu
io/QxWKcq+n6LgQRnNu7Si6cc1ZthYM+MEIJ5ZPRP51b8vB7pq8k6PdUqzOmIECX
u6fMYkxhjRgP9UfjIdmvyHu6gZfYCuAoiVLIWdGQBR64deEtKyQkM6QqHuP1DN42
VCti+PtxT5e1HZtpuDfC9hq5TdR9SfNMFp4bzu1f82J6NY84+bIxrO6+AMns75VU
IkmY6cc4fo3bDYgKFt2i
=Y2rP
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
