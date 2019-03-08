From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 20:54:03 +0100
Message-ID: <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF1B9F806F7
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 20:54:08 +0100 (CET)
In-Reply-To: <20190308172235.GA31189@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 08. 03. 19 v 18:22 Mark Brown napsal(a):
> On Fri, Mar 08, 2019 at 12:59:16PM +0000, Russell King - ARM Linux admin wrote:
>> On Fri, Mar 08, 2019 at 01:10:57PM +0900, Takashi Sakamoto wrote:
> 
>>> In expectation of ALSA PCM interface for hardware for usual device:
>>>  - half number of phases of SCK per phase of WC
>>>    = physical_width of sample
>>>    = bytes per sample
> 
>> They are not the same thing.
> 
>> Let's take SNDRV_PCM_FORMAT_S16_LE.  The in-memory layout of this format
>> is two 16-bit samples next to each other in a single 32-bit word.  Their
>> width is 16, their physical_width is 16, and bytes per sample is 2.
> 
>> A CPU DAI can do one of two things:
> 
>> 1) it can generate exactly 16 SCK clock cycles per sample before WS
>>    changes state, leading to a total of 32 SCK clock cycles per
>>    frame.
> 
>> 2) it can generate more than 16 SCK clock cycles per sample.
> 
>> Both are entirely legal and permissable under the I2S specification.
>> Both look the same in memory.
> 
>> The ALSA format specification (SNDRV_PCM_FORMAT_*) does not specify
>> which of these two is used on the wire - it only specifies the in-
>> memory format.
> 
> Everything Russell is saying here is correct.  The actual
> ABI only affects the in memory format, userspace really shouldn't care
> what's going on on the wire.  However we don't have separate
> infrastructure for what goes on the wire and 90% of the time you can
> just translate the memory layout into a wire layout which works so we're
> conflating the two in a lot of places internally which is confusing and
> fragile.

I agree. We just need a library which will:

1) gather the information from hardware drivers
  - a simple description of the bclk constrains
2) create right constraints (hw_params rules) for the ALSA PCM API
3) return the selected bclk when hw_params are installed

The description of the bclk constraints from the hardware driver might
be min/max or a list of allowed wire format bit width * channels,
eventually define the wire formats (bitmask) and use them in this
library. I can imagine that all of those bclk contraints descriptions
(or any future, if there are such requirement) can be implemented in
this library.

The library should not extend hw_params (new interval), but it should
work as a separate layer - use new structures / functions etc.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
