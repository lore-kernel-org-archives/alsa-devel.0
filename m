From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA snd-fireworks Echo AudioFire 2
Date: Mon, 25 Aug 2014 13:21:46 +0900
Message-ID: <53FAB9DA.1060202@sakamocchi.jp>
References: <CAKudYbO=FZwPHzgxwYADxdUKHOtSUzd5V7WayENkmcz__unFQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id D720C261B32
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 06:22:19 +0200 (CEST)
In-Reply-To: <CAKudYbO=FZwPHzgxwYADxdUKHOtSUzd5V7WayENkmcz__unFQA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harry van Haaren <harryhaaren@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Harry,
(C.C.ed to alsa-devel and Clemens)

On Aug 25 2014 09:06, Harry van Haaren wrote:> Hi Takashi,
> I can report the AudioFire2 registers correctly, see output:
> [...]
> On testing the device with alsa_delay[1], using 256 frames/buffer, 2
buffers.
> A sine wave should be audible, however a clicking sound occurs about 3
> times per second.
>
> Dmesg prints a list of snd-fireworks logs:
> [54749.309250] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54749.467216] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54749.627157] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54749.785195] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54749.944205] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54750.102188] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54750.262195] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.420170] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.580185] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.738154] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.898172] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.056187] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.216153] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54751.374195] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.534182] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.692164] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
>
>
> The the device works using FFADO, and the mixer settings are all set
> to pass trough any audio.
>
> Is the above information enough to help debug? Is there anything I can
> do to assit you in finding this playback bug?

Thanks for your report.

The dmesg means that your AudioFire2 transmits packets with disorder. (I
note that Fireworks driver start duplex streams for timestamp
synchronization even if you use playback only.)

I know that some Fireworks devices with a certain firmware (not exactly
identified) sometimes perform the same behaviour. Could I ask you to
confirm to see these logs always when you playback, or sometimes?


# Currently I'm working for moving to my new flat.
# So during a few weeks, I may not reply as you expected, sorry.

Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

On Aug 25 2014 09:06, Harry van Haaren wrote:
> Hi Takashi,
> 
> Thanks for your work on the Echo ALSA support!
> 
> I can report the AudioFire2 registers correctly, see output:
> 
> /cardX/firewire/clock:
> Clock Source: 0
> Sampling Rate: 44100
> 
> /cardX/firewire/meters:
> Physical Meters:
>  6 Outputs:
>     Analog [0]: 22784
>     Analog [1]: 19200
>     Headphones [0]: 0
>     Headphones [1]: 0
>     S/PDIF [0]: 0
>     S/PDIF [1]: 0
>  4 Inputs:
>     Analog [0]: 22784
>     Analog [1]: 19200
>     S/PDIF [0]: 0
>     S/PDIF [1]: 0
> 
> 
> /cardX/firewire/firmware:
> 
> guid_hi: 0x14860E
> guid_lo: 0xD7FF1CAB
> type: 0xAF2
> version: 0x0
> vendor_name: Echo Digital Audio
> model_name: AudioFire2
> dsp_version: 0x0
> arm_version: 0x5070300
> fpga_version: 0x3000200
> flags: 0xA1
> max_sample_rate: 0x17700
> min_sample_rate: 0x7D00
> supported_clock: 0x9
> phys out: 0x6
> phys in: 0x4
> phys in grps: 0x2
> phys in grp[0]: type 0x0, count 0x2
> phys in grp[1]: type 0x5, count 0x2
> phys out grps: 0x3
> phys out grps[0]: type 0x0, count 0x2
> phys out grps[1]: type 0x5, count 0x2
> phys out grps[2]: type 0x1, count 0x2
> amdtp rx pcm channels 1x: 0x6
> amdtp tx pcm channels 1x: 0x4
> amdtp rx pcm channels 2x: 0x6
> amdtp tx pcm channels 2x: 0x4
> amdtp rx pcm channels 4x: 0x6
> amdtp tx pcm channels 4x: 0x4
> midi out ports: 0x1
> midi in ports: 0x1
> mixer playback channels: 0x6
> mixer capture channels: 0x4
> 
> 
> On testing the device with alsa_delay[1], using 256 frames/buffer, 2 buffers.
> A sine wave should be audible, however a clicking sound occurs about 3
> times per second.
> 
> Dmesg prints a list of snd-fireworks logs:
> [54749.309250] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54749.467216] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54749.627157] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54749.785195] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54749.944205] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54750.102188] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54750.262195] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.420170] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.580185] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.738154] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54750.898172] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.056187] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.216153] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
> [54751.374195] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.534182] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> [54751.692164] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
> 
> 
> The the device works using FFADO, and the mixer settings are all set
> to pass trough any audio.
> 
> Is the above information enough to help debug? Is there anything I can
> do to assit you in finding this playback bug?
> Greetings from Ireland, -Harry
> 
> [1] http://kokkinizita.linuxaudio.org/linuxaudio/downloads/zita-alsa-pcmi-0.2.0.tar.bz2
