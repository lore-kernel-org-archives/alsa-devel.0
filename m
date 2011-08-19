From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
 driver
Date: Fri, 19 Aug 2011 15:13:10 +0200
Message-ID: <4E4E6166.30700@metafoo.de>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>	<1313739679-8975-3-git-send-email-peter.ujfalusi@ti.com>
	<4E4E2103.9030208@metafoo.de> <4E4E2384.5000501@metafoo.de>
	<4E4E5958.1070506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id CC4CE10395C
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 15:15:40 +0200 (CEST)
In-Reply-To: <4E4E5958.1070506@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Lopez Cruz,
	Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/19/2011 02:38 PM, Liam Girdwood wrote:
> On 19/08/11 09:49, Lars-Peter Clausen wrote:
>> On 08/19/2011 10:38 AM, Lars-Peter Clausen wrote:
>>> On 08/19/2011 09:41 AM, Peter Ujfalusi wrote:
>>>> From: Misael Lopez Cruz <misael.lopez@ti.com>
>>>>
>>>> Reasons for the replacement:
>>>> The current driver for McPDM was developed to support the legacy mode only.
>>>> In preparation for the ABE support the current driver stack need the be
>>>> replaced.
>>>> The new driver is much simpler, easier to extend, and it also fixes some of the
>>>> issues with the old stack.
>>>>
>>>> Main changes:
>>>> - single file for omap-mcpdm (mcpdm.c/h removed)
>>>> - Define names for registers, bits cleaned up, prefixed
>>>> - Full-duplex audio operation (arecord | aplay) has been fixed
>>>> - Less code
>>>>
>>>> McPDM need to be turned off _after_ the codec's DAC/ADC has been powered down.
>>>> The solution for this without extensive change in core:
>>>> Use DAPM_SUPPLY to turn off the McPDM interface.
>>>> The machine driver connects the "OMAP McPDM Interface" to the codec's DAC/ADC,
>>>> so after audio activity we can be sure that the host side McPDM is turned off
>>>> at the correct time.
>>>>
>>>> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
>>>> Signed-off-by: Liam Girdwood <lrg@ti.com>
>>>> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>>  sound/soc/omap/Makefile     |    2 +-
>>>>  sound/soc/omap/mcpdm.c      |  472 -------------------------
>>>>  sound/soc/omap/mcpdm.h      |  152 --------
>>>>  sound/soc/omap/omap-mcpdm.c |  823 ++++++++++++++++++++++++++++---------------
>>>>  sound/soc/omap/omap-mcpdm.h |   97 +++++
>>>>  sound/soc/omap/sdp4430.c    |   14 +-
>>>>  6 files changed, 655 insertions(+), 905 deletions(-)
>>>>  delete mode 100644 sound/soc/omap/mcpdm.c
>>>>  delete mode 100644 sound/soc/omap/mcpdm.h
>>>>  rewrite sound/soc/omap/omap-mcpdm.c (46%)
>>>>  create mode 100644 sound/soc/omap/omap-mcpdm.h
>>>>
>>>> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
>>>> index 59e2c8d..052fd75 100644
>>>> --- a/sound/soc/omap/Makefile
>>>> +++ b/sound/soc/omap/Makefile
>>>> @@ -1,7 +1,7 @@
>>>>  # OMAP Platform Support
>>>>  snd-soc-omap-objs := omap-pcm.o
>>>>  snd-soc-omap-mcbsp-objs := omap-mcbsp.o
>>>> -snd-soc-omap-mcpdm-objs := omap-mcpdm.o mcpdm.o
>>>> +snd-soc-omap-mcpdm-objs := omap-mcpdm.o
>>>>  snd-soc-omap-hdmi-objs := omap-hdmi.o
>>>>  
>>>>  obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
>>>> diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
>>>> deleted file mode 100644
>>>> index 9746a49..0000000
>>>> --- a/sound/soc/omap/mcpdm.c
>>>> +++ /dev/null
>>>> @@ -1,472 +0,0 @@
>>>> [...]
>>>> +static int omap_mcpdm_interface_event(struct snd_soc_dapm_widget *w,
>>>> +		struct snd_kcontrol *kcontrol, int event)
>>>> +{
>>>> +	struct omap_mcpdm *mcpdm = w->private_data;
>>>
>>> Can't you use
>>> struct omap_mcpdm *mcpdm = snd_soc_codec_get_drvdata(codec)?
>>
>> sorry:
>> struct omap_mcpdm *mcpdm =  snd_soc_platform_get_drvdata(w->platform);
>>
>>
>>>
>>> This would avoid having to add the private_data field to the widget struct. In
>>> it's current form it will only really work, if there is just one instance of
>>> the driver using the widget. And if that's the case you can use a global
>>> variable directly anyway.
> 
> This wont work as the McPDM DAI is neither a codec or a platform driver. It's best to give the widgets some private data since we may have other uses for it too.
> 
oops, sorry. I somehow though this was a platform driver, don't know why. But
still the way you use private_data in this driver, you use it to cleverly hide
a global variable.

The whole thing is sort of a hack.  I mean, if it turns out that we want DAPM
on the SoC DAI side, we should probably give it is own DAPM context, instead of
using the cards context for this.

- Lars
