From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Sat, 25 Apr 2015 22:44:42 +0900
Message-ID: <CAJ0eYfVV92mh2j60D_o6gMyarJ1C7dUk6dWcx=ksS4zJwUi4Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f51.google.com (mail-vn0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BF2812617DE
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 15:44:43 +0200 (CEST)
Received: by vnbf190 with SMTP id f190so6762586vnb.1
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 06:44:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 Takashi Sakamoto  wrote:

> I do not understand techinical details, but the sound was
> > perfect even with 192kHz/24bit audio using libffado.
>
> Ditto. libffado works with such broken stream by ignoring its packet
> index. I guess that you've continued to use your device with
> uns-ynchronized state for several years because no one reports it.
>

Well, one reason I believed I was doing fine with my Orpheus
is one of the experiments I did in November 2010.

-------------------------------------------------------------------------
I copied a 44.1kHz/16bit sound file into a USB memory,
and played it on PS3.

The optical output (SPDIF) of PS3 is fed into the optical input of Orpheus,
and the data is captured using ffado and jackd.

Two files, the original and the captured, are compared and showed
perfect match.

https://spinorlab.wordpress.com/2015/04/25/orpheus-and-bit-perfect/
(see https://spinorlab.files.wordpress.com/2015/04/orpheusbitperfect.jpg)
-------------------------------------------------------------------------

I know I should have compared by not only capturing by Orpheus
but playing by Orpheus, but I saved my effort assuming the reverse
way should also be OK.

(Actually, I did not expect any negative results. Was I too optimistic?)

***

Therefore, I still can not believe I am experiencing packet losses
(without noticing).

I mean not with juju+libffado+jackd. I really don't know what
is happening with snd-bebob.

***

> So if it's only a
> > #define TIMER_SOMETHING value_anything
> > type of things...
>
> I cannot understand what you mean.
>

Never mind. I am not a very technical person anyway.

I just thought if it is due to a VERY STRICT timeout checking
policy, relaxing the value of timeout might help.


> Unless fully understanding specifications about your device, you cannot
> make firm statement about it, I think. The drivers installed in Windows
> or OS X can set the synchronization when plugging-in.
>

You are correct! (See the item 8 below.)

I did some experiment today, although I am not sure if it has
any technical meaning.

---------------
My PC runnging on Windows 7
---------------
1. Run Control Panel, and set Sync Source to PC DAW.
2. Play music with Audacity -> O.K. -> Stop music.
3. Kill Control panel.
4. Set Orpheus to Stand-by Mode
5. Remove Firewire Cable
6. Recover from Stand-by Mode
7. Connect Firewire Cable
8. Run Control Panel, and Sync Source now reads Local,

/*** this is not what I expected, but it is so. ***/

  so set Sync Source to PC DAW again.
9. Play music with Audacity -> O.K. -> Keep playing
10. Kill Control Panel. -> Music still playing O.K. -> Stop Music
11. Set Orpheus to Stand-by Mode
12. Remove Firewire Cable

---------------
Reboot My PC to start Linux
---------------
13. Recover from Stand-by Mode
14. Connect Firewire Cable
15. Enter the following CLIs.

% dmesg
[   21.838971] r8169 0000:02:00.0 eth0: link down
[   24.281647] r8169 0000:02:00.0 eth0: link up
[  281.110728] irq_handler: 36 callbacks suppressed
[  281.110737] firewire_ohci 0000:08:00.0: isochronous cycle inconsistent
[  281.612586] firewire_core 0000:08:00.0: created device fw1: GUID
00119800010001f9, S400
[  281.612747] firewire_core 0000:08:00.0: phy config: new root=ffc1,
gap_count=5

% ls -l /proc/asound
lrwxrwxrwx 1 root root 5 Apr 25 21:55 Orpheus -> card3

 % cat /proc/asound/card3/firewire/clock
Sampling rate: 44100
Clock Source: External (MSU-dest: 7)

% aplay -D plughw:3,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 0

% dmesg
[   21.838971] r8169 0000:02:00.0 eth0: link down
[   24.281647] r8169 0000:02:00.0 eth0: link up
[  281.110728] irq_handler: 36 callbacks suppressed
[  281.110737] firewire_ohci 0000:08:00.0: isochronous cycle inconsistent
[  281.612586] firewire_core 0000:08:00.0: created device fw1: GUID
00119800010001f9, S400
[  281.612747] firewire_core 0000:08:00.0: phy config: new root=ffc1,
gap_count=5

***

Regards,
Mike Ood
