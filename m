From: Antti Boman <antti.boman@mindcom.fi>
Subject: Re: snd-cmipci with Jack not working
Date: Thu, 30 Jan 2003 12:00:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E38F7C0.9000904@mindcom.fi>
References: <3E379E8A.10502@mindcom.fi>	<s5hsmvblw0e.wl@alsa2.suse.de>	<3E386842.5000908@mindcom.fi> <s5hn0ljkm4g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0ljkm4g.wl@alsa2.suse.de>
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
> At Thu, 30 Jan 2003 01:48:18 +0200,
> Antti Boman wrote:
>>>>
>>>>- I have the lowlat patch installed in kernel, but using or not using it
>>>> doesn't seem to change anything.
>>> 
>>>most likely the kernel scheduler is irrelevant.
>>
>>The only effect it had was locking the whole machine when using 
>>playback/capture only.
> 
> do you mean with LL-patch?  or with preempt patch?

Andrew Morton's 
(http://www.zip.com.au/~akpm/linux/schedlat.html#downloads) patch. Sorry 
about the flaws in terminology, I'm kind of half-dumb with these. If 
there are even difference with those ones, I have to check them out 
tonight and tell you then.

>>>>- Using jackd with playback/capture only, it produces the following
>>>> message:
>>>>  jackd: pcm.c:5851: snd_pcm_mmap_commit: Assertion 'pcm' failed
>>> 
>>>that's weird.
>>
>>Yes, and as you most probably know, it refers to alsa-lib/src/pcm/pcm.c
>  
> if the above function is directly called from jack, then it should be
> a bug of jack.  the error above says the passed argument is a null
> pointer.

I know. But I don't know if it's directly called from jackd. I'll try 
and ask more on jackit-devel or try to find things myself. May be 
another dead-end, though.

> ah, sorry, what do you mean "kernel real-time patches"?
> preempt-patch?
> 
> then i don't know.  i don't use them together with 2.4 kernels.

Then again, even without enabling low latency (whatsoever) it doesn't 
work. I'm just afraid this won't be solved. And I'm not afraid for 
myself, just for the fact that 8738 is a highly used chip. Have you 
tried running jackd with the one of yours?

Cheers,
-a



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
