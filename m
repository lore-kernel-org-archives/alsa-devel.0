From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Direct Stream Digital (DSD/DST,
	One Bit Audio) HDMI	pass-trough
Date: Wed, 15 Oct 2014 11:41:58 +0200
Message-ID: <543E4166.7050704@ladisch.de>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>
 <543C58AC.9000701@linux.intel.com>
 <CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>
 <543D369E.5020002@linux.intel.com>
 <CAGzU1+ERCK+nA2F9tXdR18ZQU=RJ1cUwzF3hRkDTHgc1sGd33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 530B426051C
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 11:41:59 +0200 (CEST)
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
To: Andrej Falout <andrej@falout.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andrej Falout wrote:
> On Wed, Oct 15, 2014 at 3:43 AM, Pierre-Louis Bossart wrote:
>> On 10/13/14, 7:49 PM, Andrej Falout wrote:
>>> What are you basing your assessment that "HDMI controllers typically
>>> don't support DSD in the PC space"? I looked, but could not find any
>>> evidence for this.
>>
>> I am basing my judgement on first-hand experience with silicon.
>
> Me too :) Absolutely every HDMI related chip I examined specs for and
> tested, including the cheapest of the cheap ones made as HDMI repeaters for
> splitters and audio extractors, supported DSD stream passing (Both up and
> down stream), just as they did all other audio bitstreams.

Because they just need to copy the packets from the input to the output.

> Can you please point out a specification or other document that say
> otherwise?

For PCs, all HDMI outputs are handled with HDA controllers.  The HDA
specification does not mention DSD.  AMD's HDA verb documentation has
the following list of audio formats codes:
0: reserved
1: LPCM
2: AC-3
3: MPEG1 (Layers 1 and 2)
4: MP3 (MPEG1 Layer 3)
5: MPEG2 (Multichannel)
6: AAC
7: DTS
8: ATRAC
9: Reserved
10: Dolby Digital +
11: DTS-HD
12: MAT/MLP (Dolby True HD)
13: Reserved
14: WMA Pro

Would DSD be one of the reserved ones?

> As you say, these are rather straightforward to implement

... if one bothers to implement it.

> Same specification also described DSD stream setup, which is is
> essence exactly the same, just uses the different identifiers.

So the hardware needs some mechanism to output these identifiers.

>> HDMI only requires 48kHz 2ch really.
>
> Even the HDMI version 1 requires "8 channel LPCM, 192 kHz, 24-bit
> audio capability": http://en.wikipedia.org/wiki/HDMI#Version_comparison

That page lists the version where a feature was introduced; these are
not requirements.

The HDMI specification says:
| If an HDMI Source supports any HDMI audio transmission, then it shall
| support 2 channel L-PCM ..., with either 32kHz, 44.1kHz or 48kHz
| sampling rate and a sample size of 16 bits or more.  [...]
| An HDMI Sink that is capable of accepting any audio format is required
| to accept two channel ... L-PCM audio at sample rates of 32kHz,
| 44.1kHz, and 48kHz.


Regards,
Clemens
