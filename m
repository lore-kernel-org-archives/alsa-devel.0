From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Direct Stream Digital (DSD/DST,
 One Bit Audio) HDMI pass-trough
Date: Wed, 15 Oct 2014 08:38:22 -0500
Message-ID: <543E78CE.8070801@linux.intel.com>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>	<543C58AC.9000701@linux.intel.com>	<CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>	<543D369E.5020002@linux.intel.com>
 <CAGzU1+ERCK+nA2F9tXdR18ZQU=RJ1cUwzF3hRkDTHgc1sGd33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B71260432
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 15:38:34 +0200 (CEST)
In-Reply-To: <CAGzU1+ERCK+nA2F9tXdR18ZQU=RJ1cUwzF3hRkDTHgc1sGd33A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Falout <andrej@falout.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/14/14, 10:30 PM, Andrej Falout wrote:
> Hello Pierre-Louis,
>
> On Wed, Oct 15, 2014 at 3:43 AM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com
> <mailto:pierre-louis.bossart@linux.intel.com>> wrote:
>
>     On 10/13/14, 7:49 PM, Andrej Falout wrote:
>
>
>         What are you basing your assessment that "HDMI controllers typically
>         don't support DSD in the PC space"? I looked, but could not find any
>         evidence for this.
>
>
>     I am basing my judgement on first-hand experience with silicon.
>
>
> Me too :) Absolutely every HDMI related chip I examined specs for and
> tested, including the cheapest of the cheap ones made as HDMI repeaters
> for splitters and audio extractors, supported DSD stream passing (Both
> up and down stream), just as they did all other audio bitstreams.
>
> For example:
> http://www.mds.com/system/resources/BAhbBlsHOgZmSSIuMjAxMy8xMC8xNi8xNy8yOS80NS80MjYvSFNSX0hTX3Jldl81ZC5wZGYGOgZFVA/HSR-HS_rev_5d.pdf
>
> Can you please point out a specification or other document that say
> otherwise?

You are not looking at the right specifications. You need to look at 
HDMI interfaces for PCs, and I maintain that most of them don't support DSD.

>
>
>         Certainly, DSD is not a part of HDMI hardware implementation
>         (such as
>         for example, CEC). From all info I have, DSD is simply
>         multiplexed into
>         HDMI data stream, just as DST-HD or AC3 is.
>
>
>     This multiplexing is typically not implemented - mainly because this
>     isn't a format used outside of niche markets
>
>
> It seems that you are talking about coding/decoding, not bitstream
> multiplexing? Same TMDS stream multiplexing is used for all audio
> streams in HDMI - weather native (PCM/DSD) or encoded (AC3, DTS, ...)
> The only real difference that I can see is the stream setup as described
> in my OP ("Table 47 CEA Short Audio Descriptor for Audio Format Codes 9
> to 13", (eg setting the format code, bittness, etc))
>
>     and there was no real format to convey DSD over PCM frames until the
>     DOP format was created in 2012.
>
>
> Again, I am talking about native DSD formats/streams, not DoP - which is
> in essence PCM. HDMI specs do not know or need DoP. HDMI is capable of
> native DSD transfer since version 1.2. See point #5 in my OP.
>
>     DTS-HD and AC3 use a PCM format which is rather straightforward to
>     implement but there's quite a few cases where these modes have been
>     dropped.
>
>
> As you say, these are rather straightforward to implement, as evident
> from the HDMI specification which describes the stream setup. Same
> specification also described DSD stream setup, which is is essence
> exactly the same, just uses the different identifiers. (CEA Standard
> PDF, page 66, table 47. HDMI specs version 1.3a, pages 72-73 for DSD(One
> Bit Audio) and DST audio packet header and body formats)
>
> Can you point out a documented case where "these modes have been dropped"?
>
>     HDMI only requires 48kHz 2ch really.
>
>
> Even the HDMI version 1 requires "8 channel LPCM
> <http://en.wikipedia.org/wiki/Linear_pulse_code_modulation>, 192 kHz
> <http://en.wikipedia.org/wiki/Hertz>, 24-bit audio capability" :
> http://en.wikipedia.org/wiki/HDMI#Version_comparison

Wrong. See the HDMI spec, not Wikipedia.
The only requirement is:
If an HDMI Source supports any HDMI audio transmission, then it shall 
support 2 channel L-PCM (using an IEC 60958 Subpacket structure), with 
either 32kHz, 44.1kHz or 48kHz sampling rate and a sample size of 16 
bits or more.

Additional rates are not required and often not implemented:
An HDMI Source is permitted to transmit L-PCM audio data at sample rates 
of 32kHz, 44.1kHz,48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz.

DSD is equally optional:
A Source may transmit One Bit Audio at an fS (1/64th of the bit rate) of 
32kHz, 44.1kHz, 48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz. Any Source 
capable of supporting One Bit Audio should support an fS of 44.1kHz, 
corresponding to a bit rate of 2.8224MHz.

May and should are not mandatory statements.

>
>     Note that the facts don't mean any negative judgement on quality, i
>     was at AES this week-end where I heard outstanding DSD/DXD
>     recordings. You will have more luck with a USB DAC, there are
>     multiple USB DSD products available.
>
>
> There is about 30 million DSD capable DACs in the world today,
> conservatively speaking, most of them multi-channel capable (See point
> #3 in my OP). I appreciate that there are a few USB DSD DACs out there
> too, and even 2 (two) multi-channel models. ;)

I wish you luck. over and out.

> Thanks,
> Andrej Falout
>
>
