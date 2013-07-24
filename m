From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Wed, 24 Jul 2013 04:54:00 +0200
Message-ID: <51EF41C8.2040701@imi.aau.dk>
Reply-To: alsa-devel@alsa-project.org, portaudio@music.columbia.edu,
 audacity-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from asmtp.www1.dk (asmtp.www1.dk [91.144.243.214])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ED672651EB
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 04:54:15 +0200 (CEST)
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
Cc: portaudio@music.columbia.edu, audacity-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi list(s),

Apologies in advance for the longish exposition - however, I have bumped into a problem with ALSA driver development, which raised some questions that I cannot really understand at the moment. I find it especially frustrating that I cannot formulate a simple question, but instead I have to resort to test code, captures and plots, to discuss my (mis)conceptions through those - so I hope at least someone will bear with this wall of text (some 23KB plaintext), and I'll be able to get some help with this.

I originally started working on a 16-bit, 44.1 kHz stereo ALSA driver for a device; and came to a point where I could achieve (what I thought was) full-duplex by running `arecord` and `aplay`, in separate shells, without any problems. However, if I tried to do the same from `audacity` - that is, have "record" running, while another track plays on the same card, with "Audacity Preferences/Recording/Overdub: Play other tracks while recording new one" enabled - then I'd experience some strange drops in the capture, which were not reported by any debug messages, even after I rebuilt and used PortAudio with debug messages on (my eventual goal is to have this experiment running in Audacity without drops).

