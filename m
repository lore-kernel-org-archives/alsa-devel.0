From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: writing an alsa driver for an MPEG decoder chip
Date: Mon, 29 Aug 2005 19:45:34 +0200
Message-ID: <20050829174533.GA3822@home>
References: <20050828144637.GA4452@home> <431233D5.4020502@superbug.co.uk> <20050828223555.GA16031@home> <43124005.4030709@superbug.co.uk> <20050828233639.GB16031@home> <43125102.5020101@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43125102.5020101@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2005 at 01:04:18AM +0100, James Courtier-Dutton wrote:
> >Anyway, explanations and suggestions for improvement are still very 
> >welcome... ;-)
> 
> Well, get it working first, then improve it.

And as it now seems to be working, it's now time for improvements... ;-)

> For example, all the "magic" stuff is unneeded now.

I kept this stuff because I thought it was useful for compatibility with 
older alsa, but it seems I was mistaken. Thanks for pointing this, I 
will replace the magic stuff with the non-magic one... ;-)


> The Linux kernel has it's own scatter gather framework, but I can't 
> remember off hand how best to use it.

OK. But do you think it is worth spending some time. Isn't it fine the 
way I do it?


> Is the number of entries in the scatter-gather list a fixed size? If so, 
> how big is it? If the number of entries in the scatter-gather list can 
> be varied each time you open the device, then set the "periods_min/max 
> to the range of values it can take. Most sound cards generally do 
> between 2 and 8 periods.

The number of entries in the scatter-gather list is computed by dividing 
the size of the list (MA_PCISize) by the size of an entry. I used to 
think that MA_PCISize was read-only, which leads to a fixed-size list. 
But it certainly is worth trying to write it and see if it works fine... 
;-)

(With the firware I am using, there are 32 elements in the list.)


> You would generally pre allocate all the DMA memory use for sound in the
> snd_em8300_create() function.

I do call snd_pcm_lib_preallocate_pages_for_all in snd_em8300_pcm(). 
Should I move the call to snd_em8300_create()?


> One would then fill the scatter-gather list with pointers to the DMA
> memory in the snd_em8300_pcm_prepare() function.

That's already what I do... ;-)


> One would also try to do the fewest number of read/write to IO memory in 
> the em8300_alsa_audio_interrupt() function. I.e. remove the 
> read_ucregister(MA_PCISize) calls etc, and cache their values in the 
> em8300_alsa_t structure.
> You might want to write to the MA_PCISize register if you want the 
> application to be able to select a different number of periods. It would 
> be set in the prepare() function.

Or I guess I might use the number of periods instead of re-computing 
it... ;-)


Thanks for your help,

Nicolas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
