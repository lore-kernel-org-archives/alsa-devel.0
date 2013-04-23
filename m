From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoc: spdif_transciever: Add DT support
Date: Tue, 23 Apr 2013 16:02:10 +0200
Message-ID: <CABJ1b_RpuVxq7M-QZyr20b3kT77Ob5hmC-nbKsZvPC2dR9uBQg@mail.gmail.com>
References: <1366378725-14471-1-git-send-email-michal.bachraty@streamunlimited.com>
	<5171808B.1010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5171808B.1010209@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, perex@perex.cz, marek.belisko@streamunlimited.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 19, 2013 at 7:36 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Michal,
>
> On 19.04.2013 15:38, Michal Bachraty wrote:
>> Add devicetree support for this dummy audio soc driver.
>
> I think Mark wants to see only "ASoC:" in the patch subjects now.
>
>>
>> Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
>> ---
>>  sound/soc/codecs/spdif_transciever.c |   10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
>> index 112a49d..4c8c295 100644
>> --- a/sound/soc/codecs/spdif_transciever.c
>> +++ b/sound/soc/codecs/spdif_transciever.c
>> @@ -20,6 +20,7 @@
>>  #include <sound/soc.h>
>>  #include <sound/pcm.h>
>>  #include <sound/initval.h>
>> +#include <linux/of.h>
>>
>>  #define DRV_NAME "spdif-dit"
>>
>> @@ -52,12 +53,21 @@ static int spdif_dit_remove(struct platform_device *pdev)
>>       return 0;
>>  }
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id spdif_dit_dt_ids[] = {
>> +     { .compatible = DRV_NAME, },
>
> I think this needs a "linux," prefix. Just put the whole string here.

Michal,

I suggest to also rename spdif_transceiver to spdif_transmitter, as
"transceiver"
usually do both "transmit" and "receive". I don't know who made up the current
name, but the driver is definitely a transmitter.

Sebastian
