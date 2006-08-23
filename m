From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] sparc dbri: hardware constrains added
Date: Wed, 23 Aug 2006 12:53:48 +0200
Message-ID: <44ec33bc0f4e0@wp.pl>
References: <44eb445108302@wp.pl> <s5hhd03ssdo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <44eb445108302@wp.pl> <s5hhd03ssdo.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dnia 23-08-2006 o godz. 11:39 Takashi Iwai napisa=B3(a):
> Missing braces in debug prints of dbri_cmdsend(), but others look
> fine.  I queued the fixed patch on my tree.  Will be committed
to the
> upstream soon.
> =

> BTW, dprintk() should use "do { } while (0)" so that it can be
used =

> safely without extra blocks.
> =


I haven't catched it because debug prints are disabled by the
patch. It will be fixed in the next one.

I started testing the OSS layer and it does not work on sparc32.
Is it something broken in the OSS layer for sparc or it is likely
a driver issue?

Before my series of patches, I got no sound through the OSS
layer. With the patches I got sound but it is played too fast and
deformed (random jumps in music play).  I found the OSS layer
works by continously starting and stoping sound after each block
to send. Is it normal behaviour?

There is no problem with the same file played through the aplay.

Regards,
Krzysztof

----------------------------------------------------
Games Convention Lipsk 23-27.08.2006 - Nie mo=BFesz tam by=E6?
Zobacz relacje na =BFywo:
http://klik.wp.pl/?adr=3Dwww.gc2006.gry.wp.pl&sid=3D852



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
