From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Fri, 24 Apr 2015 21:27:09 +0900
Message-ID: <CAJ0eYfW4iatW+L+d+Y-9CAACfZVq7V=a575iRy9tTJ0SMjwXXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f47.google.com (mail-vn0-f47.google.com
 [209.85.216.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 717F926058F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:27:12 +0200 (CEST)
Received: by vnbf1 with SMTP id f1so3799825vnb.5
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 05:27:11 -0700 (PDT)
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

Takashi Sakamoto wrote:

> > % cat /proc/asound/card2/firewire/clock
> > Sampling rate: 44100
> > Clock Source: External (MSU-dest: 7)
>
> According to this output, the internal clock of your device is set to
> synchronize to external source such as S/PDIF or word clock.

Oops. Let me boot my Windows7 again, and see..
https://spinorlab.wordpress.com/2015/04/24/orpheus-and-its-sync-source/
(see orpheussyncsource.jpg)

The control program by PrismSound tells that the Sync Source is Local,
which means it is a Master and System is sync'ed to Orpheus's
local clock.

http://www.prismsound.com/music_recording/products_subs/orpheus/online_manual/index.html
(Contents -> Orpheus hardware -> Synchronization)
(Contents -> Orpheus software -> Orpheus Control Panel)

Funny?

Now reboot again, and going back to Linux.

------------------
% dmesg <- Orpheus was powered on already.
------------------

[   20.927594] r8169 0000:02:00.0 eth0: link down
[   23.299665] r8169 0000:02:00.0 eth0: link up
[   27.676032] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   29.974533] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   32.282923] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   34.961027] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   37.259624] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   47.732497] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   50.030918] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   52.339515] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   55.037594] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   57.316079] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08

------------------
% ls -l /proc/asound
lrwxrwxrwx 1 root root 5 Apr 24 20:24 Orpheus -> card0

------------------
% cat /proc/asound/card0/firewire/clock
Sampling rate: 44100
Clock Source: External (MSU-dest: 7)  <- as Takashi pointed out!

------------------
% aplay -D plughw:0,0 test.wav <- same happens as is expected
------------------

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

------------------
% dmesg <- the last line is added.
------------------

[   20.927594] r8169 0000:02:00.0 eth0: link down
[   23.299665] r8169 0000:02:00.0 eth0: link up
[   27.676032] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   29.974533] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   32.282923] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   34.961027] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   37.259624] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   47.732497] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   50.030918] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   52.339515] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   55.037594] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[   57.316079] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[ 1483.932836] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08

***

> If your device is implemented with no customization of the
> setting and you didn't give any external sources to your
> device, the device is not synchronized.
> (If you give it correctly, please inform it to us.)

I am not sure, but I think I gave it correctly to Local Sync Source.

> libffado also supports this device and I guess you can
> start streaming with jackd and firewire backend

Yes, as I have mentioned, I have been always successful
with alsa (vanilla without snd-*) + libffado + jackd.

> because libffado implements loose
> checker of packet discontinuity.

I do not understand techinical details, but the sound was
perfect even with 192kHz/24bit audio using libffado.

So if it's only a
#define TIMER_SOMETHING value_anything
type of things...

> Currently, libffado has a bug to fail to switch clock
> source for usual BeBoB driver.
> So we have no way to set the source of clock correctly.
> I've tried to fix it but get stuck deeply into
> ffado's fault and given up.

As for me, clock source settings, etc.,
which is written into its EEPROM when powered off,
can be occasionally set via the control program
by PrismSound either on Windows/OS X,
only when it becomes necessary.

So personally I really do not matter, if I understand
the situation correctly.

> For our information:
> http://subversion.ffado.org/wiki/AvcModels/PrismSoundOrpheus

I hope some day this level of information becomes usefull
for me.

Regards,
Mike Ood