(Therefore CC to audacity-devel, since I first started looking for "audacity full duplex drops" and couldn't find much; and CC to portaudio since some of my questions depend on correct understanding of PortAudio).


Anyways, I think I managed to reconstruct the drop problem I get (with my device driver and `audacity`), by using a modified command line program from the tests in the PortAudio distribution, and a modified `dummy` driver from the ALSA distribution. The complete code and test scripts are available in this directory:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/

I ran this on Ubuntu 11.04 Natty, Linux 2.6.38 and corresponding ALSA 1.0.24.2, audacity-1.3.13, PortAudio V19 - more about my machine and environment setup is in the Readme:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/Readme

In that directory there is a script, `run-alsa-pa-tests.sh`; which compiles: the ALSA driver from `dummy-2.6.32-patest.c`; and the PortAudio program from `patest_duplex_wire.c`; with different compile-time defines - and then runs the program, obtaining verbose logs (some timestamped through `ftrace`), which end up as .csv files. The .csv files are finally plotted in the time domain using a gnuplot script, `traceLogGraph.gp`, through a batch script `batch_traceLogFile.sh`. Note you may have to change some hardcoded values in the source codes, if you want to run this collection on your machine - see the Readme for more.

The file `captures01-04.tar.gz` contains complete logs from four runs of `run-alsa-pa-tests.sh` (NB: +70MB expanded), with respective `traceLogGraph.gp` gnuplot scripts that allow for reconstruction of all .png images; while the `captures_0*/` directories contain only some .pngs (those that will be referenced here).


Back to the problem: once I started working with `patest_duplex_wire.c`, I realised there are actually two ways to implement "full-duplex", understood simply as "playback and record at the same time", in PortAudio:
* By using two separate `PaStream*`s, with two `Pa_OpenStream`s and `Pa_StartStream`s, started one right after the other - and using their separate "record" (capture) and "play" callbacks
* By using a single `PaStream*`, which correspondingly has only one callback ("wire" callback), which handles memory copying in both playback and capture directions

In Audacity, as far as I could see, there is only one PortAudio callback defined (audacity-1.3.13/src/AudioIO.cpp has audacityAudioCallback;), so Audacity basically has a single "wire" callback for full-duplex. Because of that, both Audacity and `patest_duplex_wire.c` (when using a single stream/"wire" callback), can enter this section of portaudio-v19/src/hostapi/alsa/pa_linux_alsa.c:

    if( !xrun )
    {
        /* Get the number of available frames for the pcms that are marked ready.
         * @concern FullDuplex If only one direction is marked ready (from poll), the number of frames available for
         * the other direction is returned. Output is normally preferred over capture however, so capture frames may be
         * discarded to avoid overrun unless paNeverDropInput is specified.
         */
        int captureReady = self->capture.pcm ? self->capture.ready : 0,
            playbackReady = self->playback.pcm ? self->playback.ready : 0;
        PA_ENSURE( PaAlsaStream_GetAvailableFrames( self, captureReady, playbackReady, framesAvail, &xrun ) );

        if( self->capture.pcm && self->playback.pcm )
        {
            if( !self->playback.ready && !self->neverDropInput )
            {
                /* Drop input, a period's worth */
                PA_MDEBUG(( "%s: full-duplex (not xrun): Drop input, a period's worth - fra:%lu \n", __FUNCTION__, *framesAvail )); //added
                assert( self->capture.ready );
                PaAlsaStreamComponent_EndProcessing( &self->capture, PA_MIN( self->capture.framesPerBuffer,
                            *framesAvail ), &xrun );
                *framesAvail = 0;
                self->capture.ready = 0;
            }
        }
        else if( self->capture.pcm )
            assert( self->capture.ready );
        else
            assert( self->playback.ready );
    }
...

... which is precisely the section that seems to be causing the full-duplex capture drops I experience. I think I tried `neverDropInput` with `patest_duplex_wire.c`, and it kept segfaulting - but in any case, I don't think Audacity (at least this version) has any UI to manipulate this parameter; so I'd rather code the ALSA driver properly, so PortAudio thinks it's getting a proper full-duplex stream from it.

However, this is where I get stuck - because all I can see in the code snippet are boolean conditions. Thus I cannot see what the condition is to enter this segment - in terms of variables visible from the ALSA driver (like dpcm->pcm_buf_pos, or snd_pcm_capture_avail/_hw_avail(substream->runtime)). In other words, I'd like to know what sort of rule should the ALSA driver variables observe, so the above "drop input" section is never entered when using a single PortAudio stream/"wire" callback. This is the reason why I tried adding some extra debugging statements to PortAudio (see `audacity-portaudio.patch` in the online folder), to obtain logs through `ftrace` - in hope that I'd get accurate timestamps from both user- and kernel- space, against which variable values from logs could be plott
 ed. In brief, some of the variables on the plots are:

* frabCC/frabPC = framesAvail (Capture/Playback) in bytes from CallbackThreadFunc (pa_linux_alsa.c)
* frabCW/frabPW = framesAvail (Capture/Playback) in bytes from PaAlsaStream_WaitForFrames (pa_linux_alsa.c)
* frgbtc/frgbtp = framesGot (Capture/Playback) in bytes total (cumulative); CallbackThreadFunc (pa_linux_alsa.c)
* pav/cav/phwav/chwav = snd_pcm_playback/capture_avail/_hw_avail(substream->runtime) in bytes (dummy-2.6.32-patest.c)
* aptbC/aptbP/hptbC/hptbP = (Capture/Playback) substream->runtime->control->appl_ptr/hw_ptr in bytes (dummy-2.6.32-patest.c)

[ When a single PortAudio "wire" callback is used, only frabCC, frabCW and frgbtc appear (there are no separate playback variants then) - however, the driver still has separate timer functions/tasklets for each direction (playback or capture). ]

The original `dummy` driver has code for both Linux kernel system timers, and for high-resolution timers; the driver builds on my system automatically with hrtimers, which is what I'm interested in. Initially, I started by working with hrtimer functions set to a period of one jiffy: since HZ in my OS is defined as 250, one jiffy is 1/HZ = 1/250 = 4 ms - and then I calculated bytes per period as total bytes per second 44100*2*2 = 176400 divided by HZ, which gives 176400/250 = 705.6 ; and then I tried to increase dpcm->pcm_buf_pos with 705 each time the hrtimer tasklet was called (those captures have folder names ending with `_jif`). That results in a behavior like this:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_02_jif/trace_patest__14_DF_pr_512.csv_01.png

That is a capture with driver debug tracing (D), fixed bytes per period in driver (F), playback+record callbacks in `patest_duplex_wire.c` (pr), with request of 512 FRAMES_PER_BUFFER (512). What I find surprising here, is that driver's `chwav` (and `cav`) stay mostly constant, "resetting" themselves in just three "hits" of the timer/tasklet after 0.12 sec; while `pav` slowly raises (and `phwav` slowly falls) - until a point after 0.12 sec, where they "reset" themselves in just one "hit" of the timer function. Furthermore, `frabPC`, `frabCC` and `frabPW` also follow the `pav` line (indicating that some frames were left 'avail', after the requested 512 frames were 'got' in PA's `CallbackThreadFunc`). For a while I thought that this slow "raise" was the cause for the drop - but it isn't, as t
 hat particular capture doesn't display a drop (and it cannot either, because it doesn't use a single "wire" callback)

