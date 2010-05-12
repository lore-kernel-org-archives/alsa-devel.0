From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [alsa-devel] [RFC] disabling ALSA period
	interrupts
Date: Wed, 12 May 2010 23:15:21 +0900
Message-ID: <AANLkTikfHAA0ajmpF8Qocq_m9ATZj0szX_7ItogSiTFj@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
List-Unsubscribe: <https://tango.0pointer.de/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 10:50 PM, pl bossart <bossart.nospam@gmail.com> wrote:
>> It seems the requirement is just to have as least wakeups as possible
>> in order to
>> maximize power savings.
>> If so, then how about setting the period size slightly smaller than
>> the ring-buffer: the
>> difference being just enough to refill the ring buffer. Of course, you
>> would have to
>> enforce full-buffer-size as the start threshold.
>> We do just that to implement low-power-audio-mode for latest Samsung
>> SoC's I2S blocks.
>
> Thanks for the heads-up Jassi, this is interesting info that does show
> the need to reduce the number of wakeups in embedded low-power
> solutions...
> This might be almost equivalent to the timer approach in terms of # of
> wakeups, however the timer can be reprogrammed on-the-fly whereas
> periods can only be changed by closing and reopening the device. You
> can also adjust the timer shall underflows occur. And the timer slack
> lets the kernel group events. Not to mention that you will need
> specific apps written to make use of this mode. The only drawback of
> the timer approach is that you need to keep track of drifts between
> system and audio clock and that you need the hardware and driver to
> report the hw_ptr with precision.
.... another negative is having to hack the alsa stack.
I couldn't use the timer thing because the system has to be woken up
from suspend(and I2S intr is one of the wakeup sources) and maybe
for moorstown/atom also you'd go to sleep/suspend? make sure if the
timer based approach could work there.
Also, at least for embedded systems, such audio mode switching is done
at a level coarse enough(the user sets the 'Hold' switch) that overall power
savings(unloading unnecessary driver modules upon first LPAM suspend
and reloading only after the last) is much more than a minor click in playback
due to close->open of the audio stream.
