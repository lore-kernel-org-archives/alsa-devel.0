From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Avoiding xruns... was Re: smix plugin available?
Date: Thu, 28 Nov 2002 00:07:27 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE4C38F.70302@superbug.demon.co.uk>
References: <Pine.LNX.4.33.0211270949140.532-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211270949140.532-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have read your comments below, and I would like to try to explain the 
problems I am coming up against when writing a multi-media app.

I am not going to say that I know everything about kernel scheduling, 
but for multi media applications, avoiding xruns is a major concern. 
This becomes particularly important in SPDIF passthru modes, because if 
one is outputting AC3 or DTS non-audio packs to an external decoder, an 
xrun will corrupt an entire AC3 or DTS pack that is equivalent to 
anything between 512 - 4096 PCM Sample Frames. So, loosing a single 
sample will be very noticable to the user.
I am currently taking the following approach: -
Always prepare 2 audio hardware periods of sample frames in advance 
inside the user app.

1) snd_pcm_wait()
2) write()
3) prepare new sample frames, then go back to (1).

Is this approach the best approach to use in order to avoid xruns ?
Using the "plug" interface does make the user app easier to write, but 
is using the "plug" interface adding too much overhead so as to increase 
the risk of xruns too much ?

Cheers
James


Jaroslav Kysela wrote:

>On Wed, 27 Nov 2002, James Courtier-Dutton wrote:
>
>  
>
>>Paul Davis wrote:
>>
>>    
>>
>>> 
>>>
>>>      
>>>
>>>>>the APIs that are used to write almost all audio software code in 
>>>>>production these days all use a callback model. 
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Sorry for questioning this statement. Of course we all don't have any statisti
>>>>cal data but
>>>>you miss what I see as the majority of applications that use audio devices:
>>>>
>>>>1) games
>>>>2) media players
>>>>3) GUI sounds (i.e. accessibility)
>>>>   
>>>>
>>>>        
>>>>
>>>this is a fair point. i apologize. i have my head so far inside the
>>>"audio software for musicians" box that i tend to fail to see such
>>>applications :)
>>>
>>>however, the very fact that the applications developers of such
>>>programs really don't know much (if anything) about audio programming,
>>>and probably don't want to know much about it either, suggests that an
>>>API like ALSA which exposes the full HAL is probably a mistake. again,
>>>i consider PortAudio a vastly preferable solution.
>>>
>>> 
>>>
>>>      
>>>
>>I would like to point out that a "callback" api would work just as well 
>>as an open/write/close api for
>>
>>1) games
>>2) media players
>>3) GUI sounds (i.e. accessibility)
>>
>>I have to agree with Paul on the fact that a "callback" approach is really the ONLY real option.
>>Here is my reasoning: -
>>1) My perspective is from "(2) Media players" and not "Pro-Audio"
>>2) Sound Hardware tends to have very small buffers.
>>3) For nice sounding audio, these buffers should never run dry. I.E. No XRUNs.
>>4) A open/write/close api will never ever be able to guarantee no XRUNs, as it has no control on when it will get scheduling time to do the next write.
>>5) With a "callback" approach, the kernel would be notified by the sound hardware that it was ready for new samples, the kernel could then adjust the scheduler, so that the "callback" function was called ASAP.
>>The "callback" function then only has to decide which samples to give. If the "callback" function could receive a "delay" value from the sound hardware at each callback, a media player would then have all the information it needed to do full audio/video sync.
>>    
>>
>
>Sorry, it's not as easy as you've described. It's not possible to invoke
>any user code from the kernel code directly. There is a scheduler which is
>informed that a task has been woken up. It depends on scheduler when the
>task is really invoked. It's quite same as for the r/w model where the
>application is notified over poll that something occured.
>
>  
>
>>6) I don't need "sample sync", but I do NEED "callback" based api to provide me with "no XRUNs".
>>    
>>
>
>I don't think that there is some difference. If the scheduler don't give 
>you enough time, the audio stream is somehow broken on all architectures.
>
>  
>
>>Summary: - 
>>The only way to cure XRUN problems is with a "callback" based api.
>>All application that currently use open/write/close apis, can just as easily use a "callback" api.
>>    
>>
>
>Let's go and see the implementation:
>
>The callback model is good for perfect sync between applications. It can 
>do (and does) chaining of more sources, arbitrating (removing invalid 
>sources) and so on. It is simply something "over" the audio HAL. If it 
>really helps, it's a different point.
>
>The discussed difference (a few months ago) was in a count of the task 
>context switches.
>
>With jack, you have these context switches (daemon and two applications 
>mixed together) for one period of samples (* means a context switch):
>
>jackd -*> app1 -*> app2 -*> jackd -> soundcard
>
>With r/w model and a sample mixing server implemented in the user space, 
>you can get this for one period of samples:
>
>mserver -> soundcard
>        -*(ring buffer does not contain enough samples)> app1
>        -*(ring buffer does not contain enough samples)> app2
>
>In real real-time setup, there will be two periods (thus app1 and app2) 
>will be woken up all times. So, in real world the context switches are for 
>one period of samples:
>
>mserver -*> app1 -*> app2   or
>mserver -*> app2 -*> app1
>
>Note: mserver implementation uses same assumptions as jack (or any other
>callback model). The ring buffers are shared between app and mserver and
>the period of samples is a constant. The playback / capture pointers are
>incrementing by the period size steps. Thus there is no need to commit 
>result directly back to the mserver. mserver will be woken up by the 
>kernel scheduler when next poll() event occurs (on next period boundary).
>
>Ok, it's only simple example, that there are more solutions than Paul 
>suggests. I fully agree, that the callback model is suitable for the 
>perfect synchronization among more applications. Also, imagine that
>mserver is not using a soundcard as output device, but jackd. So, 
>applications using r/w can use benefits of jackd (of course, there will be 
>one more period of samples buffered, but who will care when the start is 
>synchronized?).
>
>In my brain, there is also totaly different solution with the zero context 
>switching overhead - sharing the soundcard DMA buffer among more 
>applications. There is only one problem: snd_pcm_rewind() implementation 
>cannot be perfect, because of wrapping added sample values (we lose 
>information which cannot be recovered). The question is, if it's a fatal 
>problem.
>
>Let's discuss these things. Hopefully, I'll get some time to implement at 
>least the mserver functionality.
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>
>
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
