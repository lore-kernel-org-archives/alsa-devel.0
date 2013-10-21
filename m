From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Re: [Solved] Questions about virtual ALSA driver
 (dummy), PortAudio and full-duplex
Date: Mon, 21 Oct 2013 16:48:03 +0200
Message-ID: <52653EA3.1010109@imi.aau.dk>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
 <51F0E3C5.4020400@ladisch.de>
Reply-To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from asmtp.www1.dk (asmtp.danhost.dk [91.144.243.214])
 by alsa0.perex.cz (Postfix) with ESMTP id 3503E265121
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 16:48:09 +0200 (CEST)
In-Reply-To: <51F0E3C5.4020400@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: portaudio@music.columbia.edu, alsa-devel@alsa-project.org, audacity-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi list(s),

I hope I'll be forgiven for bumping all lists again - just wanted to confirm that indeed, the problem I stated in the start of this thread, was not with Audacity nor PortAudio nor ALSA as such (even with the older versions I've used); the problem was my modification of the ALSA `dummy` driver, submitted previously as `dummy-2.6.32-patest-fix.c` (or "dummy-mod" for short).

I'd also announce, that it seems that the driver `dummy-2.6.32-patest-fix.c` (or "dummy-fix"), uploaded in this directory:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/

... fixes the problems with the full-duplex "drop input" I experienced in Audacity - but I'll still use this opportunity to ask some questions. I'll try to be as brief as I can here, some more info is in the `Readme` in the `fix` directory.

As a reminder, the full-duplex "drop input" looked like this for me:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/dummy-mod-fddrop.png

... or, as the screenshot shows, very soon after a start of capture in full-duplex mode, `dummy-mod` would trigger a full-duplex "drop input" in PortAudio, which would propagate to Audacity.

The behavior of `dummy-fix` now is like this:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/dummy-fix-ok.png

... or, as the screenshot shows, Audacity can now run for 10 mins in full-duplex capture mode with `dummy-fix`, without a full-duplex "drop input" being triggered; which is as good as I need it, I guess.


First, though, I have a question on the "nature" of full-duplex. The way I see it now, there are two distinct contexts for full-duplex use, which I'd call:

* monitoring - you want to listen on the speakers, what is recorded on the microphone (playback of the capture stream)
* studio/overlay recording - you want to play a background track, and you want to record the singer singing to that track "in sync" with the played track

In the monitoring case, I guess one doesn't care much for stream synchronization - input stream will arrive when it arrives (after inherent latencies of the system); in the mean time you can just play silence - and as soon as input data is available, you can play that too; it is "full-duplex" only in the sense that the playback and capture streams are running "at the same time" generally. On the other hand, for "overlay" recording, one would probably want the recorded stream as closely synchronized as possible to the playback stream. Is this correctly understood?

>From this, I guess that ALSA's `latency.c` achieves the full-duplex synchronization (of the "overlay" kind) by calling `snd_pcm_link`, *and* by writing a 2*period_size worth of playback data (let's call this playback pre-buffer) *before* the full-duplex operation starts. However, I couldn't see anything like this "playback pre-buffer" in PortAudio, even if `pa_linux_alsa.c` does call `snd_pcm_link`. Then, I couldn't see a "playback pre-buffer" in PortAudio's `patest_duplex.c` either, but I thought maybe this program is meant to demonstrate a full-duplex of the monitoring kind (and thus it doesn't need such prebuffering). So my question is - does PortAudio do this kind of playback pre-buffer that I may have missed; and if it doesn't, does Audacity do it?


Back to topic - so, while I suspected anything from the massive printouts from ALSA/PortAudio debugs and kernel message printouts to (un)reliability of hrtimers in the Linux kernel as the cause of trouble, it turns out that isn't the problem - the issue got solved as soon as I managed to simulate the IRQ .pointer behavior of `hda-intel`, as timer callback .pointer behavior within `dummy-fix`.

First of all, the full-duplex "drop input" seems to be triggered, initially, by a polling error of the playback stream in PortAudio. I'm still not exactly clear on which stream it is (due to the PortAudio code using "thisComponent" and "otherComponent"), but both the error condition of `snd_pcm_playback_poll` in ALSA, and further behavior of the `margin` variable in the PortAudio code in `ContinuePoll`, seem to indicate that a hw_ptr is not increasing. While the original `snd-dummy` always recalculates the .pointer position in the .pointer function - I had moved that calculation in the timer callback in `dummy-mod`, and the .pointer function then simply returned the last calculated value. So in `dummy-fix`, .pointer function again recalculates the position (almost) every call - but this wa
 s not the entirety of the fix.

