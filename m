From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Sat, 10 Oct 2015 16:03:08 -0500
Message-ID: <56197D0C.3070902@linux.intel.com>
References: <alpine.DEB.2.02.1510092334230.25238@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 11460261687
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 02:45:31 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510092334230.25238@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/09/2015 04:47 PM, Ricard Wanderlof wrote:
> 
> The addition of 0xffff ("almost 1" in Q16.16 format), resulting
> in the rounding up of the resulting value, was in the wrong place,
> as it is the resulting packet size that needs to be rounded up
> to the nearest integer (e.g. if the resulting packet size is
> calculated as 55.125 bytes, we need a packet of 56 bytes),
> rather than the rate value (ep->freqmax).
> 
> Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
> ---
> Since this clearly is a sensitive part of the code, here follows a lengthy
> rationale with examples to illustrate the problem.
> 
> The code as it stands has the following expression on line 613 to 
> calculate the maximum isochronous packet size:
> 
> 	maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3)) 
> 			>> (16 - ep->datainterval);
> 
> Here, ep->freqmax is the maximum assumed sample frequency, calculated from the
> nominal sample frequency plus 25%. It is ultimately derived from ep->freqn,
> which is in the units of samples per packet, from get_usb_full_speed_rate()
> or usb_high_speed_rate(), as applicable, in Q16.16 format.
> 
> The expression essentially adds the Q16.16 equivalent of 0.999... (i.e.  
> the largest number less than one) to the sample rate, in order to get a 
> rate whose integer part is rounded up from the fractional value. The 
> multiplication with (frame_bits >> 3) yields the number of bytes in a 
> packet, and the (16 >> ep->datainterval) then converts it from Q16.16 back 
> to an integer, taking into consideration the bDataInterval field of the 
> endpoint descriptor, which describes how often isochronous packets are 
> transmitted relative to the (micro)frame rate (125us or 1ms, for USB high 
> speed and full speed, respectively). For this discussion we will assume a 
> bDataInterval of 0, so the second line of the expression just converts the 
> Q16.16 value to an integer.
> 
> In order to illustrate the problem, we will set frame_bits 64, which
> corresponds to a frame size of 8 bytes.
> 
> The problem here is that the addition of 0xffff is in the wrong place. We don't
> want the rounding up to take place on the frequency, but on the resulting
> packet size. Let's take an example. We have a sample rate of 96 kHz, so our
> ep->freqn is 786432 (see usb_high_speed_rate()). Add 25% (line 612) and we get
> 983040.  The calculated maxsize is then ((983040 + 65535) * 8) >> 16 = 127 .
> However, if we do the number of bytes calculation in a less obscure way it's
> more apparent what the true corresponding packet size is: we get 
> (96000 * 1.25 / 8000) * 8 = 120, where 1.25 is the 25% from line 612, and the
> 8000 is the number of isochronous packets per second on a high speed USB
> connection (125 us microframe interval).
> 
> Rephrasing the maxsize expression to:
> 
>         maxsize = (ep->freqmax * (frame_bits >> 3) + 0xffff)
>                                 >> (16 - ep->datainterval);
> 
> we instead get (983040 * 8 + 65535) >> 16 = 120 which is the correct value.
> 
> We can also do the calculation with a non-integer sample rate which is when
> rounding comes into effect: say we have 44.1 kHz (resulting ep->freqn = 361267,
> and resulting ep->freqmax 361267 * 1.25 = 451583 (rounded down).
> 
> Original maxsize = ((451583 + 65535) * 8) << 16 = 63 (63.124.. rounded down)
> True maxsize = (44100 * 1.25 / 8000) * 8 = 55.125, i.e. 56 bytes required
> New maxsize = (451583 * 8 + 65535) >> 16 = 56
> 
> This is also corroborated by the wMaxPacketSize check on line 616. Assume
> that wMaxPacketSize = 108, with ep->maxpacksize then having the same value.
> As 108 < 127, we get maxsize = 108. ep->freqmax is then recalculated to
> (108 / 8) << 16 = 884736 . Putting that rate into the original maxsize
> calculation yields a maxsize of ((884736 + 65535) * 8) >> 16 = 115
> (with decimals 115.99988). Clearly, we should get back the 108 here,
> which we would with the new expression: (884736 * 8 + 65535) >> 16 = 108 .
> 
> As it currently stands, the error is tolerable because it only results
> in maxsize being a bit too big which wastes a couple of bytes, either as
> a result of the first maxsize calculation, or because the resulting calculation
> will hit the wMaxPacketSize value before the packet is too big, resulting
> in fixing the size to wMaxPacketSize even though the packet is actually not
> too long.
> 
> However, I'm working on a quirk for a device which stuffs an extra four (non
> sample) bytes into each isochronous packet, and that means that the maxsize
> calculation must take this into account. During this work it became obvious
> that there was something wrong with the maxsize calculation, as the resulting
> packet size when wMaxPacketSize was hit did not correspond to the packet
> size which triggered the if statement to start with.

That sounds wild and borderline compliant. It's almost as if an encoded format should have been used for this pseudo-PCM with metadata.
Are those 4 extra bytes accounted for in what the device endpoint reports? If no, then I fail to understand how the fix would help, you may exceed the max packet size.
And this could also screw up the implicit feedback case where the rate is determined by looking at packet sizes.

> 
> Since this seems to me an obvious (after looking at it for a bit...) bug I'm
> submitting this as a separate patch rather than part of the upcoming patch
> series.
> 
>  sound/usb/endpoint.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index e6f7189..be8a972 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -610,7 +610,7 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
>  
>  	/* assume max. frequency is 25% higher than nominal */
>  	ep->freqmax = ep->freqn + (ep->freqn >> 2);
> -	maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
> +	maxsize = (ep->freqmax * (frame_bits >> 3) + 0xffff)
>  				>> (16 - ep->datainterval);
>  	/* but wMaxPacketSize might reduce this */
>  	if (ep->maxpacksize && ep->maxpacksize < maxsize) {
> 
