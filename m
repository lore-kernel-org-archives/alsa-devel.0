From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Re: Re: au8830 - front / rear channels swapped
	after first play and Surround40
Date: Thu, 17 Mar 2005 10:45:39 -0400
Message-ID: <1111070739.3269.4.camel@localhost>
References: <4238F81C.30405@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4238F81C.30405@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

On Thu, 2005-03-17 at 11:23 +0800, Raymond wrote:
> > >  No, thats not a bug. Thats normal.
> >
> >
> > AFAIK the FIFO error occurs only one time, the first time data is
> > being DMA'ed. It could be that this error is some kind of data
> > underrun, and it does only happen once, because we never flush the
> > FIFO's when stopping a stream. Remaining data in the FIFO's may be
> > messing the channel deinterlacer, because the amount of data loaded in
> > the fifo is random, generating a random offset. Since the the PCI bus
> > is 32 bit wide, that problem would not affect stereo streams, because
> > one 32 bit transaction maps to two 16 bit samples. Only where a frame
> > is more that 32bits, this problem would become apparent. This is just
> > a theory, but maybe it could be worth a try, to enforce a absolute
> > flush of the FIFO data when stopping a DMA stream.
> 
> The "vortex: IRQ fifo error" message happen once when the first play is
> a stereo or 4 channels sound and it do not happen when the first play is
> a MONO sound on my au8830.
> 
> Using "vortex_adbdma_stopfifo()" instead of vortex_adbdma_pausefifo()"
> in snd_vortex_pcm_trigger() (just like the last version of au88x0 in
> alsa-driver before it merged into alsa-kernel) seem to fix the
> front/rear channels swap when playing 4 channels sound in au8830.

Using "vortex_adbdma_stopfifo" sounds more reasonable to me, regarding
of what i explained above. 

> However the message "vortex: IRQ fifo error" will appear more than once
> in the kernel log, it is quite annoying when a lot of these message is
> displayed on the screen (not always) during the shutdown of the linux.

Does the IRQ fifo error appear once for every sound played or a lot more
than that ? if it appears once for every PCM plaayback start, it may be
that this error is just a harmless "fifo empty" error, and as such could
be just ignored. An if it really signals a FIFO empty error, it maybe
useful to detect xruns ?

Best Regards,
-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
