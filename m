From: Antti Boman <antti.boman@mindcom.fi>
Subject: Re: snd-cmipci with Jack not working
Date: Wed, 12 Feb 2003 23:39:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4ABEF9.8090008@mindcom.fi>
References: <3E379E8A.10502@mindcom.fi> <s5hsmvblw0e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmvblw0e.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
[snip]
 > anyway, i updated the driver a bit.
 > please update the cvs version and report whether it works or not.

Hi,

I tried RC7 without success. Does it have the change you mentioned in 
the driver, or should I go and try the CVS version? Well, I should, 
instead of asking this, but please drop a note if there's no use trying 
that.

I'll get into debugging jackd next.

Thanks a lot!

-a


The original message
--------------------
Takashi Iwai wrote:
> Hi,
> 
> At Wed, 29 Jan 2003 11:27:38 +0200,
> Antti Boman wrote:
> 
>>Hi,
>>
>>I and a few other people have tried to get snd-cmipci (8738 integrated 
>>into ASUS A7V266 motherboard) work with Jack Audio Connection Kit, but 
>>with no success. We tried solving this problem in jack's developer list, 
>>but as there was no success I though (and was adviced) it might be the 
>>ALSA driver problem.
>>
>>The thread about the problem can be found at
>>http://sourceforge.net/mailarchive/forum.php?thread_id=1580464&forum_id=3040
> 
>  
> at first, please check which chip model you are using and get the
> register dump from /proc/asound/card0/cmipci.
> 
> 
>>I've gathered the key information here:
>>
>>- The sound when playing back is totally garbled, the pitch is lower
>>  than the original, and I get lots of clicking alongside. If I'm not
>>  using jack but alsa output, everything (playing and recording) is ok.
>>
>>- I have the lowlat patch installed in kernel, but using or not using it
>>  doesn't seem to change anything.
> 
>  
> most likely the kernel scheduler is irrelevant.
> 
> 
>>- The irq for the "card" is 10, and doesn't seem to be shared. I also
>>  have .asoundrc set up.
>>
>>- Jack server->client operation works ok, but playing back and recording
>>  cause the troubles.
>>
>>- After watching /proc/asound/card0/pcm0p/sub0/status and
>>  /proc/asound/card0/pcm0c/sub0/status, it seems that the wake-up does
>>  not happen in time although using relatively large buffersizes, or:
>>
>>- the playback and capture directions might be driven by different
>>  clocks (i.e. they run at different speeds)
> 
> 
> hmm, it's difficult to know, but i don't think so.
> could be an interrupt-related issue.
> 
> 
>>- Using jackd with playback/capture only, it produces the following
>>  message:
>>   jackd: pcm.c:5851: snd_pcm_mmap_commit: Assertion 'pcm' failed
> 
>  
> that's weird.
> 
> 
>>- If using kernel real-time patches with playback/capture only, the
>>  system locks up. This doesn't happen with both capture and playback
>>  enabled.
> 
>  
> i can't produce this on my machine...
> 
> 
> anyway, i updated the driver a bit.
> please update the cvs version and report whether it works or not.
> 
> 
> ciao,
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
