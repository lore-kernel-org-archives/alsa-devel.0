From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Thu, 08 Aug 2013 04:50:25 +0200
Message-ID: <52030771.9010207@imi.aau.dk>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
 <51F0E3C5.4020400@ladisch.de> <51FD9AB6.4050408@imi.aau.dk>
 <5200D712.2040800@ladisch.de>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from asmtp.www1.dk (asmtp.www1.dk [91.144.243.214])
 by alsa0.perex.cz (Postfix) with ESMTP id 56A6726563F
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 04:50:26 +0200 (CEST)
In-Reply-To: <5200D712.2040800@ladisch.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Clemens, David,

Many thanks for bearing with me, and your feedback - I truly appreciate it! Apologies for a verbose response again; I have tried to organize this time, and push my more verbose snippets to the end of the mail; hope that helps with readability.


On 2013-08-06 12:59, Clemens Ladisch wrote:
> Smilen Dimitrov wrote:
>> On 2013-07-25 10:37, Clemens Ladisch wrote:
>
>> I'm interested in the operation of a virtual (platform) driver,
>> which talks to _no_ soundcard hardware
>
> And what does this driver do?  What is your goal?
>

For now, my goal is to develop a virtual driver (or rather, make minimal modifications to the existing `dummy` driver), which will a) work at CD-quality (44100/16b/2ch) and not trigger the full-duplex drop in PortAudio and b) write something trivial (like "pulses" at period and buffer boundary) in the capture buffer - just so I can load the driver, fire up Audacity, load a playback file, press record (which will start full-duplex in overdub mode), and see something expected be captured (without drops, and repeatedly).

The driver's purpose, in my case, would be to 1) learn what it takes for a virtual driver to not trigger full-duplex drop in PortAudio, and then 2) serve as a sort of a comparison basis (or a benchmark), against which I'd compare the operation of a similar (with timer functions) driver. I have moved the more verbose explanation in comment (*c1) at end of this mail.


>> I'm assuming that the card has it's own intern capture buffer memory
>> on board;
>
> No modern card has this.  All data is immediately read from/written to
> main memory.
>

Thanks for noting this - I wish I knew better :) ( By the way, can anyone recommend any references, which would get me up to speed on the evolution of soundcard hardware? )

My immediate question here is - why, then, do I observe IRQ's at period boundary with `hda-intel`? But then:

>> and ALSA manages the equivalent of `substream->runtime->dma_area`
>> as capture buffer memory in RAM. The main purpose of the ALSA driver,
>> then, is to manage the copying the data from the intern card capture
>> buffer, to the `dma_area` capture buffer in RAM of the PC;
>
> This is handled by the hardware's DMA.
>

Aha - ok, I'll try to speculate here, to make sure I now have a more acceptable model of operation for a proper DMA card; based on the simplified DMA schematic in the previously mentioned http://sdaaubckp.sf.net/post/alsa-capttest/montage-hda-intel.png - again just discussing capture, let's say 44100/16b/2ch:

* Card uses its XO to derive a sampling clock as close as possible to 44100 Hz;
* When this clock hits, card has to perform an ADC - this means it has to store 16 bits per channel somewhere (in this case, 4 bytes for the two channels)
* The card, having sampled, triggers a request on the DMA bus (possibly, by "raising" DREQ)
** Since this signal doesn't utilize the CPU - it is **not** registered as an interrupt (IRQ)
** The DMA controller then makes sure control and data bus are switched soon enough, so these 4 bytes are stored in main memory, possibly asserting DACK0 for acknowledgment afterwards
** Upon ACK, card internally accumulates +4 on its capture "buffer pointer" counter
** (Thus, this DMA "interrupt"/request, (sort of) functions as the sampling rate "timer"/trigger in the context of the PC as a whole - but not in the context of the CPU directly)
* When card realizes "buffer pointer" counter is >= period_size, it triggers an IRQ proper, that interrupts the CPU - not to initiate a copy from "intern capture buffer memory" to main RAM - but to inform the OS, that now +period_size frames (bytes) are available in main RAM memory
** Driver reacts to IRQ, then eventually raises `snd_pcm_period_elapsed` (and rest of ALSA takes it from there)

