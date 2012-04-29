From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: Required/preferred multichannel order for ALSA
Date: Sat, 28 Apr 2012 22:23:36 -0500
Message-ID: <4F9CB438.6050002@ti.com>
References: <4F99BF45.4020909@ti.com> <1335518497.4150.6.camel@odin>
	<s5hobqdweyg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 64C29247FC
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2012 05:23:43 +0200 (CEST)
In-Reply-To: <s5hobqdweyg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Castaneda Gonzalez, Axel" <x0055901@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ujfalusi <peter.ujfalusi@ti.com>, "Guiriec,  Sebastien" <s-guiriec@ti.com>, Peter@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Thanks to everyone for replying!
On 04/27/2012 07:12 AM, Takashi Iwai wrote:
> At Fri, 27 Apr 2012 10:21:37 +0100,
> Liam Girdwood wrote:
>>
>> On Thu, 2012-04-26 at 16:33 -0500, Ricardo Neri wrote:
>>> Hi Takashi, list,
>>>
>>> I am implementing multichannel support for HDMI on Texas Instruments'
>>> OMAP4. I would like to know if ALSA mandates a specific channel order or
>>> has a preferred one.
>>>
>>> I tried to find some guidance in alsa-lib or in the alsa driver. All I
>>> could find is the order described in speaker-test:
>>> FL/FR/RL/RR/C/LFE/SL/SR. This order seems to be in use due to historical
>>> reasons [1]. It was also mentioned that an API to set/get the channel
>>> mapping was going to be implemented [2]; I tried to find it without
>>> success. As [1] and [2] are very old posts, I was wondering if the
>>> situation has changed.
>>>
>>> My question arises from the fact that HDMI audio uses the channel
>>> ordering defined in CEA-861 section 6.6.2, which is different from what
>>> speaker-test expects. This also different from the order that SMPTE 320M
>>> specifies. OMAP4 is able to alter the channel mapping, so I could match
>>> what ALSA expects if such required/preferred order exists.
>>>
>>> Thanks in advance for your comments.
>>>
>>> Ricardo
>>>
>>>
>>> [1].http://www.spinics.net/lists/alsa-devel/msg24444.html
>>> [2].http://www.spinics.net/lists/alsa-devel/msg24495.html
>>
>> A lot of hardware now can remap channels to suit the use case so it
>> would probably be good to have an ALSA API to get/set the mappings.
>>
>> This seems like it would be a good subject for the BoF.
>
> Yes.  As I added to LPC 2012 wiki page, it's a topic I'd like to
> discuss in the audio microconf, too.  It's a long-standing issue,
> not only for embedded devices but also PCs, especially with HDMI/DP.
>
> Actually I've had a few different (partial) implementations, but
> nothing was so convincing yet.
>
> BTW, for the time being, the remapping itself is done in alsa-lib
> route plugin.  This works when the driver is unique and supports
> only a single configuration.  Then you can define the routing table
> beforehand.  Take a look at alsa-lib/src/conf/cards/*.conf based on
> old AC97 codecs.

Thanks for the advice! I could remap the channels succesfully with the 
alsa-lib route plugin. It increased the CPU usage when using 
speaker-test, though; from 2% to ~5%, according to top. I guess this is 
acceptable for now.
>
> OTOH, if the driver is generic (e.g. HD-audio) and supports different
> configurations, it doesn't work so easily.  A more generic API is
> mandatory in such a case.

Maybe I can statically remap the channels in the driver to align with 
speaker-test and post in omappedia how to remap if someone needs to. 
This in case their HDMI sinks supports a different HDMI layout.

Thanks!

Ricardo
>
>
> Takashi
