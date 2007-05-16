From: Rene Herman <rene.herman@gmail.com>
Subject: Re: ICE1712/1724 HW mixing?
Date: Thu, 17 May 2007 00:53:56 +0200
Message-ID: <464B8B84.60302@gmail.com>
References: <464A5D6A.9020104@gmail.com>
	<200705160927.40433.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 34D3B243D2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 00:56:35 +0200 (CEST)
In-Reply-To: <200705160927.40433.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/16/2007 10:27 AM, Alan Horstmann wrote:

> My understanding was that ice1712 data format is always 24-bit 'loose-packed' 
> into 32-bits (ie with 0's added), the ice1724 is probably the same?  That is 
> what the Terratec DMX6fire handbook also says.  The chipset is 24-bit/96Khz 
> capable.

Okay, thanks for the answer. I had already added the 8 and 16-bit tags to 
the ICE1712 based cards based on the snd_ice1712_playback{,_ds} structures 
but I just deleted them again. Just not much idea of how and what and also 
not sure if the 24-bit tag is meant to signify "real" 24-bit or intended to 
be inclusive of this "24-in-32" format.

I'll pick up an Envy card eventually and try to understand it... ;-/

> Hardware mixing of 10 inputs and 10 outputs is provided. In the notes, it
> is probably worth mentioning Envy24control, a mixing/control tool 
> dedicated to this chipset?

Could you "cat /proc/asound/card0/pcm0p/info" (replace the 0,0 with where 
your 6Fire PCM is at) and confirm that "subdevices_count" is larger than 1 
to confirm it's HWMIXing in the ALSA sense?

The "details" text/page is currently a rather unhelpful generic text for all 
cards which I believe might just as well just be a standard link _from_ any 
card details page but with the details page itself being somewhat more card 
specific. Something like Envy24control would then nicely fit on it.

> The DMX6fire has both optical and phono SPDIF connectors

Both both input and output?

> and a wavetable connector in the front box (for use with DB50XG etc),
> and works fine since 1.0.12.

That connector might be worth a Tag-WaveBlaster or similar. Problem might be 
with growing too many tags after which people just don't maintain them. I've 
for example added "ANALOGio" to every single card on the TerraTec page which 
felt a bit silly. They should probably be added to approximately 99% of all 
cards but chances are slim anyone will bother...

Rene.