Now, I would call those 4 bytes I speculate about "intern capture memory", although it's definitely not a "buffer" - maybe the more proper term for them would be "registers" (as they are few in number, and likely fast)?. Or do modern cards, for instance, hook the ADC output directly to DMA bus - so not even those 4 bytes are present as "intern capture memory" on card?

In either case - could the speculative "breakdown" above, be taken to be a more accurate approximation of the capture process with a modern card? If so, then maybe the `montage-hda-intel.png` image can still be considered somewhat applicable for modern cards - as in: the period boundary IRQ is raised _as if_ there was an intern card capture buffer of the given period/buffer size, signalling a need for copy to main memory - except there is no actual copy, since there is no intern capture buffer (and capture data goes directly to main RAM) on modern cards.


>> And herein lies the crux of my inquiery: given there is no hardware
>> targetted with a virtual driver, I can in principle return whatever I
>> want as a .pointer position.
>
> If you are actually transferring sample from/to somewhere, you must
> return the status of these transfers.
>

Agreed - and my bad for saying "whatever I want"; I guess, what I was trying to emphasize, comes from my experience with AudioArduino (and conversely, lack of experience with actual PCI/DMA cards). Namely, with AudioArduino (see also (*c1)), essentially I only had to relate to one formula:

    bytes_per_period = (rate_bytes/1[s])*(period_time[s])

... which is what was being returned (as increase) in .pointer there - moved the verbose to comment (*c2) at end of this mail.

In other words, I am assuming that _solely_ by increasing pointers by bytes_per_period in period_time, the driver should be able to persuade ALSA (and userspace) that transfers are going fine; I am cheating ALSA with that approach, but I'm not cheating full-duplex PortAudio :) However, it seems the PortAudio full-duplex drop is triggered by a `snd_pcm_delay` check, see comment (*c4); but even `snd_pcm_delay` depends only on appl_ptr and hw_ptr - and ultimately, on .pointer position.


>> I should be able to simulate a proper operation to userspace, just by
>> increasing this .pointer value properly. However, even if I do that,
>> I still manage to somehow trigger a full-duplex drop in the PortAudio
>> userspace layer
>
> A buffer length of about 1 ms is very likely to result in over/underruns,
> regardless of what your .pointer callback does.
>
> Better try with a 32000-frame buffer first.
>

I think this is a key comment - I'll have to try and understand it better, because buffer sizes that big didn't really occur to me. And that is because, even if I multiply both sides of the above formula with a constant A > 1:

    A*bytes_per_period = (rate_bytes/1[s])*(A*period_time[s])

... the ratio doesn't change; so it's not immediately obvious to me, why a very large buffer would have helped (I have tried with period_size = 1024 frames, and buffer apparently 2x that - that still does a full duplex drop).

The only thing I can think of is the jitter (shown on the .gifs): the (hr)timer functions can easily be off by 30 or more microseconds, which is on the order of a sample (frame) period (1/44100 ~= 22.6e-06). So for a period on order of 1ms, error would be 22e-6/1e-3 = 0.022 => 2.2%; while for period of 16000 frames, period time is 16000/44100 = 0.362812 = 362.8 ms; so error there is less: 22e-6/362e-3 = 6.07735e-05 => 0.006%. Beyond this, is there any other reason why small buffer/period size is likely to result in over/underruns?


>>>>> Your driver's .pointer callback must report the *actual* position at
>>>>> which the hardware has finished reading from the buffer
>>>
>>> ... for a playback stream, or finished reading, for a capture stream.
>>
>> What if the pointer granularity is very coarse? E g, some hardware might
>> only be able what period you're in (IIRC, I've seen this on the Tegra
>> platform), rather than the actual sample. Would you recommend to report
>> the latest period boundary in that case, or interpolating it with timers?
>
> By reporting position x, the driver guarantees that the device has
> finished reading (for a playback stream) before x, and that the
> application is allowed to overwrite the buffer before x with new sample
> data.
>
> When the driver does not know the current position of the DMA
> controller, it must report the last known 'safe' position (and set
> SNDRV_PCM_INFO_BLOCK_TRANSFER).

