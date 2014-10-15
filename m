From: Andrej Falout <andrej@falout.org>
Subject: Re: Direct Stream Digital (DSD/DST,
	One Bit Audio) HDMI pass-trough
Date: Wed, 15 Oct 2014 16:30:07 +1300
Message-ID: <CAGzU1+ERCK+nA2F9tXdR18ZQU=RJ1cUwzF3hRkDTHgc1sGd33A@mail.gmail.com>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>
 <543C58AC.9000701@linux.intel.com>
 <CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>
 <543D369E.5020002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 360CC260458
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 05:30:08 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id ge10so289056lab.38
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 20:30:07 -0700 (PDT)
In-Reply-To: <543D369E.5020002@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Pierre-Louis,

On Wed, Oct 15, 2014 at 3:43 AM, Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

> On 10/13/14, 7:49 PM, Andrej Falout wrote:
>
>>
>> What are you basing your assessment that "HDMI controllers typically
>> don't support DSD in the PC space"? I looked, but could not find any
>> evidence for this.
>>
>
> I am basing my judgement on first-hand experience with silicon.
>

Me too :) Absolutely every HDMI related chip I examined specs for and
tested, including the cheapest of the cheap ones made as HDMI repeaters for
splitters and audio extractors, supported DSD stream passing (Both up and
down stream), just as they did all other audio bitstreams.

For example:
http://www.mds.com/system/resources/BAhbBlsHOgZmSSIuMjAxMy8xMC8xNi8xNy8yOS80NS80MjYvSFNSX0hTX3Jldl81ZC5wZGYGOgZFVA/HSR-HS_rev_5d.pdf

Can you please point out a specification or other document that say
otherwise?


>
>  Certainly, DSD is not a part of HDMI hardware implementation (such as
>> for example, CEC). From all info I have, DSD is simply multiplexed into
>> HDMI data stream, just as DST-HD or AC3 is.
>>
>
> This multiplexing is typically not implemented - mainly because this isn't
> a format used outside of niche markets


It seems that you are talking about coding/decoding, not bitstream
multiplexing? Same TMDS stream multiplexing is used for all audio streams
in HDMI - weather native (PCM/DSD) or encoded (AC3, DTS, ...) The only real
difference that I can see is the stream setup as described in my OP ("Table
47 CEA Short Audio Descriptor for Audio Format Codes 9 to 13", (eg setting
the format code, bittness, etc))


> and there was no real format to convey DSD over PCM frames until the DOP
> format was created in 2012.


Again, I am talking about native DSD formats/streams, not DoP - which is in
essence PCM. HDMI specs do not know or need DoP. HDMI is capable of native
DSD transfer since version 1.2. See point #5 in my OP.


> DTS-HD and AC3 use a PCM format which is rather straightforward to
> implement but there's quite a few cases where these modes have been
> dropped.


As you say, these are rather straightforward to implement, as evident from
the HDMI specification which describes the stream setup. Same specification
also described DSD stream setup, which is is essence exactly the same, just
uses the different identifiers. (CEA Standard PDF, page 66, table 47. HDMI
specs version 1.3a, pages 72-73 for DSD(One Bit Audio) and DST audio packet
header and body formats)

Can you point out a documented case where "these modes have been dropped"?


> HDMI only requires 48kHz 2ch really.
>

Even the HDMI version 1 requires "8 channel LPCM
<http://en.wikipedia.org/wiki/Linear_pulse_code_modulation>, 192 kHz
<http://en.wikipedia.org/wiki/Hertz>, 24-bit audio capability" :
http://en.wikipedia.org/wiki/HDMI#Version_comparison


> Note that the facts don't mean any negative judgement on quality, i was at
> AES this week-end where I heard outstanding DSD/DXD recordings. You will
> have more luck with a USB DAC, there are multiple USB DSD products
> available.


There is about 30 million DSD capable DACs in the world today,
conservatively speaking, most of them multi-channel capable (See point #3
in my OP). I appreciate that there are a few USB DSD DACs out there too,
and even 2 (two) multi-channel models. ;)

Thanks,
Andrej Falout
