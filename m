From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: difference between OSS mmap and alsa mmap? [alsa-oss]
Date: Tue, 24 Aug 2004 15:30:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <412B5115.5020309@superbug.demon.co.uk>
References: <20040705144251.6a286c94@mango.fruits.de> <200407051313.i65DDlH7023180@localhost.localdomain> <s5hvfh27fr6.wl@alsa2.suse.de> <20040824135710.2422ef23@mango.fruits.de> <Pine.LNX.4.58.0408241526220.1927@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408241526220.1927@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Takashi Iwai <tiwai@suse.de>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 24 Aug 2004, Florian Schmidt wrote:
> 
> 
>>btw: i might prove my ignorance with this question, but i have to ask:
>>
>>what makes the kernel oss emu handle mmap so good? it's an emulation,
> 
> 
> Nothing. It allows direct uncontrollable access to the ring buffer.
> Only some hardware is supported.
> 
> 
>>too, i suppose.. so what is the big difference in these two emulations,
>>that in one case it works well [kernel oss emu] and in the other it
>>seems almost impossible [libaoss.so]..
> 
> 
> The libaoss should work at least for direct buffers in very similar way.  
> Unfortunately, there is one problem for dmix and other plugins (rate,
> conversions) which RELY on the mmap_begin/mmap_commit sequence. The
> mmap_commit initiates the real mixing. Unfortunately, if you have the
> uncontrollable mmap access (OSS), you don't know exactly which data were
> changed. Thus we may only guess which sample regions needs to be flushed 
> using the mmap_commit method.
> 
> So resume: If you have access to direct DMA buffer (hw:X,Y devices), the 
> behavior should be same. Unfortunately, all next processing like mixing, 
> conversions needs more work. OSS API has no control for transferred 
> samples for mmap mode. Applications can do anything they want with the 
> ring buffer.
> 
> OSS API is evil in this area. But they must solve same problem for their 
> virtual mixing devices. Again, I think that they must introduce some extra 
> latency to solve the mmap problems. I can imagine that they might have two 
> serialized (FIFO) ring buffers. One for application and the second one 
> for the real hardware. The real output delay won't be one ring buffer, but 
> two ring buffers in this case. Perhaps, we might try this way.
> 
> 						Jaroslav
> 

One runs into the same issues with writing an ALSA driver for wine.
Windows ASIO just lets the application write directly to the hardware 
ring buffer, much the same way that OSS does.

I also think that the best way to handle this is to use double buffering.
So the user app writes to a ring buffer, and alsa just copies one period 
at a time to the hardware buffer each time periods_elapsed is called.

This will introduce latency, but the latency will be small, and 
acceptable in my view, until applications switch to using alsa direct.

If an interrupt is missed, samples will just get lost.
Recently, some latency profiling code is being developed for the linux 
kernel, so soon we will be able to track and fix all those places in the 
kernel that hold onto the CPU for >1ms.
Once all the critical sections in the kernel are fixed, low latency will 
be reliable for everyone.

James


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
