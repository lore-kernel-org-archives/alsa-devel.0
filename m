From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 6 Sep 2004 22:45:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040906204559.GA4584@sunrise.pg.gda.pl>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk> <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 89F8C27A
	for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2004 22:46:05 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am testing modified aoss library.
To satisfy OSS compatibility I defined fixed OSS buffer (64KiB).
So we have two buffers: ALSA ring buffer and emulated OSS ring buffer.
Read/write normal modes are unchanged but in DMA mode we must copy the
first buffer contents to the second. To satisfy low latency I copy data
from hw pointer position so any changes in OSS DMA buffer should be
quickly propagated to ALSA buffer. I can't just fill whole ALSA buffer
and then fill available space at every period because data could change
just several samples after hw position. So I am doing snd_pcm_mmap_begin
and snd_pcm_commit functions to move appl pointer in ALSA ring buffer
so it is all filled 
(alsa_hw_ptr % alsa.buffer_size == alsa_appl_ptr % alsa.buffer_size)
and then calculate oss_hw_ptr as oss_appl_ptr - alsa.buffer_size.
Now I can copy the data (size = alsa.buffer_size - alsa.period_size).
So far it works with Q1, Q2 and Q3. Copying less data not always works
properly - sound is distorted.

IMHO DMA mmaped mode in ALSA is not as easy to use as OSS DMA mode.
All we need is theoretically only the hw pointer position in DMA ring buffer 
to properly mix data from different events. But in ALSA we must
calculate it doing additional calls. Some functions like snd_pcm_delay
in normal DMA mode seems to be not needed. An app needs only ring buffer
hw position. Doing normal system call it can obtain current system time
so it can calculate the delay and correct sample position to mix.
In ALSA we should move appl pointer using mmap_begin and then mmap_commit
functions to avoid buffer underrun and calculate hw pointer manually
to know where mix the new data. So I think there is more to do then in
OSS case and more to do in the wrong way. I will send my sources
after more testing.

I have some questions. If I get delay < 0 and then do
err = snd_pcm_forward(pcm,-delay) what err returned value really means
(I am using dmix and of course rate plugins)?
How interpret err <= 0 value?
Also what is the meaning of snd_pcm_available > alsa.buffer_size?

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
