From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: problem with versioned symbols and shared libraries
Date: Fri, 16 Jan 2004 22:01:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1vzb6lpq1sf88@mail.broadpark.no>
References: <20040116.200200.971177181.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040116.200200.971177181.rene.rebe@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Rebe <rene.rebe@gmx.net>, alsa-devel@lists.sourceforge.net
Cc: ziegler@informatik.hu-berlin.de
List-Id: alsa-devel@alsa-project.org

Hi, Ren=E9

This is exactly the same problem I'm having with a dynamically linked=20
C++ (extern "C") plugin of mine, which links dynamically with ALSA throug=
h=20
PortAudio. I made a not so aptly titled post about it earlier, "Problem=20
with __OLD_GET". I was still a bit confused as to what was going on .. :)

Regards

Arve Knudsen

On Fri, 16 Jan 2004 20:02:00 +0100 (CET), Rene Rebe <rene.rebe@gmx.net>=20
wrote:

> Hi all,
>
> we experience a fairly strange problem with the versioned symbols in
> the libasound.so. We have a C++ wrapper library which is normally
> linked as shared obkect, too. But for some strange reasonsthe linker
> does not map stuff like "snd_pcm_hw_params_get_channels_max" and
> friends (with a pointer to the val at the end, now) to the correct
> symbol.
>
> Of course when linked statically into a single binary it works fine.
>
> Example log of some testing:
>
> Let's link a normal object and a shared obeject of the ALSAHelper:
>
> rene@idefix:~/develop/trunk/lowlevel/src$ g++   -g -Wall   -I.=20
> -I../include -I../../dam/include -I../../utility/include -c -o=20
> ALSAHelper.o ALSAHelper.cc
> rene@idefix:~/develop/trunk/lowlevel/src$ g++ --shared  -g -Wall   -I.=20
> -I../include -I../../dam/include -I../../utility/include -o=20
> ALSAHelper.so ALSAHelper.cc
>
> And now let's link the test application:
>
> First the shared object:
>
> rene@idefix:~/develop/trunk2/lowlevel/tests$ g++   -g -Wall   -I.=20
> -I../include -I../../dam/include -I../../utility/include -o ALSAHelper=20
> ALSAHelper.cc ../src/ALSAHelper.so  -lasound
>
> rene@idefix:~/develop/trunk2/lowlevel/tests$ ./ALSAHelper
> Format 16 bit
> Channels min: 268513264
> Channels max: 268513264
> Rate min: 0
> Rate max: 0
> Periods min: 0
> Periods max: 0
> Period Size: 0
> Get periods: 0
>
> Hm - quite incorrect values - let's see which symbol is used:
>
> gdb) bt
> #0  0x0ff433f0 in __old_snd_pcm_hw_params_get_channels_max=20
> (params=3D0x10013498)
>     at pcm.c:6407
> #1  0x0ffdc438 in GSMP::ALSAPCM::GetChannelsMax() (this=3D0x7ffff4e0)
>     at ALSAHelper.cc:342
> #2  0x10002238 in main () at ALSAHelper.cc:67
>
> Hm - but it works fine linked statically with the normal obcject:
>
> rene@idefix:~/develop/trunk2/lowlevel/tests$ g++   -g -Wall   -I.=20
> -I../include -I../../dam/include -I../../utility/include -o ALSAHelper=20
> ALSAHelper.cc ../src/ALSAHelper.o  -lasound
>
> rene@idefix:~/develop/trunk2/lowlevel/tests$ ./ALSAHelper
> Format 16 bit
> Channels min: 2
> Channels max: 2
> Rate min: 44100
> Rate max: 48000
> Periods min: 1
> Periods max: 32
> Period Size: 2048
> Get periods: 4
>
> ;-) - and which symbol is used:
>
> (gdb) bt
> #0  __snd_pcm_hw_params_get_channels_max (params=3D0x10017f68,=20
> val=3D0x7fffe48c)
>     at pcm.c:3334
> #1  0x10003cac in GSMP::ALSAPCM::GetChannelsMax() (this=3D0x7ffff4e0)
>     at ALSAHelper.cc:342
> #2  0x10001c00 in main () at ALSAHelper.cc:67
>
> Any idea what is happening to ALSA's symbol versioning using shared
> objects?
>
> In the case it matters, this is all on PowerPC (ROCK Linux) ...
>
> gcc (GCC) 3.2.3
> GNU C Library stable release version 2.3.2, by Roland McGrath et al.
> GNU ld version 2.14.90.0.4.1 20030523
> GNU assembler 2.14.90.0.4.1 20030523
>
> Thanks in advance - yours,
>   Ren=E9
>
> --
> Ren=E9 Rebe - Europe/Germany/Berlin
>   rene@rocklinux.org rene@rocklinux-consulting.de
> http://www.rocklinux.org http://www.rocklinux-consulting.de
> http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