An essential comment, much appreciated - I was not clearly aware of the "finished" aspect, and in particular of the "overwrite" aspect; will definitely take that into account from now on.

With that in mind, could the following be said?: In a virtual driver context, given that there is no underlying hardware to speak of, a report of .pointer at position x is merely an _assertion_ from the driver to ALSA: "Hey, I checked the hardware, this position x has already been processed by the stream"


>> On the PC side, the driver's .pointer callback can be triggered both
>> by userspace call to `snd_pcm_readi`, and (apparently) independently
>> of it - but (surprising for me) it is not necessarily periodic!
>
> The .pointer callback is triggered by snd_pcm_period_elapsed() (because
> some more data, or even another period, might have been transferred in
> the meantime), whenever userspace writes or reads samples, or whenever
> userspace feels like asking for the current position.
>

Good to have this confirmed! By the way, I was experimenting with capturing the behavior of the original `dummy` in the meantime - and I think it nicely illustrates "some more data, ... might have been transferred in the meantime", but in a virtual driver. Here is an animated gif:

    http://sdaaubckp.sourceforge.net/post/alsa-capttest/capttest_03.gif
    http://sdaaubckp.sourceforge.net/post/alsa-capttest/_cappics03/ (source images/PDFs)

More verbose discussion in comment (*c3) at end of this mail.


>> once the data is in the `dma_area`, the rest of the ALSA engine will
>> make sure that data ends up in `audiobuf` in user-space, upon a call
>> to `snd_pcm_readi` as given above.
>
> Yes.  (When using snd_pcm_mmap_*, the dma_area is mapped to userspace,
> and ALSA itself will never access the contents of the buffer.)
>

Thanks for this - it's great to have confirmed, what is supposed to be mapped to what! :)

By the way, I'm still not sure if mmap could also influence the occurence of these full duplex drops - while I can enforce use of `snd_pcm_readi` (as in the `captmini.c` test), the `dummy` driver does declare SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID - and I'm not sure if this may be a signal to PortAudio (when using the `patest_duplex_wire.c` test) to use the mmap'd versions of snd_pcm_ functions; I should check. Since in my version `dummy-2.6.32-patest.c`, I insist on memsetting the capture `dma_area` from the timer function tasklet; I guess it could well be, that interferes with proper mmap operation - thus making that version of the driver less robust (as mentioned in comment (*c3)) to "full-duplex drops", than the original `dummy`?


>>> The card then, uses [its] own clock, which is not burdened with
>>> anything else but filling buffers, meaning we can expect tight timing
>>> here; and when it generates an IRQ, it is handled by kernel with
>>> highest priority - ergo, not so much jitter. Timer functions, on the
>>> other hand, run in softIRQ context - meaning they (and their
>>> scheduling) could be preempted by the hardware IRQ of any other device
>>> on the system; ergo, more jitter. Is this reasonable to assume?
>>
>> Yes, but other hardware interrupts interfere only if other devices are
>> used at the same time.
>
> Also, it applies to kernel-space only. If you want to process anything
> in userspace, you can still be interrupted by any kernel process -
> hardIRQ, softIRQ or even other kernel tasks.

Got it - I take my development PC into consideration, and it's a netbook with a touchpad, USB mouse and ethernet network; I guess any of this could, in principle, cause hardware IRQ interference - however, I do take that as not very likely (or at least, not crucial to the full-duplex drop problem).


>> [...] where the `azx_interrupt` handler has been called (since it's
>> also possible to capture interrupt entries for power, for instance);
>
> The stream's SD_STS register tells whether this is an interrupt because
> a period boundary has been crossed.
>

Thanks for this too - as I don't really understand `hda-intel.c`, the only reason I emphasized this function is that I saw `snd_pcm_period_elapsed` called from there (it's also called from `azx_irq_pending_work`, but judging by that name, I doubted it'd have shown any periodic behavior on a plot). Now reading the `azx_interrupt` function makes a lot more sense.


