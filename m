From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
Subject: RE: Intel 8x0 static & compile error
Date: Tue, 2 Dec 2003 19:07:43 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D303@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The artmessage display open in OSS mode.
The codec I use is cmedia's cmi9739, it doesn't support variable rate =
(VRA).

Sincerely,
ChenLi Tien


-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2003/12/2 [=ACP=B4=C1=A4G] =A4U=A4=C8 06:47
To:	C.L. Tien - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] Intel 8x0 static & compile error
At Tue, 2 Dec 2003 17:36:41 +0800,
C.L. Tien - =A5=D0=A9=D3=C2=A7 <cltien@cmedia.com.tw> wrote:
>=20
> I found that if I forced the aRtsd use 48000 sample rate then there
> is no the static problem, I guess there is a problem in SW sample rate
> converter.=20

ok, at least, a step forward :)
could you tell me whether it runs on ALSA native or OSS mode?
(i guess the latter.)


Takashi

>=20
> Sincerely,
> ChenLi Tien
>=20
>=20
> -----Original Message-----
> From:	C.L. Tien - =A5=D0=A9=D3=C2=A7
> Sent:	2003/12/2 [=ACP=B4=C1=A4G] =A4U=A4=C8 03:51
> To:	Takashi Iwai; alsa-devel@lists.sourceforge.net
> Cc:	alsa-user@lists.sourceforge.net
> Subject:	[Alsa-devel] Intel 8x0 static & compile error
>=20
>=20
>=20
> -----Original Message-----
> From:	Takashi Iwai [mailto:tiwai@suse.de]
> Sent:	2003/12/1 [=ACP=B4=C1=A4@] =A4U=A4=C8 09:54
> To:	alsa-devel@lists.sourceforge.net
> Cc:	alsa-user@lists.sourceforge.net
> Subject:	[Alsa-devel] ALSA 1.0.0rc1 released
> Hi,
>=20
> today we reached ALSA 1.0.0rc1 release.
> as its name stands, this is the "release candidate" for 1.0.0.
> if no show-stopper bug is reported, we'll release 1.0.0 really
> soon.
>=20
> this version includes the following fixes since the last 1.0.0-pre3
> release.
>=20
> Drivers:
> - fixed OSS emulation on kernel.  quake and wine should work now.
> - fixed intel8x0 PCM.
>=20
> Intel8x0 doesn't get fixed, at least at my machine. I still hear =
random static.
>=20
> The system was installed with RedHat 7.3 and kernel 2.4.18-24.7.x, it =
is easy to find this with KDE and xmms with aRts plugin. The aRts server =
sometimes complain CPU overload in a dialog box.
>=20
> I checked the old versions of ALSA-driver, I found that up to =
alsa-driver-0.9.2 works fine. Driver later than (including) =
alsa-driver-0.9.3 has the problem.
>=20
> I also experience following compile error since 0.9.8:
> make[2]: Entering directory =
`/home/cltien/org/alsa-driver-1.0.0rc1/usb/usx2y'
> gcc -D__KERNEL__ -DMODULE=3D1 =
-I/home/cltien/org/alsa-driver-1.0.0rc1/include  =
-I/lib/modules/2.4.18-24.7.x/build/include -O2 =
-mpreferred-stack-boundary=3D2 -march=3Di686 -DLINUX -Wall =
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 =
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  =
-DKBUILD_BASENAME=3Dusbusx2y   -c -o usbusx2y.o usbusx2y.c
> In file included from usbusx2y.c:82:
> usbusx2y.h:11: redefinition of `urb_t'
> /lib/modules/2.4.18-24.7.x/build/include/linux/usb.h:473: `urb_t' =
previously declared here
> usbusx2y.h:12: redefinition of `purb_t'
> /lib/modules/2.4.18-24.7.x/build/include/linux/usb.h:473: `purb_t' =
previously declared here
> make[2]: *** [usbusx2y.o] Error 1
> make[2]: Leaving directory =
`/home/cltien/org/alsa-driver-1.0.0rc1/usb/usx2y'
> make[1]: *** [_modsubdir_usx2y] Error 2
> make[1]: Leaving directory `/home/cltien/org/alsa-driver-1.0.0rc1/usb'
> make: *** [compile] Error 1
>=20
> This compile error happens at least since 0.9.8, it works with 0.9.5.
>=20
> Sincerely,
> ChenLi Tien
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20
>=20
>=20
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
