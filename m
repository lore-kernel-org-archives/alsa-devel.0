From: Raymond <rayau@netvigator.com>
Subject: Re: Re: au8830 - front / rear channels swapped after first play and
 Surround40
Date: Thu, 17 Mar 2005 11:23:08 +0800
Message-ID: <4238F81C.30405@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

> >  No, thats not a bug. Thats normal.
>
>
> AFAIK the FIFO error occurs only one time, the first time data is
> being DMA'ed. It could be that this error is some kind of data
> underrun, and it does only happen once, because we never flush the
> FIFO's when stopping a stream. Remaining data in the FIFO's may be
> messing the channel deinterlacer, because the amount of data loaded in
> the fifo is random, generating a random offset. Since the the PCI bus
> is 32 bit wide, that problem would not affect stereo streams, because
> one 32 bit transaction maps to two 16 bit samples. Only where a frame
> is more that 32bits, this problem would become apparent. This is just
> a theory, but maybe it could be worth a try, to enforce a absolute
> flush of the FIFO data when stopping a DMA stream.

The "vortex: IRQ fifo error" message happen once when the first play is
a stereo or 4 channels sound and it do not happen when the first play is
a MONO sound on my au8830.

Using "vortex_adbdma_stopfifo()" instead of vortex_adbdma_pausefifo()"
in snd_vortex_pcm_trigger() (just like the last version of au88x0 in
alsa-driver before it merged into alsa-kernel) seem to fix the
front/rear channels swap when playing 4 channels sound in au8830.

However the message "vortex: IRQ fifo error" will appear more than once
in the kernel log, it is quite annoying when a lot of these message is
displayed on the screen (not always) during the shutdown of the linux.






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
