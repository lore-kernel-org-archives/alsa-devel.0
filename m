From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Thu, 25 Jul 2013 02:29:04 +0200
Message-ID: <51F07150.1060004@imi.aau.dk>
References: <51EF41C8.2040701@imi.aau.dk>
	<201307241403.28873.gineera@aspect135.co.uk>
Reply-To: Portaudio Mailing List <portaudio@music.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <portaudio-bounces@music.columbia.edu>
In-Reply-To: <201307241403.28873.gineera@aspect135.co.uk>
List-Unsubscribe: <http://music.columbia.edu/mailman/options/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/portaudio>
List-Post: <mailto:portaudio@music.columbia.edu>
List-Help: <mailto:portaudio-request@music.columbia.edu?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=subscribe>
Errors-To: portaudio-bounces@music.columbia.edu
Sender: portaudio-bounces@music.columbia.edu
To: alsa-devel@alsa-project.org
Cc: portaudio@music.columbia.edu, audacity-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Alan, Richard, 

Many thanks for your responses!


> 
> It is probably reasonable to consider Audacity not a focus of concern, since 
> it simply uses Portaudio.  [...]
> enlist help just from Alsa-devel, 

>  [...] agree with Alan that
> you need to take as much as possible out of the equation to start with
> - and that certainly means Audacity.

Fully agreed on that; the only reason I mentioned Audacity, was (more or less) "search engine optimization": I initially met the problem there - and looking up for "Audacity full duplex drop" didn't give me much at the time. And as it took me quite some time to dig up where the problem was coming from - I thought mentioning Audacity as a lead into the problem, may save others looking up something similar in the future. Unfortunately, sometimes providing too much detail may shift the focus in the problem - it was absolutely not my intention to blame Audacity for anything [in fact, I know it is my own driver coding skills to blame :) ]; just to have a mention for a future reference, and maybe to see if some from that community have had similar experiences. 

I am including audacity-dev in this reply, just so my response above is logged; however, I've modified the reply-to field in this post, to point only to portaudio and alsa-devel - so hopefully any future responses will be taken there.


> ... describing the hardware and ideally 
> presenting your driver code. 

I have already coded a virtual (that is, independent of any hardware) ALSA driver, and an example PortAudio program, that demonstrate the exact same problem (as I originally met with hardware and Audacity); and the driver, program and test scripts are posted at the link:

    http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/

... since I expect problems, if I try to attach all those files in a post to mailing list(s).


> 
> I think there are too many areas embroiled in this, and they need to be 
> separated out.  If you have issues writing an Alsa driver, don't rely on 
> Portaudio for testing, but use a range of audio players, or other means, [...]

I have used the default ALSA tools, `arecord` in parallel with `aplay`, and full-duplex in that way goes without any unexpected problems. It is only PortAudio when using a single/"wire" callback (and thus Audacity) where I experience the full-duplex "drop input" problem. 


> Have you read Takashi Iwai's notes:
> 
> 	http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/index.html ?
>

Many times! :) My difficulties there occur because the notes are written in respect to hypothetical devices, which I assume are PCI - and I don't really understand PCI. So I'm trying to translate the meanings when reading those notes to virtual drivers, and that sometimes works for me - sometimes, unfortunately, it doesn't (like with this problem).

 
> I suspect the 'dummy device' may not be a good model [...] 

Thanks for mentioning this - so far, I haven't read any comment online, on whether `dummy` is a good model of an actual hardware driver; judging from the way the timer functions are coded there, it seemed reasonable to me, so I assumed it is. Then again, I've tried to read `snd-hda-intel`'s driver, and I have a hard time relating it to `dummy`, so it certainly doesn't model all details; but I hoped at least the stream buffer positions (as eventually presented to user-space software) are correct. If anyone can confirm that `dummy` is not reliable in this, that would be great.


> [...] and you are not correctly 
> reporting the number of samples transferred to the hardware?

I agree that it must be the core of the problem - but I have problem understanding why, given I currently perceive that I'm doing everything right: I know I have a rate of 44100 frames per second; I choose either a period for timer functions, and calculate bytes per period to match the rate, or vice versa; and in each period, I increase stream buffer positions for that bytes per period amount (taking care of buffer wrapping). But PortAudio, when using a single callback for full-duplex, will still detect a "drop input" - and so, I'm at a loss in figuring out what is being done wrong. 


> If you think there is a problem with Portaudio, 
> run tests with standard sound hardware such as on-board, PCI or USB units 
> known to work with Alsa, and take the focus off your own driver 

I have already tried the PortAudio program with the onboard `snd-hda-intel` and its driver, and it doesn't do a full-duplex drop. However, when at the time I tried to plot the PortAudio variables I captured, I remember I got some weird plots (e.g. the cumulative count of framesGot in the PortAudio callback made a curved line, not a straight one). I should probably try this test again, though.


> (since others 
> will not be able to reproduce your custom results anyway). 

> If at all possible, use current
>  versions of software, and a set-up that others can replicate as much
>  as possible.

Well, I was hoping - given that the problem in OP is expressed in terms of an interaction of a virtual driver (no hardware) and a (relatively simple) PortAudio program - that it would be possible for others to reproduce the problem (at least on a matching kernel and PortAudio version), as it's all in software. 

However, I'll also admit that my original post is somewhat dense - and it may not have been obvious from first reading, that there is example code available that should run on any typical Linux PC (without need for additional card hardware).


> There are few 
> within Portaudio who are familiar with the Alsa code but we will try to 
> assist if needed (I think that list has a 20K size limit IIRC).  

Thanks for that, good to keep in mind. Well, I'm really hoping for a response from the alsa-dev folks, then - but given that this is a problem that is triggered (as far as I know) only in a specific section in PortAudio (even if by my own faulty driver code), I hope it would be OK to keep `portaudio` list in CC. I was also hoping that some Portaudio folks may have encountered the "full duplex drop" in their own development (even if on another OS, and with actual soundcards), and gained some insight with it they'd be willing to share.


> Please don't use such an old version of Audacity - we have updated our
> Portaudio snapshot significantly since then. Bugs in obsolete code
> really aren't interesting.

> Note that 
> Audacity does not utilise the latest Portaudio code available, so consider 
> getting a more recent version.
> 

The thing is, this work is part of a bigger project of mine, and in the name of reproducibility, I wanted to fix all my deliverables to the OSs I started working with (which is why I still use old versions). Given the "full duplex drop" is not a problem in PortAudio per se - but a problem with my ALSA driver code - I don't see a reason why the driver shouldn't work with these older versions, when/if it gets fixed. 


>> In Audacity, as far as I could see, there is only one PortAudio
>> callback defined (audacity-1.3.13/src/AudioIO.cpp has
>> audacityAudioCallback;), so Audacity basically has a single "wire"
>> callback for full-duplex.
> Correct.

Thanks for confirming that - that would mean (hopefully) that my PortAudio program `patest_duplex_wire.c`, when using a single "wire" callback, should be a somewhat accurate approximation for Audacity behavior; and therefore, if the driver problem gets solved with `patest_duplex_wire.c` - it should also be solved in Audacity. 


> Hope this can help to move your problem forward.
> 

I think I definitely should try running the experiments on the onboard "HDA Intel" soundcard, and try getting some more insight in how its driver manages its stream buffer positions - but I still hope some from alsa-devel may recognize the problem that I'm dealing with, and let me know where am I going wrong in buffer position calculation in my virtual driver (`dummy-2.6.32-patest.c`).

Many thanks again for the responses, 
Cheers!
