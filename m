From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 14:29:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E50E3D3.49AF1D55@libero.it>
References: <Pine.LNX.4.44.0302171407290.1054-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Mon, 17 Feb 2003, Abramo Bagnara wrote:
> 
> > Jaroslav Kysela wrote:
> > >
> > > On Mon, 17 Feb 2003, Jaroslaw Sobierski wrote:
> > >
> > > > > > b) sum overflow: we can lower volume of samples before sum; I think that
> > > > > >    hardware works in this way, too
> > > > >
> > > > > Here I don't understand you. Suppose we have 3 samples to mix:
> > > > > a = 0x7500
> > > > > b = 0x7400
> > > > > c = 0x8300
> > > > >
> > > > > If you do a + b + c (in this order) you obtain:
> > > > > d=0
> > > > > d += a -> 7500
> > > > > d += b -> 0xe900 -> 0x7fff
> > > > > d += c -> 0x02ff
> > > > >
> > > > > while the correct result is 0x6c00. You see?
> > > >
> > > > AFAIK most hardware does not mix by reducing volume before the sum. On the
> > > > contrary, it is usually summed "as is" to a wider register, and often even so
> > > > used. For example, a sound card able to mix 16 chanels of 16 bits would have
> > > > a 16+4 bits or 24 bit register were the channels are added and no saturation
> > > > can occur. In good hardware this would not even be downscaled back to 16 bits,
> > > > but a 24 bit D/A converter would be used instead. In older times (Gravis Ultra
> > > > Sound and I think older SB AWE) this could easily be spotted by the difference
> > > > in supported "hardware" channels and "software" channels. A card with a 32 bit
> > > > sum register and 24 bit DA could support (as above) 16 hardware channels and
> > > > for example 64 software channels (mixed together in quadrouplets to the 16 hw).
> > > >
> > > > In our case, such "solution" would have to affect the whole buffer, meaning
> > > > we would need 3 (or better yet 4) bytes per sample, which would eventually get
> > > > reduced back to 2 bytes on the way out to the sound card. This seems neither
> > > > elegant nor memory efficient but would work, and also solves the "a)" problem
> > > > because we don't need to saturate so an atomic add can be performed on each
> > > > sample.
> > >
> > > Yes, this solution is good. I've though about it, too. Unfortunately, it
> > > adds additional transfers including saturation from the "sum" ring buffer
> > > to the DMA buffer of hardware.
> >
> > I remember you that the main point of dmix existence is the "direct"
> > part.
> >
> > If we'd need to use an intermediate buffer and a mixing thread, the dmix
> > approach lose our interest.
> >
> > A solution might be to have a shared parallel sw ring buffer where to
> > store the exact value:
> >
> >         xadd(sw, *src);
> >       do {
> >               v = *sw;
> >               if (v > 0x7fff)
> >                       s = 0x7fff;
> >               else if (v < -0x8000)
> >                       s = -0x8000;
> >               else
> >                       s = v;
> >               *hw = v;
> >       } while (unlikely(v != *sw));
> >
> > This should solve also the atomicity update.
> >
> > Comments?
> 
> We probably talk about same thing, but in different words. I also don't
> think that atomicity is an problem when xadd() is atomic (and it is atomic
> for i386).
> 
> Then you need to do the saturation and store to the hardware ring buffer,
> but if this operation is after xadd() then we don't care about atomicity,
> because we are 100% sure that we have a valid result.
> 
> Algorithm:
> 
>         while (count) {
>                 atomic_xadd(sum_ring_buffer[idx], local_buffer[idx]);
>                 hw_ring_buffer[idx] = saturate(sum_ring_buffer[idx]);
>         }

You're wrong: xadd is atomic but xadd/read/saturation/write is not.

Without the loop I've added you risk to write on hw_ring_buffer an *old*
value:

A:		B:
xadd
read
		xadd
		read
		saturate
		write
saturate
write

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