>> when I see "wall clock" referred to in code, does that refer to
>> this, which I've called "Real Time"?
>
> It's called "wall clock" because Intel named the register this way;
> actually, it's the device's sample clock.
>

Heh - thanks for this, would never have guessed! :)

By the way, I just realized that `snd_pcm_update_hw_ptr0` in `sound/core/pcm_lib.c`, also refers to a SNDRV_PCM_INFO_HAS_WALL_CLOCK, (which in `include/uapi/sound/asound.h` has comment: "/* has audio wall clock for audio/system time sync */") and `substream->ops->wall_clock` (as part of `snd_pcm_ops` in `sound/pcm.h`). This part of the structure would again refer to a device's sample clock (if the device declares _HAS_WALL_CLOCK), right?


Before I wrap up, just to mention that I experimented a bit with PortAudio (`patest_duplex_wire.c`) and original `dummy` driver; and have a bit more on the conditions that trigger the full-duplex drop in comment (*c4) - it seems `snd_pcm_delay` is critical there, but even that can apparently be boiled down to .pointer positions.


Many thanks again for the excellent discussion; and I really hope also this mail will attract the same level of scrutiny - the feedback on where I'm going wrong, has really helped me get some of my misconceptions cleared,

Cheers!


:: Verbose comments:

(*c1) I've been working on http://imi.aau.dk/~sd/phd/index.php?title=AudioArduino , which should be understood as an academic exercise, simplified enough to serve as a practical introduction to soundcard operation - even if one misses a lot of details, like proper understanding of, say, PCI. That driver works using timer functions, and by basically trusting that `ftdi_write()` and the `ftdi_process_packet()` will do their thing in time: when the timer function hits for playback, I `ftdi_write` ammount of bytes per period from `dma_area` and consider it "played"; `ftdi_process_packet` is fired as interrupt from `ftdi_sio`, I collect that data in intermediary buffer - and when timer hits for capture, I `memcpy` ammount of bytes per period from intermediary to `dma_area`. All I've had to pay 
 attention to here was memory allocations, and having proper buffer/period wrap pointer arithmetic. And even with this simplified understanding, I can program the Arduino to echo back every b
yte it received from serial (what I call "digital duplex test"), load up a file in Audacity, press record, and see the played file be echoed back inside in the capture - never experienced any full-duplex drops (like here). And that driver doesn't even use hrtimer - it uses systimers, which can be unreliable up to a period of a jiffy (4ms in my case)! However, that driver works only with 44100/8bit/mono streams.

