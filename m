From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 7 Sep 2004 11:05:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409071050020.1723@linux.local>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk>
 <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz>
 <20040906204559.GA4584@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1890E2A5
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 11:06:26 +0200 (MEST)
In-Reply-To: <20040906204559.GA4584@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Sep 2004, Adam Tla/lka wrote:

> IMHO DMA mmaped mode in ALSA is not as easy to use as OSS DMA mode.
> All we need is theoretically only the hw pointer position in DMA ring buffer 
> to properly mix data from different events. But in ALSA we must
> calculate it doing additional calls. Some functions like snd_pcm_delay
> in normal DMA mode seems to be not needed. An app needs only ring buffer
> hw position. Doing normal system call it can obtain current system time
> so it can calculate the delay and correct sample position to mix.

There is always a drift between system and card's timing.

> In ALSA we should move appl pointer using mmap_begin and then mmap_commit

The appl_ptr is not moved in mmap_begin. The mmap_begin function only 
returns the actual position to ring buffer based on appl_ptr.

> functions to avoid buffer underrun and calculate hw pointer manually
> to know where mix the new data. So I think there is more to do then in
> OSS case and more to do in the wrong way. I will send my sources
> after more testing.

We need the intelligent mmap transport for additional functionality 
(conversions, resampling etc.). I think it's the proper way and nobody 
(except OSS emulation) has the useability problem. You can still move 
backwards (although it is problematic when you have a mixing on the path).

> I have some questions. If I get delay < 0 and then do
> err = snd_pcm_forward(pcm,-delay) what err returned value really means
> (I am using dmix and of course rate plugins)?
> How interpret err <= 0 value?

err < 0 -> error code
err == 0 -> no action (appl_ptr was unchanged in case when you're already 
behind hw_ptr)

> Also what is the meaning of snd_pcm_available > alsa.buffer_size?

You're too late, so you need to fill (or better skip via forward) some 
more samples to synchronize appl_ptr.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
