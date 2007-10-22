From: James Cameron <quozl-kJBlkiJxCS/dtAWm4Da02A@public.gmane.org>
Subject: Re: [LAU] [alsa-devel] USB device gives wrong data?
Date: Tue, 23 Oct 2007 09:05:13 +1000
Message-ID: <20071022230513.GB3940@us.netrek.org>
References: <47192528.9080403@popdial.com>
	<1193034894.13299.1217094833@webmail.messagingengine.com>
	<471CD6BE.4090209@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <471CD6BE.4090209-rB/de7zFuWlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: william estrada <MrUmunhum-rB/de7zFuWlBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org" <linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Silence must be detected as a series of near equal samples, the absolute
value of a sample tells you nothing.

Given that the device produces PCM, it will contain an analog-to-digital
converter (ADC), which *should* be designed to yield the 0x80 value, but
manufacturing variables may conspire to produce a small offset and noise.

Offset.  There will usually be some residual DC offset in an ADC design.
Most of the DC offset is removed with capacitors in series on the signal
path.  DC offset moves the noise of silence in one direction away from
the zero point.

Noise.  Sampling noise in the ADC will cause the final bit to vary, so a
chain of 0x80 0x7f 0x80 0x7f in any length and order might be received
for a silent input.  This noise will vary according to temperature, and
other environmental factors.  Classic sources of noise are interference
from radio transmitters, and earth loop hum.

The kernel source file pcm_misc.c provides silence values for use by the
kernel in generating silence, not in recognising it.  Therefore these
values should not be used in a discussion of whether a device is
providing valid silence.

On Mon, Oct 22, 2007 at 09:58:38AM -0700, william estrada wrote:
> So I guess I need to make my filter flexible to match the current
> hardware device driver?

You should make any filter flexible enough to match all hardware, and
that way it will most reliably detect silence.

> How would you filter out noise?

You can filter out DC offset by measuring the offset you have, and
subtracting this measurement from your samples.

It is not possible to filter out ADC noise, because this noise is
inherent in the design of the ADC.  There are advanced techniques that
can be done during manufacturing, but you're not at that stage in the
product lifecycle.

However, you could measure the noise, and see if your measurements are
reduced by adding a balun to the audio cable, or by stabilising the
temperature of the device, or by isolating the ground loop.

For example, if I connect some instrument to the Mic or Line In of one
of my sound cards, the outer ring of the connector is anchored to
electrical ground on my computer.  The path through the safety ground
cable back to the instrument will usually cause a hum.  Using an audio
transformer on the path from the instrument to the sound card may fix
this.

-- 
James Cameron    mailto:quozl-kJBlkiJxCS/dtAWm4Da02A@public.gmane.org     http://quozl.netrek.org/
