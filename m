From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [Jackit-devel] usx2y jack driver
Date: Sat, 25 Sep 2004 16:10:29 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32983.192.168.1.5.1096125029.squirrel@192.168.1.5>
References: <200409222228.38243.annabellesgarden@yahoo.de>
    <32827.192.168.1.5.1096065064.squirrel@192.168.1.5>
    <1096078552.1407.1.camel@krustophenia.net>
    <200409251555.59384.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409251555.59384.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:

> Lee Revell wrote:
>>
>> Maybe I am missing something.  Why does this device need a specific
>> jack driver, as opposed to using the ALSA driver?  Wouldn't it be
>> better to improve the ALSA driver so that it can be used with jack?
>>

One thing I'm sure as my ears can't lie: the generic jack_alsa driver
crackles quite badly (no xruns however), the jack_usx2y don't. Period. :)

>
> Its usb's unableness to atomically handle power of 2 period sized data
> chuncs, what led to:
> This usx2y-alsa-jack driver pair uses a hardware dependant alsa-device
> for mmaped pcm transport.
> Advantage achieved:
> 	The usb_hcd places reads/writes pcm data into dma-memory.
> 	That memory is 	mmaped by jack's usx2y driver.
> 	Jack's usx2y driver is the first/last to read/write pcm data.
> 	Read/write is a combination of power of 2 period shaping and
> 	  float/int conversation.
> 	Compared to mainline alsa/jack we leave out power of 2 period
>         shaping inside snd-usb-* which needs memcpy() and additional
>         buffers.
> 	As a side effect possible unwanted pcm-data coruption resulting
>         of plain alsa's snd-usb-usx2y period shaping scheme falls away.
> 	Result is sane jack operation at buffering schemes down to
>         128frames, 2 periods.
> 	plain usx2y alsa mode is able to achieve 64frames, 4periods, but
>         only at the cost of easier triggered i.e. aeolus xruns (128 or
>         256frames, 2periods works but is useless cause of crackling).
>
> New functionality would possibly be better integrated into mainlines at
> more apropriate places. Target could be: jack mmaping power of 2 period
> sized float-pcm buffers and letting alsa (snd-usb-lib - alsa-lib -
> plugin) do power of 2 period shaping and float/int conversation.
>
> erm, but I'd rather make some sounds with this stuff before i dig into
> that deeper. And there is still that ohci issue.
>

FYI, on my laptop, that OHCI issue is still a serious showstopper. I am
collecting some log/trace data to file and append on alsa's bugtracker
(bug #0000425).

One thing I've noticed, but just related to VP, is that while having
hardirq-preempt=1 and /proc/irq/10/ohci_hcd/threaded=1, the kernel doesn't
crash when opening the PCM hw device (either via jackd or aplay). But
still useless or zombie anyway. It does crash however when I unplug my
US-224 (switch its power down).

With hardirq-preempt=0 or /proc/irq/10/ohci_hcd/threaded=0, I get the same
old bad behavior: a kernel oops somewhere on the ohci_irq handling, almost
immediately when the PCM device is open (e.g. by jackd or aplay).

If someone have an idea on how to dig on this, like some debugging
silver-bullet :) I'll very thankful. Ingo Molnar has taught me the serial
console method but, guess what, this is a post-modern laptop: it doesn't
have a serial port. Duh?

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