Then, I thought that the reason for the `pav` rising slope could be, that I'm taking too much time processing in the driver callbacks; but that can't be it, because the capture above is obtained with the "snd-dummy" driver - which does pretty much nothing in its hrtimer/takslet function, but increasing the pcm_buf_pos counters (and memsetting a couple of bytes in the capture direction); I cannot really see that as a CPU hog?! Then I thought, maybe it's a rounding problem, since I should be increasing driver pointers by 705.6 bytes per timer tick, and I'm increasing for 705 bytes instead - but then, that should result with _less_ data available for playback; while `pav` rising implies that _more_ data than needed is delivered to the PortAudio callback. Then I did another test, trying to che
 ck the delta between the kernel timestamps for capture and playback driver tasklets separately; it turns out, even if the period is specified as 4000000e-9 nsecs (4 ms) - the deltas still gr
avitate around 3.99x ms; I tried also calculating cumulative bytes per second (based on deltas and bytes per period) - and for different captures, they typically tended to stabilize to some +80 Bps to some +100 Bps above the required (176400 Bps). So, if the hrtimer indeed runs a bit faster, then indeed we may feed more data than needed from the driver to userspace (PA) - but then again, the slope of `pav` is at least 668 bytes for 12.6 ms, which is >> 80 Bps; so I'm still not sure where exactly does that slope come from.

Then, I noticed that the original `dummy.c` driver doesn't increase its counters by a fixed amount of bytes - but instead, by what I'd call "adaptive" amount of bytes: delta to a base time is taken; and it can be used to calculate the expected (wrapped) buffer position depending on the requested rate (although `dummy.c` does this in frames, and does it in the `_pointer` callback). So I did the same in the hrtimer tasklet - and, this seemingly does very little in respect to the `pav` slope:

http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_02_jif/trace_patest__06_DA_pr_512.csv_01.png

... which is still present, with nearly the same slope as before. Unfortunately, passing "adaptive" amount of bytes/frames around is not the solution to the drops either - because here is a capture of a "drop input" (`frabDI`), with single "wire" callback requesting 512 FRAMES_PER_BUFFER - happening at approx 60 ms, even before the first correction happens (after 0.12 sec):

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_02_jif/trace_patest__08_DA_w_512_drop.csv_01.png

The only thing I can notice here, is that when the drop happens, `phwav` briefly "crosses" below the value of `pav` (which otherwise never happens; the same goes for cav/chwav) - but I'm not sure if this is the cause, or the effect, of the drop. Also, it can be noted that for a PA single "wire" callback, the driver's playback and capture hrtimer tasklets hit very close to each other, and the corresponding variables are also very close - at the above resolution, the trace points for both nearly overlap.

Another thing I suspected was FRAMES_PER_BUFFER in the PortAudio program, so the test script switches the setting in `patest_duplex_wire.c` between 512 and 0 (which is `paFramesPerBufferUnspecified`). Note that when using 0 frames per buffer:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_02_jif/trace_patest__13_DF_pr_0.csv_01.png

