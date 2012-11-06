From: Jeffrey Barish <jeff_barish@earthlink.net>
Subject: Re: Ticks when playing to USB DAC at high sample rates
Date: Tue, 06 Nov 2012 16:54:25 -0700
Message-ID: <9872736.seOqKZ7sS2@quintet>
References: <3884466.olklcBH31l@quintet> <3608072.60TCDCLhjU@quintet>
	<509855FA.7000409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <509855FA.7000409@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue 06 November 2012 01:12:42 Daniel Mack wrote:
> On 05.11.2012 23:29, Jeffrey Barish wrote:
> > On Mon 05 November 2012 16:03:00 Daniel Mack wrote:
> >> Hi Jeff,
> >> 
> >> On 05.11.2012 02:53, Jeffrey Barish wrote:
> >>> On Sun 04 November 2012 11:39:48 Daniel Mack wrote:
> >>>> [cc alsa-devel]
> >>>> 
> >>>> On 04.11.2012 02:25, Jeffrey Barish wrote:
> >>>>> On Fri 26 October 2012 15:21:06 Jeffrey Barish wrote:
> >>>>>> On Fri 26 October 2012 21:47:05 Daniel Mack wrote:
> >>>>>>> On 26.10.2012 21:43, Jeffrey Barish wrote:
> >>>>>>>> On Thu 25 October 2012 19:10:45 Daniel Mack wrote:
> >>>>>>>>> On 25.10.2012 17:18, Jeffrey Barish wrote:
> >>>>>>>>>> I found something in the snd_usb_audio code (in endpoint.c) that
> >>>>>>>>>> could
> >>>>>>>>>> explain one of the problems I have observed (the ticks). I would
> >>>>>>>>>> normally test my theory by modifying the code. In this case, I
> >>>>>>>>>> would
> >>>>>>>>>> like to stick in a print statement to see what values are being
> >>>>>>>>>> assigned
> >>>>>>>>>> to certain variables. Unfortunately, I am too ignorant to do
> >>>>>>>>>> something
> >>>>>>>>>> even this trivial as I have never worked on kernel code. I think
> >>>>>>>>>> I
> >>>>>>>>>> am
> >>>>>>>>>> supposed to use printk,
> >>>>>>>>> 
> >>>>>>>>> printk is nice for simple debugging, yes. But note that this call
> >>>>>>>>> is
> >>>>>>>>> timing critical and should not be used in "fast path" code.
> >>>>>>>>> Introducing
> >>>>>>>>> a printk for each received packet for example will almost
> >>>>>>>>> certainly
> >>>>>>>>> make
> >>>>>>>>> the driver behave quite differently.
> >>>>>>>>> 
> >>>>>>>>>> but beyond that I am lost. Can someone provide
> >>>>>>>>>> me with some directions? I need to know how to make the driver.
> >>>>>>>>>> To
> >>>>>>>>>> that
> >>>>>>>>>> end, I probably will have to install additional packages. After
> >>>>>>>>>> making
> >>>>>>>>>> the driver, I need to know how to install it over the existing
> >>>>>>>>>> driver.
> >>>>>>>>> 
> >>>>>>>>> Here's one way to do it:
> >>>>>>>>> 
> >>>>>>>>> 1. git clone
> >>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> >>>>>>>>> (your
> >>>>>>>>> patch should apply on top of this tree eventually)
> >>>>>>>>> 2. cd sound
> >>>>>>>>> 3. zcat /proc/config.gz >.config
> >>>>>>>>> 4. build and install the kernel image. How that is done depends on
> >>>>>>>>> the
> >>>>>>>>> distribution you're using. For Ubuntu follow the docs at [1]
> >>>>>>>>> (start
> >>>>>>>>> at
> >>>>>>>>> point #5). For Fedora and others, something like "make && make
> >>>>>>>>> install"
> >>>>>>>>> should do
> >>>>>>>>> 5. reboot and check that the new kernel is running
> >>>>>>>>> 6. hack on sound/usb
> >>>>>>>>> 7. make M=sound/usb
> >>>>>>>>> 8. reload the module with "sudo rmmod snd_usb_audio; sudo insmod
> >>>>>>>>> sound/usb/snd-usb-audio.ko" (better plug out the device before so
> >>>>>>>>> you
> >>>>>>>>> always have the same defined point of start)
> >>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> Hope that works for you.
> >>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> Daniel
> >>>>>>>>> 
> >>>>>>>>> [1] https://wiki.ubuntu.com/KernelTeam/GitKernelBuild
> >>>>>>>> 
> >>>>>>>> Your directions were almost perfect, so even I was able to build
> >>>>>>>> the
> >>>>>>>> kernel. I made a discovery using the new kernel that might help
> >>>>>>>> someone
> >>>>>>>> more familiar with the code than I am to localize the problem.  I
> >>>>>>>> am
> >>>>>>>> still hearing the blip when I play audio sampled at 88.2 kHz, but I
> >>>>>>>> just
> >>>>>>>> noticed that the blip is perfectly periodic, with a period of about
> >>>>>>>> 16.4
> >>>>>>>> seconds.  I am playing a sine wave synthesized using GStreamer
> >>>>>>>> using
> >>>>>>>> the
> >>>>>>>> following command:
> >>>>>>>> 
> >>>>>>>> gst-launch audiotestsrc volume=0.01 ! audio/x-raw-float, width=64,
> >>>>>>>> rate=88200, channels=2, endianness=1234 ! audioconvert ! alsasink
> >>>>>>>> 
> >>>>>>>> A sine wave makes it easier to hear the blip.  Does this clue
> >>>>>>>> suggest
> >>>>>>>> anything?
> >>>>>>>> 
> >>>>>>>> I also want to mention that when I use the new kernel, I do not get
> >>>>>>>> the
> >>>>>>>> ticks at either 88.2 or 96 kHz even when I do not use the external
> >>>>>>>> USB
> >>>>>>>> hub.  I plan next to back up to the 3.6.2 kernel to see whether I
> >>>>>>>> still
> >>>>>>>> get ticks there.
> >>>>>>> 
> >>>>>>> Which kernel did you use when you heard the 'blibs'?
> >>>>>> 
> >>>>>> The latest news is bad.  I am on 3.2.0 now.  The USB DAC is working
> >>>>>> perfectly at this moment at both 96 kHz and 88.2 kHz without the
> >>>>>> external
> >>>>>> USB hub (imagine calling that bad news).  If I set the srate to 88.2
> >>>>>> kHz
> >>>>>> and stop and start the sine wave, sometimes I get the blip.  Forget
> >>>>>> about
> >>>>>> its being periodic.  It was definitely periodic before lunch; now I
> >>>>>> usually
> >>>>>> get random intervals if I get any blips at all.  As I am typing this
> >>>>>> message, I can't get blips at all.  There was some correlation
> >>>>>> between
> >>>>>> changing sample rates and blips, but I can't reproduce that behavior
> >>>>>> now.
> >>>>>> What is most weird is that I haven't gotten any ticks since lunch
> >>>>>> with
> >>>>>> any
> >>>>>> kernel or with either sample rate, yet they were reliable earlier
> >>>>>> today
> >>>>>> unless I used the external USB hub. I obviously need to experiment
> >>>>>> some
> >>>>>> more to see whether I can observe a pattern.
> >>>>> 
> >>>>> To conclude (?) this thread, I am now convinced that the anomalies I
> >>>>> observed were unrelated to the device driver.  I had two theories
> >>>>> remaining.  One was that the problem was somehow related to an
> >>>>> overheating problem.  I used a heat gun to convince myself that the
> >>>>> theory was wrong.  The other was that the problem had something to do
> >>>>> with services running in the background that interfered with the
> >>>>> device
> >>>>> driver.  I removed or disabled all services that I could identify as
> >>>>> superfluous.  Removed services include zeitgeist, apparmor,
> >>>>> modemmanager,
> >>>>> mdadm, and bluetooth.  Disabled services include atd, dns-clean, and
> >>>>> pppd-dns.  The system has been running perfectly with an 88.2 kHz
> >>>>> sample
> >>>>> rate and no external USB hub for 2 days.  However, I tried booting the
> >>>>> system with a copy of the OS from before I removed superfluous
> >>>>> services.
> >>>>> It still ran perfectly.  Thus, I cannot convince myself that removing
> >>>>> superfluous services actually solved the problem.  I suppose it's
> >>>>> possible that some service was running sporadically, which could
> >>>>> explain
> >>>>> why the problem seemed to come and go and also why the problem did not
> >>>>> occur when I booted the copy of the OS. As long as the problem remains
> >>>>> dormant I have no alternative but to move on and see whether the
> >>>>> problem
> >>>>> eventually recurs.  Only time will tell.
> >>>>> 
> >>>>> Thanks for all the help.  Hey, I built a kernel and got my own version
> >>>>> of
> >>>>> the device driver to run.  That was exciting.
> >>>>> 
> >>>>> ----------------------------------------------------------------------
> >>>>> --
> >>>>> --
> >>>>> ----
> >>>>> 
> >>>>> I'm back.  The USB DAC continued to work for two more days after my
> >>>>> last
> >>>>> message and then the blips resumed.  I've been digging into the driver
> >>>>> code
> >>>>> for two days.  I spent today trying to convince myself that the driver
> >>>>> is
> >>>>> actually using an asynchronous protocol.  The blips are almost
> >>>>> certainly
> >>>>> buffer underruns, which I could account for if the driver were not
> >>>>> responding to asynchronous feedback from the DAC.  I expected to see a
> >>>>> deviation from the pattern of one frame with 89 samples followed by 4
> >>>>> frames with 88 (which results in 88,200 samples per second).  That
> >>>>> sequence would work perfectly if the clocks in the computer and in the
> >>>>> USB DAC were exactly the same frequency, but of course they are not.
> >>>>> Consequently, I would expect to see requests for one sample more or
> >>>>> less
> >>>>> once in a while, depending on whether the clock in the computer is
> >>>>> slower
> >>>>> or faster than the one in the DAC.  What I see is 89 + 4 * 88 almost
> >>>>> all
> >>>>> the time, as expected .  Once in a while there is a request for an
> >>>>> additional frame of 88 and then the pattern of 89 + 4 * 88 resumes.  I
> >>>>> presume that the break in the usual pattern indicates that the device
> >>>>> driver is responding to a request from the DAC for fewer samples,
> >>>>> which
> >>>>> confirms that the driver is using the asynchronous protocol.  That's
> >>>>> good, if I am right. However, sticking in an extra packet of only 88
> >>>>> would be the expected deviation if the host were getting a little
> >>>>> ahead
> >>>>> of the DAC, yet the blip is almost certainly a buffer underrun, which
> >>>>> means that the host is actually falling behind.  Thus, an extra packet
> >>>>> of
> >>>>> 89 would make more sense.  I should also mention that there is no
> >>>>> correlation between the timing of the extra packet of 88 and the
> >>>>> audible
> >>>>> blip.  Something seems wrong here, but I'm not sure where to go next.
> >>>>> 
> >>>>> On a related topic, to confirm that the blip is a buffer underrun, I
> >>>>> would
> >>>>> like to synthesize a waveform that is DC.  With DC, an overrun would
> >>>>> not
> >>>>> produce any audible anomalies whereas an underrun would be audible.  I
> >>>>> am
> >>>>> using GStreamer to synthesize the test waveform.  Does anyone know of
> >>>>> a
> >>>>> way to synthesize a DC waveform using GStreamer?  If not, is there any
> >>>>> other tool available in Linux?
> >>>>> 
> >>>>> By the way, I bought another USB DAC from a different manufacturer to
> >>>>> be
> >>>>> sure that the anomalies I am observing were not due to a defect in the
> >>>>> DAC.  They both display the same problem.
> >>>>> 
> >>>>> -----------------------------------------------------
> >>>>> 
> >>>>> I modified the device driver to output a constant instead of the
> >>>>> incoming
> >>>>> waveform.  I get blips, as I expected, so I am now certain that the
> >>>>> blips
> >>>>> are caused by a buffer underrun.  The blips occur periodically again
> >>>>> --
> >>>>> period of about 16.5 seconds.  I presume that the period is related to
> >>>>> the difference in clock rates between the host and DAC.  Roughly every
> >>>>> 3-4 blips, I get an extra packet of 88 samples.  To prevent buffer
> >>>>> underrun, I ought to be getting an extra packet of 89 samples every
> >>>>> 16.5
> >>>>> seconds, but I never do.
> >>>> 
> >>>> Thanks for all your investigation on this! Sending computed data
> >>>> instead
> >>>> of the payload delivered by the ALSA stack is in fact a very good way
> >>>> to
> >>>> isolate the issue.
> >>>> 
> >>>> The question is: if the algorithm in the USB driver miscalculates the
> >>>> number of samples to send over time, what't the reason for that? Does
> >>>> the device report bogus values or is there this a bug in the driver?
> >>> 
> >>> Well, I have two DACs, each from a different manufacturer.  Both
> >>> experience
> >>> underruns (though not at the same rate).  It's possible that they are
> >>> both
> >>> reporting bogus values, but unlikely, so I'm leaning toward the bug
> >>> theory.
> >>> 
> >>>> Did you read chapter 5.4.12.1 of the USB2.0 spec, and can you explain
> >>>> where you suspect the bug to be? The current implementation in the
> >>>> driver is quite straight forward, mapping all feedback values to Q16.16
> >>>> and keeping the lower 16bits around for phase compensation between the
> >>>> calculation of the packet sizes.
> >>> 
> >>> Do you perhaps mean chapter 5.12.4.1 (Synchronization Type)?  I'm not
> >>> finding a 5.4.12.1 in usb_20.pdf from a zip dated 102512.
> >> 
> >> Yes, sorry.
> >> 
> >>> Please tell me whether I have this right:
> >>> 
> >>> You start transferring the sound in snd_usb_endpoint_start using
> >>> usb_submit_urb to submit 2 urbs to the USB core.  The urbs specify that
> >>> on
> >>> completion, the USB core should call snd_complete_urb.  snd_complete_urb
> >>> resubmits the urb after calling retire_playback_urb (by way of
> >>> retire_outbound_urb which calls retire_data_urb which is
> >>> retire_playback_urb), which updates its estimate of delay (what's that?
> >>> It seems to be 0 always)
> >> 
> >> That's just an information that is passed to userspace for latency
> >> compensation matters. As you don't stream data that ALSA passes up the
> >> stack anymore in your tests (but static data), you can ignore this
> >> detail for now.
> >> 
> >>> and prepare_playback_urb (by way of prepare_outbound_urb which calls
> >>> prepare_data_urb which is prepare_playback_urb), which fills the
> >>> transfer_buffer in the urb with the audio data (from a DMA buffer, I
> >>> guess).
> >>> 
> >>> Before filling transfer_buffer, prepare_playback_urb calls
> >>> snd_usb_endpoint_next_packet_size to compute the number of samples to
> >>> send.
> >>> This code appears to be the crux of what I need to understand because
> >>> the
> >>> value returned from this function is what is supposed to adjust to
> >>> prevent
> >>> buffer underruns.
> >> 
> >> That's correct.
> >> 
> >>> It isn't clear to me how this function gets information
> >>> about the state of the buffer in the device.
> >> 
> >> Via the callback of the feedback data endpoint - the momentary frequency
> >> is updated there and referred to again in
> >> snd_usb_endpoint_next_packet_size().
> >> 
> >>> The only argument to
> >>> snd_usb_endpoint_next_packet_size is ep, which is a pointer to the
> >>> snd_usb_endpoint structure.
> >> 
> >> Yes, the endpoint structure hold all runtime streaming details. Once a
> >> sync urb is given back from the host controller, retire_inbound_urb() is
> >> called and snd_usb_handle_sync_urb() cares for updating the momentary
> >> frequency of the slave of the sync endpoint, which is the data endpoint
> >> that is later on used by next_packet_size(). Makes sense?
> >> 
> >>> I see that ep->phase is the Q16.16 value you
> >>> mentioned, so the lower 16 bits are for "phase compensation between the
> >>> calculation of the packet sizes".  I don't completely understand that
> >>> phrase. freqm is an unchanging value (5780275)
> >> 
> >> freqm shouldn't be unchanging. Are you sure it really is? If so, is
> >> snd_usb_handle_sync_urb() ever called in your setup?
> > 
> > Yes.  freqm is always 5780275.  snd_usb_handle_sync_urb is never called.
> 
> Ok, we can probably stop debugging here already, because if that
> function is never called, something's badly wrong. No question the data
> endpoint will run out of bounds at some point if it doesn't get any
> usable feedback data.
> 
> > snd_usb_handle_sync_urb is called from only one place, retire_inbound_urb,
> > so the latter is never called.  I suppose that an inbound urb would never
> > need to be retired if one were never submitted.
> 
> Trace whteher usb_submit_urb() is called on the sync endpoint. There
> must be a reason why the completion routing is never callsed, and that's
> most probably also the solution of your problem.
> 
> [..]
> 
> > Since puzzling over the apparent absence of feedback about the state of
> > the
> > device, I had an epiphany this morning that such feedback is not
> > necessary.
> 
> It's always necessary, as two osciallators will drift from each other,
> no matter what. Without a feedback, there's no way the host can know how
> many data to send over the wire.
> 
> > The pattern of payload sizes should not change if the payloads are sent in
> > response to a request from the device.  The device makes this request by
> > calling snd_complete_urb when it finishes an urb.  As the device defines
> > time, the host is responsible only for having the next urb ready when the
> > device requests it.  Could it be that the missing feedback provides
> > nonessential information about the state of the device, such as
> > confirmation that the previous payload was successfully processed?
> > 
> > I repeated the test with a different DAC.  With that DAC it is still the
> > case that snd_usb_handle_sync_urb is never called.
> 
> How exactly did you make sure? There's something really wrong if what
> you describe happens, and we need to find the cause for it.
> 
> Unless you're dealing with a device that uses one data endpoint as clock
> source for another data endpoint (which is called an "implicit feedback"
> mechanism), you need to have a dedicated sync endpoint.
> 
> 
> Daniel

