From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Alsa-user] Ticks when playing to USB DAC at high
	sample rates
Date: Sun, 04 Nov 2012 11:39:48 +0100
Message-ID: <509645F4.6070400@gmail.com>
References: <3884466.olklcBH31l@quintet> <508AE8B9.4040405@gmail.com>
 <10249117.axLqbotY1S@quintet> <2168981.L00zyKDK9R@quintet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4491F265175
 for <alsa-devel@alsa-project.org>; Sun,  4 Nov 2012 11:39:50 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id z49so2130463wey.38
 for <alsa-devel@alsa-project.org>; Sun, 04 Nov 2012 02:39:50 -0800 (PST)
In-Reply-To: <2168981.L00zyKDK9R@quintet>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffrey Barish <jeff_barish@earthlink.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[cc alsa-devel]

On 04.11.2012 02:25, Jeffrey Barish wrote:
> On Fri 26 October 2012 15:21:06 Jeffrey Barish wrote:
>> On Fri 26 October 2012 21:47:05 Daniel Mack wrote:
>>> On 26.10.2012 21:43, Jeffrey Barish wrote:
>>>> On Thu 25 October 2012 19:10:45 Daniel Mack wrote:
>>>>> On 25.10.2012 17:18, Jeffrey Barish wrote:
>>>>>> I found something in the snd_usb_audio code (in endpoint.c) that could
>>>>>> explain one of the problems I have observed (the ticks). I would
>>>>>> normally test my theory by modifying the code. In this case, I would
>>>>>> like to stick in a print statement to see what values are being
>>>>>> assigned
>>>>>> to certain variables. Unfortunately, I am too ignorant to do something
>>>>>> even this trivial as I have never worked on kernel code. I think I am
>>>>>> supposed to use printk,
>>>>>
>>>>> printk is nice for simple debugging, yes. But note that this call is
>>>>> timing critical and should not be used in "fast path" code. Introducing
>>>>> a printk for each received packet for example will almost certainly
>>>>> make
>>>>> the driver behave quite differently.
>>>>>
>>>>>> but beyond that I am lost. Can someone provide
>>>>>> me with some directions? I need to know how to make the driver. To
>>>>>> that
>>>>>> end, I probably will have to install additional packages. After making
>>>>>> the driver, I need to know how to install it over the existing driver.
>>>>>
>>>>> Here's one way to do it:
>>>>>
>>>>> 1. git clone
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git (your
>>>>> patch should apply on top of this tree eventually)
>>>>> 2. cd sound
>>>>> 3. zcat /proc/config.gz >.config
>>>>> 4. build and install the kernel image. How that is done depends on the
>>>>> distribution you're using. For Ubuntu follow the docs at [1] (start at
>>>>> point #5). For Fedora and others, something like "make && make install"
>>>>> should do
>>>>> 5. reboot and check that the new kernel is running
>>>>> 6. hack on sound/usb
>>>>> 7. make M=sound/usb
>>>>> 8. reload the module with "sudo rmmod snd_usb_audio; sudo insmod
>>>>> sound/usb/snd-usb-audio.ko" (better plug out the device before so you
>>>>> always have the same defined point of start)
>>>>>
>>>>>
>>>>> Hope that works for you.
>>>>>
>>>>>
>>>>> Daniel
>>>>>
>>>>> [1] https://wiki.ubuntu.com/KernelTeam/GitKernelBuild
>>>>
>>>> Your directions were almost perfect, so even I was able to build the
>>>> kernel. I made a discovery using the new kernel that might help someone
>>>> more familiar with the code than I am to localize the problem.  I am
>>>> still hearing the blip when I play audio sampled at 88.2 kHz, but I just
>>>> noticed that the blip is perfectly periodic, with a period of about 16.4
>>>> seconds.  I am playing a sine wave synthesized using GStreamer using the
>>>> following command:
>>>>
>>>> gst-launch audiotestsrc volume=0.01 ! audio/x-raw-float, width=64,
>>>> rate=88200, channels=2, endianness=1234 ! audioconvert ! alsasink
>>>>
>>>> A sine wave makes it easier to hear the blip.  Does this clue suggest
>>>> anything?
>>>>
>>>> I also want to mention that when I use the new kernel, I do not get the
>>>> ticks at either 88.2 or 96 kHz even when I do not use the external USB
>>>> hub.  I plan next to back up to the 3.6.2 kernel to see whether I still
>>>> get ticks there.
>>>
>>> Which kernel did you use when you heard the 'blibs'?
>>
>> The latest news is bad.  I am on 3.2.0 now.  The USB DAC is working
>> perfectly at this moment at both 96 kHz and 88.2 kHz without the external
>> USB hub (imagine calling that bad news).  If I set the srate to 88.2 kHz
>> and stop and start the sine wave, sometimes I get the blip.  Forget about
>> its being periodic.  It was definitely periodic before lunch; now I usually
>> get random intervals if I get any blips at all.  As I am typing this
>> message, I can't get blips at all.  There was some correlation between
>> changing sample rates and blips, but I can't reproduce that behavior now. 
>> What is most weird is that I haven't gotten any ticks since lunch with any
>> kernel or with either sample rate, yet they were reliable earlier today
>> unless I used the external USB hub. I obviously need to experiment some
>> more to see whether I can observe a pattern.
> 
> To conclude (?) this thread, I am now convinced that the anomalies I observed 
> were unrelated to the device driver.  I had two theories remaining.  One was 
> that the problem was somehow related to an overheating problem.  I used a heat 
> gun to convince myself that the theory was wrong.  The other was that the 
> problem had something to do with services running in the background that 
> interfered with the device driver.  I removed or disabled all services that I 
> could identify as superfluous.  Removed services include zeitgeist, apparmor, 
> modemmanager, mdadm, and bluetooth.  Disabled services include atd, dns-clean, 
> and pppd-dns.  The system has been running perfectly with an 88.2 kHz sample 
> rate and no external USB hub for 2 days.  However, I tried booting the system 
> with a copy of the OS from before I removed superfluous services.  It still ran 
> perfectly.  Thus, I cannot convince myself that removing superfluous services 
> actually solved the problem.  I suppose it's possible that some service was 
> running sporadically, which could explain why the problem seemed to come and 
> go and also why the problem did not occur when I booted the copy of the OS.  
> As long as the problem remains dormant I have no alternative but to move on 
> and see whether the problem eventually recurs.  Only time will tell.
> 
> Thanks for all the help.  Hey, I built a kernel and got my own version of the 
> device driver to run.  That was exciting.
> 
> ------------------------------------------------------------------------------
> 
> I'm back.  The USB DAC continued to work for two more days after my last 
> message and then the blips resumed.  I've been digging into the driver code 
> for two days.  I spent today trying to convince myself that the driver is 
> actually using an asynchronous protocol.  The blips are almost certainly buffer 
> underruns, which I could account for if the driver were not responding to 
> asynchronous feedback from the DAC.  I expected to see a deviation from the 
> pattern of one frame with 89 samples followed by 4 frames with 88 (which 
> results in 88,200 samples per second).  That sequence would work perfectly if 
> the clocks in the computer and in the USB DAC were exactly the same frequency, 
> but of course they are not.  Consequently, I would expect to see requests for 
> one sample more or less once in a while, depending on whether the clock in the 
> computer is slower or faster than the one in the DAC.  What I see is 89 + 4 * 
> 88 almost all the time, as expected .  Once in a while there is a request for 
> an additional frame of 88 and then the pattern of 89 + 4 * 88 resumes.  I 
> presume that the break in the usual pattern indicates that the device driver 
> is responding to a request from the DAC for fewer samples, which confirms that 
> the driver is using the asynchronous protocol.  That's good, if I am right.  
> However, sticking in an extra packet of only 88 would be the expected 
> deviation if the host were getting a little ahead of the DAC, yet the blip is 
> almost certainly a buffer underrun, which means that the host is actually 
> falling behind.  Thus, an extra packet of 89 would make more sense.  I should 
> also mention that there is no correlation between the timing of the extra 
> packet of 88 and the audible blip.  Something seems wrong here, but I'm not 
> sure where to go next.
> 
> On a related topic, to confirm that the blip is a buffer underrun, I would like 
> to synthesize a waveform that is DC.  With DC, an overrun would not produce 
> any audible anomalies whereas an underrun would be audible.  I am using 
> GStreamer to synthesize the test waveform.  Does anyone know of a way to 
> synthesize a DC waveform using GStreamer?  If not, is there any other tool 
> available in Linux?
> 
> By the way, I bought another USB DAC from a different manufacturer to be sure 
> that the anomalies I am observing were not due to a defect in the DAC.  They 
> both display the same problem.
> 
> -----------------------------------------------------
> 
> I modified the device driver to output a constant instead of the incoming 
> waveform.  I get blips, as I expected, so I am now certain that the blips are 
> caused by a buffer underrun.  The blips occur periodically again -- period of 
> about 16.5 seconds.  I presume that the period is related to the difference in 
> clock rates between the host and DAC.  Roughly every 3-4 blips, I get an extra 
> packet of 88 samples.  To prevent buffer underrun, I ought to be getting an 
> extra packet of 89 samples every 16.5 seconds, but I never do.

Thanks for all your investigation on this! Sending computed data instead
of the payload delivered by the ALSA stack is in fact a very good way to
isolate the issue.

The question is: if the algorithm in the USB driver miscalculates the
number of samples to send over time, what't the reason for that? Does
the device report bogus values or is there this a bug in the driver?

Did you read chapter 5.4.12.1 of the USB2.0 spec, and can you explain
where you suspect the bug to be? The current implementation in the
driver is quite straight forward, mapping all feedback values to Q16.16
and keeping the lower 16bits around for phase compensation between the
calculation of the packet sizes.

If you find a better solution, please share it here, preferably in the
form of a patch :)


Thanks,
Daniel
