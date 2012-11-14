From: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Subject: ALSA with dmix, help needed
Date: Wed, 14 Nov 2012 01:39:11 -0800 (PST)
Message-ID: <1352885951.26711.YahooMailNeo@web120404.mail.ne1.yahoo.com>
Reply-To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm22-vm2.bullet.mail.ne1.yahoo.com
 (nm22-vm2.bullet.mail.ne1.yahoo.com [98.138.91.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 576FA261667
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 10:39:13 +0100 (CET)
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



Hello,

I am struggling for some time now with dmix plugin from ALSA. Could anyone =
please answer to these questions: =



1. Is ALSA library with DMIX plugin suitable for real-time embedded =

systems: where it's needed small api latencies, fast output to =

dma/serial bus and no audible defects?

2. Is it reliable to use ALSA commands from different threads? (e.g. open()=
 in one master thread, writei() from child threads)?

3. Is it normal that two consecutive writei() calls to generate underrun - =
this happens only just after opening the dmix device. =


e.g.: =


if( snd_pcm_writei(pPcmPlayHandle, (pu8WavDataBuf), 2048) < 0)
=A0 fprintf(stderr, "Underrun encountered: application didn't sent enough d=
ata to the ALSA buffer \n");
if( snd_pcm_writei(pPcmPlayHandle, (pu8WavDataBuf+4096),2048) < 0)
=A0fprintf(stderr, "Underrun encountered: application didn't sent enough da=
ta to the ALSA buffer \n");


The second writei() generates this underrun error (-32), even though there =
is no delay between these two calls. The get_buff_size is 4096, get_buf_per=
iod =3D 1024.


4. The pcm_drain() help states: "for playback, wait for all pending frames =
to be played and then stop the PCM"
But, how come the execution duration of this drain() takes longer than the =
actual sound duration? e.g. pcm_drain() takes 300-400 miliseconds, but the =
wav size sent to writei() is less than 100ms? =


I'm using ASLA lib 1.0.25, on a ARM controller with 440MHz, and no other hi=
gh prio threads.
