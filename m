From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Re: au8830 - front / rear channels swapped after
	first play and Surround40
Date: Sat, 12 Mar 2005 22:10:21 -0300
Message-ID: <1110676221.4034.28.camel@localhost>
References: <4232B5ED.1080508@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4232B5ED.1080508@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>, openvortex-dev <openvortex-dev@nongnu.org>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

On Sat, 2005-03-12 at 17:27 +0800, Raymond wrote:
> > > 3) Is the bug related to "vortex: IRQ fifo error" ?
> 
> >  No, thats not a bug. Thats normal.
> 
> http://lists.gnu.org/archive/html/openvortex-dev/2004-03/msg00007.html
> 
> I think the front/rear swap bug is related to that "vortex: IRQ fifo error".

AFAIK the FIFO error occurs only one time, the first time data is being
DMA'ed. It could be that this error is some kind of data underrun, and
it does only happen once, because we never flush the FIFO's when
stopping a stream. Remaining data in the FIFO's may be messing the
channel deinterlacer, because the amount of data loaded in the fifo is
random, generating a random offset. Since the the PCI bus is 32 bit
wide, that problem would not affect stereo streams, because one 32 bit
transaction maps to two 16 bit samples. Only where a frame is more that
32bits, this problem would become apparent. This is just a theory, but
maybe it could be worth a try, to enforce a absolute flush of the FIFO
data when stopping a DMA stream.

> As the hardware equalizer is only connected from the front channels to 
> the CODECOUT(0/1) in the ALSA au88x0 driver when playing at 4 channel 
> sound through hw:0,0 (adb)
> 
[snip!]
> It seem that the patch mentioned in
> 
> http://lists.gnu.org/archive/html/openvortex-dev/2003-12/msg00009.html
> 
> intened to fixed the problem in the OSS application in
> 
> http://lists.gnu.org/archive/html/openvortex-dev/2003-11/msg00016.html

I'm not that sure that these things are related directly. The patch in my 
opinion is just hiding either a hardware issue or a software problem. It 
may be related to the the way the fifos are stopped and resumed.

> 
> 1) Is the FIFO is still suspending not stopped ?

Don't know. AFAIK the fifos can be stopped or just paused. What
difference that makes, i don't know.

Best Regards
--
Manuel Jander
Electronic Engineer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