The fix is in simulation of this behavior of `hda-intel`:

    For period sizes > 64 frames; the period IRQ (or timer function) for the playback stream should be delayed early for some 48 frames (at CD quality, 48/44100 = 1.088 ms); however it should return the proper expected .pointer position (at periods, that is typically N*period_size+1 in frames, where N=0,1,(2..))

Now this is what puzzles me most: _why_ should the playback stream (in particular) be delayed early? I noticed this behavior by first analyzing the period IRQ positions of `hda-intel` (the plot shows use of both ALSA `latency-mod.c`, and PortAudio `patest_duplex_wire.c`, as user-space programs):

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/collectmirq_hda.png

Note here that: even as period sizes increase - the playback (red) is delayed early from the capture (blue), for approximately the same amount of time. As this plots (as closely as possible) the IRQs the card issues, that means that the card hardware actually issues the playback interrupts early. Why?

In comparison, in `dummy-mod` there were no discernible time offsets between capture and playback timer callbacks:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/collectmirq_duM.png

... and seemingly, this is what caused the full-duplex drop. Now, `dummy-fix` behaves rather similarly to `hda-intel` in that respect:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/collectmirq_duF.png

... and here is a plot, that shows how `dummy-fix` approximates `hda-intel` a bit more closely - for period_size 256 and buffer_size 512 frames:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/cmirq_hda_duF_512_256.png


Another interesting thing is, that `hda-intel` does not behave the same for period_size <= 64 frames; in that case, the playback is delayed late, not early. In earlier mails in this thread, I tried to analyze smaller period sizes (so as to limit the ammount of kernel data to be analyzed and plotted) - and this made me interpret the offsets as "quarter period"; obviously that approach failed. (Other problems I had was 16UL*100000000UL not actually fitting in unsigned long, but requiring unsigned long long; and a bug in Gnuplot when using palette, which inverted the capture and playback colors in the plots, making me code the wrong offsets). The interesting thing, though, is that when I try to simulate that behavior in `dummy-fix`:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/cmirq_hda_duF_128_PERIOD64F.png

... even if the behavior is quite close (left half is `hda-intel`, right half is `dummy-fix`), the `dummy-fix` tends to XRUN a _lot_ in that case; however, it should be said that `hda-intel` also tends to XRUN quite a bit (though not as much) for period_size 64 frames. Going back to running the periods (timer callbacks) of capture and playback streams without significant offsets (close to each other):

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/cmirq_hda_duF_128_64.png

... seems to make `dummy-fix` much more reliable (very few XRUNs). Why?


Finally, there is also some test code, that allows for acquiring .pointer positions with Audacity - this code is somewhat simpler though, and renders using the timestamps of the .pointer printouts (not the timestamps of the causing IRQ/timers, which would have happened a bit earlier), but still looks good enough, I guess. This is the comparison of `hda-intel` and `dummy-fix` in full-duplex mode:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/collectmirq_acity_dup.png

... but interestingly, Audacity (or PortAudio) seems to settle on slightly different period_sizes for `hda-intel` vs. `dummy-fix` in capture-only mode:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/fix/collectmirq_acity_cap.png

... or period_size / buffer_size (period_per_buffer) as a table (for my dev platform, at least):

    | audacity |   capture-only  |   full-duplex   |
    |----------------------------------------------|
    |dummy-fix | 1102 / 4408 (4) | 2048 / 4096 (2) |
    |hda-intel | 1088 / 4352 (4) | 2048 / 4096 (2) |
    ------------------------------------------------

Would anyone have an idea, why would Audacity (or PortAudio?) choose the same settings for the two drivers in full-duplex mode, but differing settings in capture-only mode?


To summarize, I haven't really found the exact conditions which trigger the full-duplex drop input detection in PortAudio - but it seems I've fixed the problem, by replicating the early delay of playback vs. capture timers behavior of `hda-intel`; hope it's robust enough, so I don't come back crying to the list(s) about new significant bugs found `:)` However, I'd still love to hear if anyone has answers to my questions above - or to a more simplified understanding of what condition actually triggers this drop (or, indeed, any comments `:)`).

Many thanks for all the responses in this thread so far (most of it found on alsa-devel) - I doubt I would have arrived at this point without that help; much appreciated,
Cheers!
