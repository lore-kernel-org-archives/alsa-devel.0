From: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Subject: Underrun on Jade controller...
Date: Fri, 23 Nov 2012 02:05:16 -0800 (PST)
Message-ID: <1353665116.15462.YahooMailNeo@web120405.mail.ne1.yahoo.com>
Reply-To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm15-vm1.bullet.mail.ne1.yahoo.com
 (nm15-vm1.bullet.mail.ne1.yahoo.com [98.138.90.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C3602615FC
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 11:05:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Hello ALSA community.

I'm an User-Space application developer, using the ALSA library to play mix=
ed sounds. My application (and for that matter also aplay) are having one u=
nderrun problem, and I need help on how to interpret the following debug in=
formation and receive some possible workarounds/solutions.

The underrun occurs only: once after writei() was performed with get_buffer=
_size bytes=A0 written, and try to do another writei().

Target: Fujitsu Jade microcontroller

ALSA: 1.0.25

ALSA PCM interface for Jade-xxsvideo: /kernel/linux-2.6.31.4/sound/soc/xxsv=
ideo/jade-pcm.c

DMA driver: /kernel/linux-2.6.31.4/arch/arm/mach-xxsvideo/dma.c


Here are the traces I managed to do, if there is any other information need=
ed, please ask me for it.

Application trace:
[line: 1297 ]: Trying to open the ALSA plugin =3D plug:'dmix:RATE=3D8000'
=A0[463379 ms] : Play ThreadID [1126167328]: before open ALSA
[line: 1313 ]: Play Sound No: 0, Sound name: Snd_000.wav - from Thread-ID: =
1126167328
=A0[463417 ms] : Play ThreadID [1126167328]: before setting parameters
[line: 1377 ]: 16 Bit format
[line: 1386 ]: Channel count: 1
[line: 1394 ]: Sample rate: 8000
[line: 1473 ]: Period size =3D 1024 ; Buffer size =3D 4096
[line: 1514 ]: Start threshold =3D 4096
=A0[463441 ms] : Play ThreadID [1126167328]: after parmas ended
=A0[463442 ms] : Play ThreadID [1126167328]: before malloc
=A0[463442 ms] : Play ThreadID [1126167328]: before reading/writing
[line: 1691 ]: Writei() ended, bytes written =3D 2048, available bytes to b=
e written =3D 2048
[line: 1691 ]: Writei() ended, bytes written =3D 2048, available bytes to b=
e written =3D 48
underrun!!! (at least 0.019 ms long)
[line: 1660 ]: Underrun encountered: status =3D -32
ALSA lib pcm.c:7339:(snd_pcm_recover) underrun occurred
[line: 1691 ]: Writei() ended, bytes written =3D 0, available bytes to be w=
ritten =3D 4096
[line: 1691 ]: Writei() ended, bytes written =3D 2048, available bytes to b=
e written =3D 2048
[line: 1615 ]: Add silence in last buffer, with size =3D 1948
[line: 1691 ]: Writei() ended, bytes written =3D 2048, available bytes to b=
e written =3D 64
=A0[463526 ms] : Play ThreadID [1126167328]: after reading/writing fully en=
ded
=A0[464152 ms] : Play ThreadID [1126167328]: after ALSA drain


X_RUN DEBUG TRACE:
echo 1 > /proc/asound/card0/pcm0p/xrun_debug

ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:330: PCM: Lost interr=
upts? (stream=3D0, delta=3D15360, intr_ptr=3D1024)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D0, intr_ptr=3D17408)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D1024, intr_ptr=3D18432)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D2048, intr_ptr=3D19456)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D3072, intr_ptr=3D20480)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D4096, intr_ptr=3D21504)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D5120, intr_ptr=3D22528)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D6144, intr_ptr=3D23552)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D7168, intr_ptr=3D24576)
ALSA /home/kernel/linux-2.6.31.4/sound/core/pcm_lib.c:266: PCM: Unexpected =
hw_pointer value (stream=3D0, pos=3D8192, intr_ptr=3D25600)


Additional note:
using the :
#echo 2 > /proc/asound/card0/pcm0p/xrun_debug
there are no more underruns occurrences!! And this seems to be normal, acco=
rding to Procfile.txt description from Takashi Iwai (...can be lead to too =
much corrections for a (mostly buggy) hardware that doesn't give smooth poi=
nter updates)

Thank you for any information and help given.