... and playback+record callbacks, the is no more long slope of `pav`/`phwav`, and it self-corrects more quickly; while `cav`/`chwav` stay nearly constant - however, also note the condition where `phwav` briefly "crosses" below the value of `pav`, appears here again (but no "drop input" is detected, because we're not using a single "wire" callback).

However, not even FRAMES_PER_BUFFER=0 seems to help; as it doesn't prevent the "drop input" for a single "wire" callback, in the capture below:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_02_jif/trace_patest__03_xA_w_0_drop.csv_01.png

Since I was also suspecting the debug traces from the driver for having an influence on the drop, the debug traces are disabled for the driver (x) in that capture - and obviously, this is not the sole cause of the drop either.

Note that the original `dummy.c` kernel module calculates the period in nanoseconds, so it matches the pcm period size; in that case, one does not have to calculate if the current buffer position went over a period size - but can, instead, issue `snd_pcm_period_elapsed` directly at each call of the hrtimer tasklet. In this case, say for a pcm_period_size: 512 bytes, we might get a hrtimer period of 2902495 ns = 2.9 ms. This is controlled by the USE_JIFFY_PERIOD variable in the `dummy-2.6.32-patest.c` driver code, though not controlled by the `run-alsa-pa-tests.sh` - thus it has to be enabled manually; captures which USE_JIFFY_PERIOD have `_jif` as extension to the folder name, those that match to period size have `_psz` as extension.

Again, even this doesn't prevent occurrence of the full-duplex "drop input"s - in all, these of the provided captures in the .tar.gz file feature drops:

captures_01_psz/trace_patest__07_DA_w_0_drop.csv    captures_03_psz/trace_patest__16_DF_w_512_drop.csv
captures_01_psz/trace_patest__15_DF_w_0_drop.csv    captures_04_jif/trace_patest__03_xA_w_0_drop.csv
captures_02_jif/trace_patest__03_xA_w_0_drop.csv    captures_04_jif/trace_patest__07_DA_w_0_drop.csv
captures_02_jif/trace_patest__07_DA_w_0_drop.csv    captures_04_jif/trace_patest__11_xF_w_0_drop.csv
captures_02_jif/trace_patest__08_DA_w_512_drop.csv  captures_04_jif/trace_patest__15_DF_w_0_drop.csv
captures_02_jif/trace_patest__11_xF_w_0_drop.csv    captures_04_jif/trace_patest__16_DF_w_512_drop.csv
captures_03_psz/trace_patest__07_DA_w_0_drop.csv

As the filenames indicate:

* Regardless of whether the driver tunes its timer period to a jiffy (_jif) or to the period size (_psz);
* Regardless of whether I use trace debug statement in the driver (D), or not (x);
* Regardless of whether the driver "returns" adaptive (A) or fixed (F) amount of bytes;
* Regardless of whether we use paFramesPerBufferUnspecified=0 or 512 frames per buffer in PortAudio;

... as long as there is a single stream/"wire callback" used from PortAudio, a "drop input" is liable to happen when running `patest_duplex_wire.c` - and this, even with a virtual `dummy` driver, which has no communication with real hardware at all, and pretty much does nothing: its role of "reading"/"writing" or "returning" bytes is merely simulated by increasing the stream buffer position counters! The mind boggles - especially since, the way I see it, one should do nothing else but properly increase these buffer counters from the driver, in order to have PortAudio "believe" a "proper" full-duplex transfer is occurring?!... and yet, what this "proper" rule (of increasing driver buffer counters) should be, completely evades me.


Here I'd also like to note a few other observations - first, note that when scaling the driver hrtimer period to the period size (_psz), the `pav`/`phwav` became nearly constant, in comparison to the slopes still present upon FRAMES_PER_BUFFER=0 (which confuses me, since both: 705 bytes @ 4ms; and 2.9 bytes @ 2.9ms; should both be nearly as close to a rate of 44100 frames = 176400 bytes per second):

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_03_psz/trace_patest__06_DA_pr_512.csv_01.png

... but then, as the filenames above indicate, drops happen even then - although somewhat less often, and only when debug tracing in the driver is enabled. Could it be, that debug tracing directly from the driver can have such an effect on performance, so as to influence appearance of full-duplex "drop inputs" - even if precautions were taken, such as using `ftrace`s `trace_printk` (instead of the usual syslog `printk`), and piping the debug output directly to RAM (by using `/dev/shm`)?

On a scale of a complete capture, I'd usually expect all cumulative pointers to essentially follow a single line; and usually when a capture goes well, that is how it appears - like on the image below:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_04_jif/trace_patest__14_DF_pr_512.csv_.png

While it may be a bit difficult to follow all variables (recreate the plot in the interactive `wxt` terminal in `gnuplot`, to be able to turn off individual function plots), they all generally follow each other in the same general slope; also note that the capture ends at about 2 seconds (as programmed in `patest_duplex_wire.c`) - but playback lingers on for half a second more.

However, a full-duplex drop can seemingly happen even on a line that otherwise appears straight - like on the plot below (although the reason for that could be that the drop happens early in that capture):

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_02_jif/trace_patest__08_DA_w_512_drop.csv_.png

... but usually, a "drop input" resets (at least) the driver's playback `hw_ptr` (and others), like on the capture below:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_04_jif/trace_patest__07_DA_w_0_drop.csv_.png

Note that when using playback/record PA callbacks (which cannot detect a "drop input"), may have similar resets of playback `hw_ptr`:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_03_psz/trace_patest__05_DA_pr_0.csv_.png

... but also the capture variables may reset:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_03_psz/trace_patest__06_DA_pr_512.csv_.png

The above capture also shows `frgbtc` starting to deviate from `frgbtp`, when these "resets" occur - but piecewise, `frgbtc` still seems to keep slope parallel to `frgbtp` (and the rest of the cumulative position variables). However, this seems to be a case of proper XRUN, as the respective log for that capture includes "PaAlsaStream_HandleXrun: restarting Alsa to recover from XRUN" (while the full-duplex "drop input" is specifically _not_ an xrun).

Note also, that sometimes I get some variables to be completely non-linear:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/captures_01_psz/trace_patest__05_DA_pr_0.csv_.png

... however, note also that `captures_01_psz` was taken with an older version of the scripts, where I may have possibly failed to increase `ftrace` buffering - so I think those interruptions in the capture data are actually an artifact of a tracing problem. Otherwise, is it possible that ALSA could "pause" the playback/capture hrtimer tasklets for a while? Interestingly, when I tried using `patest_duplex_wire.c` with my onboard HDA Intel soundcard (naturally, without any kernel driver variable tracing, only the PA part) - a lot of the times it ended up producing similar non-linear (and diverging) cumulative variable traces - however, it never triggered a full-duplex "drop input".


Finally, I suspect that these settings in the `dummy-2.6.32-patest.c` module, may also play a role in the behavior that results with full-duplex drops (they are otherwise kept the same as in the original `dummy` module):

    static struct snd_pcm_hardware dummy_pcm_hardware = {
      .info =			(SNDRV_PCM_INFO_MMAP |
             SNDRV_PCM_INFO_INTERLEAVED |
             SNDRV_PCM_INFO_RESUME |
             SNDRV_PCM_INFO_MMAP_VALID),
    ...
      .buffer_bytes_max =	MAX_BUFFER_SIZE,
      .period_bytes_min =	64,
      .period_bytes_max =	MAX_PERIOD_SIZE, //(64*1024)
      .periods_min =		USE_PERIODS_MIN, //1
      .periods_max =		USE_PERIODS_MAX, //1024
      .fifo_size =		0,
    ...

... and my questions in respect to them, would be this (considering the capture data should be available through address substream->runtime->dma_area in the driver):

* Given that this is a virtual driver, there is no hardware with buffers whose status (how filled they are) could generate (hardware) interrupts; instead we "raise" hrtimer functions (softirq priority) directly from the kernel module - which further schedule a tasklet (with even lower priority), and where we have the opportunity to control the repetition period of the timer functions (and thus the expected transferred bytes per period, for a given audio rate). In this context, what is the meaning of `period_bytes_min` and `periods_min`? Can they be arbitrarily set - or should one set them in relation to the expected bytes per period achieved through the timer functions?
* Given that `dummy` is a virtual driver, and doesn't communicate with hardware - there is no actual DMA operation performed through it, right?
* If there is no actual DMA - is there actual MMAP? In other words, does the MMAP in SNDRV_PCM_INFO_MMAP refer to: memory mapping of a hardware card DMA bus address, to substream->runtime->dma_area; or to: memory mapping of kernel-space substream->runtime->dma_area, to whatever address user-space (e.g. snd_pcm_read()) uses to access it?
* If there is no actual DMA - should SNDRV_PCM_INFO_MMAP_VALID be then kept? (original `dummy` driver keeps it) What would be the meaning of SNDRV_PCM_INFO_MMAP_VALID in this context (of a virtual driver with hrtimer functions/tasklets?)
* What would be the meaning of SNDRV_PCM_INFO_JOINT_DUPLEX in this context? (I've seen [http://mailman.alsa-project.org/pipermail/alsa-devel/2007-December/004801.html "[alsa-devel] How do I use SNDRV_PCM_INFO_JOINT_DUPLEX?"], but I can't really relate it to this context) Could usage of SNDRV_PCM_INFO_JOINT_DUPLEX help avoid the PortAudio full-duplex drops?


And to summarize my general questions:

* Given the 'telecom' definition of full-duplex as "a point-to-point system composed of two connected parties or devices that can communicate with one another in both directions, simultaneously" (wiki), is there a stricter/more specific definition of "full-duplex":
** in terms of digital audio generally?
** specifically in PortAudio (I guess yes: "when a single callback is used for both playback and capture", but there's probably more in terms of buffer positions), and in ALSA (I guess no)?

* Given that none of the approaches used in the test (debug driver traces on vs. off; driver returning fixed vs. adaptive number of frames/bytes per period; driver tuning the period to pcm_period_size vs. to a jiffy; PA using fixed vs. using unspecified amount of frames per period) have explicitly prevented the appearance of single "wire" callback (full-duplex) drops; and given that the driver is a virtual one (merely updating buffer positions, which shouldn't be a CPU hog) - what could possibly be the reason for the full-duplex drops?

* Is it possible at all, to use the architecture of the `dummy` driver (hrtimer + tasklet just updating buffer positions) to code an ALSA driver, that will not generate full-duplex drops when used from PortAudio with single "wire" callback?
** If so, is there a metric/conditions in terms of ALSA driver variables, that should be followed to ensure proper full-duplex operation (under PortAudio with single callback)?

* Is it possible that the driver is OK - and instead I have a problem with coding of the single "wire" callback in PortAudio? (even though most of it is copied from examples)


Well, that was certainly a mouthful - but I hope at least I managed to provide a reproducible example, if not a coherent explanation of the problem...

Thanks in advance for any answers/pointers,
Cheers!
