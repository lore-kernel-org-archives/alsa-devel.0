From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 11:15:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302171112590.1054-100000@pnote.perex-int.cz>
References: <1045476241.3e50b391808f8@webmail2.namezero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045476241.3e50b391808f8@webmail2.namezero.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslaw Sobierski <fycio@gucio.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Feb 2003, Jaroslaw Sobierski wrote:

> > > b) sum overflow: we can lower volume of samples before sum; I think that
> > >    hardware works in this way, too
> > 
> > Here I don't understand you. Suppose we have 3 samples to mix:
> > a = 0x7500
> > b = 0x7400
> > c = 0x8300
> > 
> > If you do a + b + c (in this order) you obtain:
> > d=0
> > d += a -> 7500
> > d += b -> 0xe900 -> 0x7fff
> > d += c -> 0x02ff
> > 
> > while the correct result is 0x6c00. You see?
> 
> AFAIK most hardware does not mix by reducing volume before the sum. On the
> contrary, it is usually summed "as is" to a wider register, and often even so
> used. For example, a sound card able to mix 16 chanels of 16 bits would have
> a 16+4 bits or 24 bit register were the channels are added and no saturation
> can occur. In good hardware this would not even be downscaled back to 16 bits,
> but a 24 bit D/A converter would be used instead. In older times (Gravis Ultra
> Sound and I think older SB AWE) this could easily be spotted by the difference
> in supported "hardware" channels and "software" channels. A card with a 32 bit
> sum register and 24 bit DA could support (as above) 16 hardware channels and 
> for example 64 software channels (mixed together in quadrouplets to the 16 hw).
> 
> In our case, such "solution" would have to affect the whole buffer, meaning 
> we would need 3 (or better yet 4) bytes per sample, which would eventually get
> reduced back to 2 bytes on the way out to the sound card. This seems neither
> elegant nor memory efficient but would work, and also solves the "a)" problem
> because we don't need to saturate so an atomic add can be performed on each
> sample. 

Yes, this solution is good. I've though about it, too. Unfortunately, it 
adds additional transfers including saturation from the "sum" ring buffer 
to the DMA buffer of hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
