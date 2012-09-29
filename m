From: George Stefan <stefan.george87@gmail.com>
Subject: imx28 pcm issue
Date: Sat, 29 Sep 2012 16:16:23 +0300
Message-ID: <CAACwST+gFQ-whaRThF0U=aHcw1Q6E0zzj5QNOCAE=6_MMZEaWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 82F102615A1
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 15:16:23 +0200 (CEST)
Received: by eaaf14 with SMTP id f14so1137480eaa.38
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 06:16:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!
I have an issues with a modem connected to the SAIF port of an imx28.
I have the following configuration running on the modem:
  -modem is slave(but still have to fix the clock at 256 khz)
  -"short frame" sync.
PCM data is always formatted as 16-bit uncompressed two=92s complement. Als=
o,
all PCM data and frame synchronization signals are written to the PCM bus
on the rising
clock edge and read on the falling edge.
 - 16 bits liniar sample, MSB first.

On the imx side i have the following configuration

priv->sysclk =3D 512 * rate;
snd_soc_dai_set_clkdiv(cpu_dai, IMX_SSP_SYS_MCLK, 32);
dai_format =3D SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
             SND_SOC_DAIFMT_CBM_CFM;

snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, priv->sysclk,
SND_SOC_CLOCK_OUT);

The modem has the 2 options for testing, either outputing a tone or an
audio loop.
My problem is that i cannot receive anything else but noise.

arecord -f S16_LE -c2 -r8000 test.wav
hexdump -C test.wav

00000000  52 49 46 46 24 c4 09 00  57 41 56 45 66 6d 74 20
 |RIFF$...WAVEfmt |
00000010  10 00 00 00 01 00 02 00  40 1f 00 00 00 7d 00 00
 |........@....}..|
00000020  04 00 10 00 64 61 74 61  00 c4 09 00 00 00 00 00
 |....data........|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 |................|
*
00040f10  00 00 00 00 f0 03 00 00  00 00 00 00 00 00 00 00
 |................|
00040f20  00 00 0f 00 ff ff ff ff  ff ff f0 ff fc 00 00 00
 |................|
00040f30  00 00 00 00 00 00 00 00  00 00 ff 01 ff ff ff ff
 |................|
00040f40  00 fc 03 00 00 e0 00 00  00 00 00 00 00 00 00 00
 |................|
00040f50  00 00 ff 1f ff ff ff ff  00 ff ff 1f 00 f8 00 00
 |................|
00040f60  00 00 00 00 00 00 00 00  03 00 ff ff ff ff ff ff
 |................|
00040f70  81 ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00
 |................|
00040f80  3f 00 ff ff ff ff 80 ff  00 00 00 00 00 00 00 00
 |?...............|

When i select the audio loop mode, play a wav sample, and record it at the
same time, i hear noise
every time i play that wav and silence between them(so something is moving
out there)

Do you have any suggestions on why this is happening?
Regards.
