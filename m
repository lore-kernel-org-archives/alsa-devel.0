From: Olivier Schmitt <sc.olivier@gmail.com>
Subject: CREATIVE EMU 0202 driver in 192khz
Date: Fri, 28 Oct 2016 13:33:47 +0200
Message-ID: <CALzsnJSbzNHvNZp8O=arZq29Qo224=E8mjZRQwpAithbokEnXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id EF763266B2C
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 13:34:08 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id n67so108025233wme.1
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 04:34:08 -0700 (PDT)
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

Hello,

I am SCHMITT Olivier and I am IT manager for a Radio Ham Club.

Let me explain quickly, I search to use ADC (line in) from an Creative
Creative EMU 0202 in 192K but it was detected by alsa on 48k sample rate
only.


I have a computer that I need to update. It runs on 32-bit version 17
LinuxMint (it seems to be the version of ubuntu 14).
The card works in EMU0202 192k on this machine before.

I test all 32 and 64 bit version of Ubuntu Ubuntu 12.04 to Ubuntu 16.04 and
LinuxMint 13 to 18 and this card was only detected on 48k max and not
192k... USB2.0 for sure!


Here is the extract from alsa Repport:


Current new PC with fresh installation:

http://www.alsa-project.org/db/?f=d2aa133b78df9a25b9840fa274e7ab8485f89e30


old PC under linuxmint 17:

http://www.alsa-project.org/db/?f=5b1b56fc64d982a7f72e00aa6f907e28e0eb2353

How I did you observe that?

I use the utility "alsacap" to see all the features available.
I also use to arecord verified the information.
I can only use 48kHz bandwidth under the new installation of Ubuntu.

The old person now deceased was installed on LinuxMint and we could use in
192khz. But I do not know how. he probably made the snd-usb-audio driver
with a patch. But I'm not sure. It seems this is the only lead I have.

This seems normal because in compatible sound card matrix of ALSA-project
website, it seems that the driver by alsa only allows maximum 48khz.

I would like to have your opinion to perhaps find a suitable track.

If you see this return of alsacap utility, you see that in the older
computer this will allow to use this sound card under 192khz.


*** *Scanning for recording devices* ***
Card 0, ID `PCH', name `HDA Intel PCH'
  Device 0, ID `ALC662 rev1 Analog', name `ALC662 rev1 Analog', 1
subdevices (1 available)
    2 channels, sampling rate 44100..96000 Hz
    Sample formats: S16_LE, S32_LE
      Subdevice 0, name `subdevice #0'
  Device 2, ID `ALC662 rev1 Alt Analog', name `ALC662 rev1 Alt Analog', 1
subdevices (1 available)
    2 channels, sampling rate 44100..96000 Hz
    Sample formats: S16_LE, S32_LE
      Subdevice 0, name `subdevice #0'
Card 1, ID `USB', name `E-MU 0202 | USB'



*  Device 0, ID `USB Audio', name `USB Audio', 1 subdevices (1
available)    2 channels, sampling rate 44100..192000 Hz    Sample formats:
S24_3LE      Subdevice 0, name `subdevice #0'*
Card 10, ID `loop1', name `Loopback'
  Device 0, ID `Loopback PCM', name `Loopback PCM', 2 subdevices (2
available)
    1..32 channels, sampling rate 8000..192000 Hz
    Sample formats: S16_LE, S16_BE, S32_LE, S32_BE, FLOAT_LE, FLOAT_BE
      Subdevice 0, name `subdevice #0'
      Subdevice 1, name `subdevice #1'
  Device 1, ID `Loopback PCM', name `Loopback PCM', 2 subdevices (2
available)
    1..32 channels, sampling rate 8000..192000 Hz
    Sample formats: S16_LE, S16_BE, S32_LE, S32_BE, FLOAT_LE, FLOAT_BE
      Subdevice 0, name `subdevice #0'
      Subdevice 1, name `subdevice #1'
Card 11, ID `loop2', name `Loopback'
  Device 0, ID `Loopback PCM', name `Loopback PCM', 2 subdevices (2
available)
    1..32 channels, sampling rate 8000..192000 Hz
    Sample formats: S16_LE, S16_BE, S32_LE, S32_BE, FLOAT_LE, FLOAT_BE
      Subdevice 0, name `subdevice #0'
      Subdevice 1, name `subdevice #1'
  Device 1, ID `Loopback PCM', name `Loopback PCM', 2 subdevices (2
available)
    1..32 channels, sampling rate 8000..192000 Hz
    Sample formats: S16_LE, S16_BE, S32_LE, S32_BE, FLOAT_LE, FLOAT_BE
      Subdevice 0, name `subdevice #0'
      Subdevice 1, name `subdevice #1'


I test every version of linux mint from the 13 to the 18 and Ubuntu 12.04 to
16.06 (32 and 64 bit) and they are all the card 48khz.
Also, I try to make the latest version of ALSA driver without success.

Alsacap return:

**** Scanning for recording devices* ***
Card 0, ID `Intel', name `HDA Intel'
  Device 0, ID `AD198x Analog', name `AD198x Analog', 1 subdevices (1
available)
    2 channels, sampling rate 8000..48000 Hz
    Sample formats: S16_LE, S32_LE
      Subdevice 0, name `subdevice #0'




*Card 1, ID `USB', name `E-MU 0202 | USB'  Device 0, ID `USB Audio', name
`USB Audio', 1 subdevices (1 available)    2 channels, sampling rate
44100..48000 Hz    Sample formats: S16_LE, S24_3LE      Subdevice 0, name
`subdevice #0*

Always the same in all linux version that i have tested....

The only thing that lets the driver current ALSA is to manage the frequency
of the internal clock of the card (clock sample rate) but ALSA does not
provide the functionality available for software.
I know this may sound ambiguous but the alsamixer "clock rate" is only used
to manage the clock rate of the sound card chipset.


When the clock Rate is to 5, we see on our watterfall that the sample rate
will change on the hardware but alsa dont let somme software to use 192khz.
I have already search on somme forums for this, i find that Alsa-Project as
devellop this function to be sure that when you use at 48khz or 44,1khz,
you can adjust manualy the same hardware clock rate.

 The only track that I have is this, but I do not have enough knowledge to
develloper a specific driver ...

https://lab.nexedi.cn/kirr/linux/commit/89e1e66d6be8a520cdcd26043cda2cc870a34015

I saw there for 0404, it appears that the hardware is the same. Perhaps is
it possible to use it for 0202?

Thanks for your reply.