I guess that snd_usb_pcm_prepare is called by the core usb system to prepare 
the snd driver.  Anyway, snd_usb_pcm_prepare calls configure_endpoint with a 
substream.  Then configure_endpoint calls snd_usb_endpoint_set_params with the 
data endpoint that corresponds to the substream.  snd_usb_endpoint_set_params 
calls data_ep_set_params with the data ep and data_ep_set_params sets nurbs to 
2 for the data endpoint.

snd_usb_endpoint_set_params has code to call sync_ep_set_params when the 
endpoint is type sync.  sync_ep_set_params sets nurbs to 4 (why?).  However, 
snd_usb_endpoint_set_params never invokes the call to sync_ep_set_params 
because ep->type is always data.  Back up: snd_usb_endpoint_set_params is 
called from configure_endpoint.  It is called from an if block contingent on 
the substream's having a sync endpoint.  It does.  However, the call to 
snd_usb_endpoint_set_params passes subs->data_endpoint as the first argument, 
so snd_usb_endpoint_set_params simply repeats the operations it performed as a 
result of the previous invocation.  I presume that the first argument to the 
second call to snd_usb_endpoint_set_params should be subs->sync_endpoint.  I 
made that change.  Now freqm does change.  However, I am getting tons of 
ticks.  Now it sounds as if the payload size is always wrong.

Oh, 44.1 kHz works.  48 kHz works.  88.2 and 96 don't work.

Oh, we're back to the behavior I described many emails ago: If I keep 
restarting the playback at 88.2 or 96, eventually it will start and not 
produce machine-gun fire.  Previously, I would still hear sporadic "blips", as 
I called them.  I am not hearing blips anymore.  If playback starts clean, it 
stays clean -- and without blips.  If I use the external hub trick, I don't 
get machine-gun fire ever, but I do get sporadic blips again at both 88.2 and 
96 kHz.  I guess that I now have to figure out what is causing the machine-gun 
fire on about 90% of the starts at 88.2 or 96 kHz.  Any suggestions 
appreciated.  I have no idea where to start.  Seems like a timing issue.

Here is the only clue I can offer: I noticed that when I ^C the gst-launch 
command I use to play a sine wave (which actually plays DC because I replaced 
the memcpy commands in pcm.c with memset), I get the error message in kern.log 
"cannot submit urb 0, error -28: not enough bandwidth" only when I get 
machine-gun fire.  When playback works properly, terminating the gst-launch 
command with ^C produces no message in kern.log.  Mean anything to you?
-- 
Jeffrey Barish

------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
