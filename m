From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Mon, 07 Jan 2008 22:34:32 +0000
Message-ID: <4782A8F8.8080609@superbug.co.uk>
References: <20071231171226.GA17953@tango.0pointer.de>
	<4782759B.5000208@superbug.co.uk>
	<20080107202104.GB31128@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id C10A424A19
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 23:34:24 +0100 (CET)
In-Reply-To: <20080107202104.GB31128@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> On Mon, 07.01.08 18:55, James Courtier-Dutton (James@superbug.co.uk) wrote:
>
>   
>> Lennart Poettering wrote:
>>     
>>> Hi!
>>>
>>> In PulseAudio I want to schedule on my own when I need to write audio
>>> data into the device and when not. To achieve that I want to be
>>> notified via poll() whenever a period boundary is passed (i.e. when an
>>> IRQ happens), but only then. That's different from the usual mode
>>> where you are notified via poll() whether there is space in the
>>> playback buffer that needs to be filled up. 
>>>
>>> On OSS the mmap() mode enables a mode like I described above. After
>>> enabling mmap() the application can decide by itself what it considers
>>> full and what empty in the dma buffer, and use GETOPTR to query the
>>> playback position. poll() on the OSS fd will directly reflect the
>>> sound card IRQs and is not influenced if you ever wrote data to device
>>> or not.
>>>
>>> I assume that I can enable a mode like that with one of the SW
>>> params. But quite frankly the docs for it are not enlighening at all.
>>>
>>> Lennart
>>>
>>>       
>> What would you want to do that for? Surely you just want to be told "I
>> need X samples now please", and that is what the current alsa
>> poll/callback method does.
>>     
>
> Not so "surely". In PA I want to schedule the wakeup frequency
> dynamically, based on the strongest requirement of all conncteded
> clients. To achieve that configure ALSA to use a large (2s) hw
> playback buffer, and then want to disable sound cards interrupts
> (except for time keeping), and schedule everything with system
> timers. Because those I can reconfigure without having to fully reset
> the audio device, and thus without getting any drop outs.
>
> In effect, as long as the user just plays an MP3 or so, the system
> will wakeup only every 2s or so and I will make use of the full hw
> playback buffer I previously configured, and thus save power. However
> as soon as a VoIP application connects which has stronger latency
> requirements I set my wakeups (with system timers) more often and only
> use a smaller part of the large hw audio buffer.
>
> Since ALSA doesn't allow me to reconfigure the the audio interrupt
> frequency dynamically during playback without having to reset the
> device I use those system timers. And because I do use those, I don't
> have much use for the buffer fill level management of ALSA -- because
> it is almost always wrong, because it doesn't know anything about my
> current latency constraints. 
>
> Now, with setting snd_pcm_sw_params_set_avail_min() to something
> perversly huge I can make sure that ALSA never wakes me up. However,
> that also has the effect that I can no longer user the sound card IRQ
> for getting the most accurate timing information from the sound card.
>
> Which sucks.
>
> I only want to use notification via poll() for keeping time, I don't
> want ALSA's buffer management. 
>
> Lennart
>
>   

Are you going to be at FOMS. It might be easier to explain to you there.
You are making assumptions about sound cards that might be wrong. E.g. 
2secs hw buffer for instance.