I now want to see if I can do this "digital duplex" test, but for 44100/16b/2ch (assuming the 2 Mbps bandwidth of `ftdi_sio` and Arduino will be enough). After realizing that I cannot use systimers anymore ( see http://stackoverflow.com/q/16920238/277826 ), and the switch to hrtimers, I started getting these full-duplex drops from PortAudio - even if observing the stream through an analyzer (at points TX and RX on the Arduino) would reveal that there are no interruptions in the stream, and that each byte in the played sequence is correctly "reflected"! So I thought - OK, must be something in my .pointer arithmetic is wrong, let's compare to something that works. So I tried `hda-intel`, it indeed doesn't do full-duplex drop - but since I don't really know what sort of a hardware it is, read
 ing its driver's source doesn't help me much. Then I thought - well, let's try `dummy` - given that I took the timer approach from there, analyzing it will hopefully reveal what is wrong wit
h my driver. So I just made the small modification described earlier (.pointer position calculated in tasklet, and writing of pulses in capture `dma_area`), and tried it. And imagine my surprise when `dummy` turned out to trigger these full-duplex drops in PortAudio as well! Today I just tried the original `dummy` 2.6.32 (which doesn't manipulate `dma_area` at all, and calcs .pointer position in .pointer) - with just an extra `trace_printk()` in .pointer - and while far more robust that my modified version (e.g. my version drops any time I switch workspace in Gnome with Ctrl-Alt-arrows; the original doesn't), it _still_ triggers a full-duplex drop!

So, now that my idea of using `dummy` as a comparison point has broken down, I'm actually genuinely interested in `dummy` for its own sake: given that it does nothing but increase .pointer (thus, very little CPU overhead which could influence things), and there is no hardware in respect to which we would calculate an (im)proper operation - how on earth can it trigger a full-duplex drop in PortAudio at all? And why - what is the condition that triggers it, then? Of course, I eventually hope that by understanding this, I'll be able to apply the conclusions to my 44100/16b/2ch AudioArduino case - but for now, I'd really like to have a better understanding of why this drop occurs in the context of a virtual driver to begin with. One problem could be, that so far I've taken that userspace has t
 o decide whether operation is proper solely based on what .pointer reports - there are likely other variables at play here, too; most importantly, `snd_pcm_delay` -see (*c4).


(*c2) I guess, what I was trying to emphasize, comes from my experience with AudioArduino (and conversely, lack of experience with actual PCI/DMA cards). Namely, with AudioArduino (see also (*c1)), essentially I only had to relate to one formula:

    bytes_per_period = (rate_bytes/1[s])*(period_time[s])

So, in that case, I knew I had 44100Hz/8b/mono, which translates to rate of 44100 Bytes/s. I also knew I was going to use systimer functions, set at a period of a jiffy (on my platform, 4ms) -> so, bytes_per_period = 44100*4e-3 = 176.4 ~= 176. So, at each timer function:

* for playback - I `ftdi_write` 176 bytes from `dma_area`, and increase `->pcm_buf_pos` by 176
* for capture - I memcpy 176 bytes from intermediate buffer to `dma_area`, and increase `->pcm_buf_pos` by 176

... and in .pointer, I return `bytes_to_frames(->pcm_buf_pos)` for either direction.

So - as I saw it at that point - there is no other information about the status of the transfers, other than the increase of the .pointer positions! Now, it's well a standing question if this is the _best_ way to solve this driver - for instance, maybe I should have used .copy/.silence callbacks (instead of dealing with `dma_area` inside the timer functions). However, it was _good enough_, in that I never experienced a full-duplex drop (nor other problems) in Audacity with it. So I reasoned: it must be that ALSA keeps track of time; then the only thing it needs, so as to check whether constant rate is held, is to see that pointer positions increase for the right ammount. And since here I explicitly write that ammount in each direction (playback or capture) in the driver - ALSA is kept "hap
 py", and that propagates to userspace.

Note that from this, to a pure virtual driver, there is only one step - one simply stops using the `ftdi_` functions, and stops manipulating the `dma_area`s. (not surprising, given that the whole timer function technique I saw first in `dummy`). That is what made me believe, that there is nothing else but the .pointer positions, that have an influence the on a proper streaming operation (as ALSA would see it); when I said I can "return whatever I want", I really meant - I can explicitly return a position increase, that should match the requested transfer rate, as per the above formula (which, as I see it, should "cheat" ALSA that all is fine).

However, I make a virtual driver with timer functions, set it to 44100Hz/16b/stereo (= 176000 Bytes/s, so four times the transfer rate of AudioArduino) - and I observe a full-duplex drop in PortAudio. So, obviously the model, where the only thing that matters is the above formula in context of timer functions, breaks down for this rate (on my platform at least) - apparently starting to break some timing constraints, maybe not necesarilly in ALSA, but definitely in PortAudio. And I'd like to learn more precisely what condition causes this breakage. In (*c4) I can see `snd_pcm_delay` has an influence - but seemingly, it also relies in great part on reported .pointer position.


(*c3) A capture of the original `dummy` driver, with `captmini.c`:

    http://sdaaubckp.sourceforge.net/post/alsa-capttest/capttest_03.gif
    http://sdaaubckp.sourceforge.net/post/alsa-capttest/_cappics03/ (source images/PDFs)

Basically ((in simplified terms, given `snd_pcm_update_hw_ptr0` is more complex, and does delay and XRUN calculations)): when .pointer is called from `snd_pcm_update_hw_ptr0`, it seems it is called repeatedly in quick succession, until at least `hw_ptr` for the substream matches the .pointer position. With the original `dummy` driver, since it calculates delays directly in the .pointer callback - it's values can keep on increasing by 1 or frames, while the rest of the code is updating `hw_ptr`; and so .pointer called to update again, and this goes on (apparently) until `snd_pcm_update_hw_ptr0` is satisfied - that it got enough frames according to the time expired, - which can be 5 or more times in quick succession. My modification `dummy-2.6.32-patest.c`, since it calculates the .pointer p
 osition in the timer tasklet, typically stays unchanged when `snd_pcm_update_hw_ptr0` inquires, so .pointer from there is called max 2 times in quick succession ( e.g. as on http://sdaaubckp
.sf.net/post/alsa-capttest/montage-dummy.png ).

But then, there is something strange again - if you focus on the top part of capttest_03.gif, which shows the behavior of the original `dummy` driver, it shows a somewhat comparable jitter to `hda-intel` - which is apparently much better than what my modified `dummy-2.6.32-patest.c` showed (on http://sdaaubckp.sourceforge.net/post/alsa-capttest/capttest.gif top part). I find this surprising, because - regardless of a) if the .pointer position is calculated in the tasklet or in .pointer; or b) if the tasklet had anything more to do than just call `snd_pcm_period_elapsed` - this should not have an influence on when the timer softirq first fires, since _both_ drivers re-schedule the timer function (`dummy_hrtimer_callback`) as first thing when it enters, and only then schedule a tasklet?

Having noted this, and looking back at http://sdaaubckp.sf.net/post/alsa-capttest/montage-hda-intel.png , I would have found the triplet of `.pointer` at about 1.20 ms also somewhat strange - namely, the .pointer has increased from 41 to 49 (causing the third call to .pointer from `snd_pcm_update_hw_ptr0`, until it ultimately syncs) - but there is no card IRQ running at the time? Then what could have changed the .pointer, which for `hda-intel` could be something like `azx_dev->posbuf`? This, of course ties in with my earlier (wrong) understanding that only card IRQ initiates a copy to main capture buffer; but if this "copy" happens transparently via DMA (like in my speculative breakdown above), then I see where this update - "more data transferred in the meantime" - could come from.


(*c4) Having experimented with `patest_duplex_wire.c` (set to 512 frames per period), a debug version of PortAudio, and the original `dummy` 2.6.32 driver (with but a `trace_printk` in its .pointer function); I realized that when a full-duplex drop occurs, the PortAudio log looks like this:

    ...
    Pa_IsStreamActive returned:
      PaError: 1 ( Invalid error code (value greater than zero) )
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:507 mrg:251  <<<<<<<<
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:498 mrg:242
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:495 mrg:239
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:492 mrg:236
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:490 mrg:234
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:487 mrg:231
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:484 mrg:228
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:481 mrg:225
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 6 dly:478 mrg:222
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 5 dly:475 mrg:219
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 5 dly:472 mrg:216
    ...
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 1 dly:261 mrg:5
    ContinuePoll: Trying to poll again for playback frames, pollTimeout: 1 dly:258 mrg:2
    ContinuePoll: Stopping poll for playback
    PaAlsaStream_WaitForFrames: full-duplex (not xrun): Drop input, a period's worth - fra:769
    ContinuePoll: Stopping poll for capture
    CallbackThreadFunc: Input underflow fra:777 urn:0 orn:0
    CallbackThreadFunc: Input underflow fra:265 urn:0 orn:0                                 >>>>>>>>
    play index = 45056 ; rec/capt index = 88064
    Pa_IsStreamActive called:
      PaStream* stream: 0x0x99037e0
    Pa_IsStreamActive returned:
      PaError: 1 ( Invalid error code (value greater than zero) )
    ...

When a `patest_duplex_wire.c` completes successfully (without a drop), it turns out the section between the ">>>" and "<<<" is never in the logs - meaning the "ContinuePoll" messages, in addition to the "Drop input" and input underflow messages, are also a sign of a drop. (NB: It seems there is also such correlation between `ContinuePoll` and the full-duplex drop in logs from starting post of this thread; although `ContinuePoll` there can also appear in a context of an XRUN.)

So I looked into `src/hostapi/alsa/pa_linux_alsa.c`, and `ContinuePoll` does this:

    ... snd_pcm_delay( otherComponent->pcm, &delay )  ...
    ...
    if( StreamDirection_Out == streamDir ) {
      /* Number of eligible frames before capture overrun */
      delay = otherComponent->bufferSize - delay;
    }
    margin = delay - otherComponent->framesPerBuffer / 2;
    if( margin < 0 ) { ...
      PA_DEBUG(( "%s: Stopping poll ....
      *continuePoll = 0;
    } else if( margin < otherComponent->framesPerBuffer ) {
      *pollTimeout = CalculatePollTimeout( stream, margin );
      PA_DEBUG(( "%s: Trying to poll again for %s frames, pollTimeout: %d dly:%d mrg:%d\n",
                  __FUNCTION__, StreamDirection_In == streamDir ? "capture" : "playback", *pollTimeout , delay, margin )); // modded
    }

So, apparently `snd_pcm_delay` is being used for calculation of `margin` and `delay` - and should the `margin` drop to below zero, the poll is stopped. Apparently, this polling is started, ended and continued from `PaAlsaStream_WaitForFrames`, where there is the following loop:

    while( pollPlayback || pollCapture ) {
      ...
      /* @concern FullDuplex If only one of two pcms is ready we may want to compromise between the two.
       * If there is less than half a period's worth of samples left of frames in the other pcm's buffer we will
       * stop polling.
       */
      if( self->capture.pcm && self->playback.pcm ) {
        if( pollCapture && !pollPlayback ) {
          PA_ENSURE( ContinuePoll( self, StreamDirection_In, &pollTimeout, &pollCapture ) );
        } else if( pollPlayback && !pollCapture ) {
          PA_ENSURE( ContinuePoll( self, StreamDirection_Out, &pollTimeout, &pollPlayback ) );
        }
      }
    } // end while

So, `ContinuePoll` can set `pollCapture` or `pollPlayback` (via `*continuePoll`) to 0, which will break the while loop - and right after this while loop, is the `if( !xrun ) ...` check, cited in the starting post of this thread, which determines the full-duplex drop in PortAudio.

In other words, now it looks like it is a `snd_pcm_delay` check failure, that triggers the full-duplex drop in PortAudio. And as a reminder, this check fails for "otherComponent" stream - specifically, full-duplex drop happens if we're in full-duplex mode (so both capture and playback are running), and **playback** is not ready; since the condition for the full-duplex drop is: `if( self->capture.pcm && self->playback.pcm ) { if( !self->playback.ready && !self->neverDropInput ) ...`. (( I'm still not clear on what sets `playback.ready` to 0 - `ContinuePoll` apparently doesn't ))

So, given I haven't met `snd_pcm_delay` by now, I think I should look more into it. The docs say: "For playback ... It is as such the overall latency from the write call to the final DAC. For capture ... It is as such the overall latency from the initial ADC to the read call.", which I have a problem translating to virtual driver context (given there is no actual ADCs nor DACs). However, I found this thread:

    "[alsa-devel] What does snd_pcm_delay() actually return?"
    http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008421.html
    > In the driver implementation level, snd_pcm_delay() simply returns the
    > difference between appl_ptr and hw_ptr.  It means how many samples are
    > ahead on the buffer from the point currently being played.
    > However, if you stop feeding samples now, snd_pcm_delay() returns the
    > least time XRUN occurs. [...]
    > The implementation of snd_pcm_delay() (at least in the driver level)
    > purely depends on the accuracy of PCM pointer callback of each
    > driver.  So, if the driver returns more accurate hw_ptr via pointer
    > callback, you'll get more accurate value of snd_pcm_delay().  In the
    > worst case, it may be bigger up to one period size than the real
    > delay.

... so one way or another, it boils down to appl_ptr, hw_ptr - and what is being returned as .pointer position. I think the next thing, is to see what triggers the "ContinuePoll" altogether - since its seems its presence in PortAudio debug logs is not really a good sign.
