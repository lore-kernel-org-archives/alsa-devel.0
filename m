From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 2/4] ASoC: Intel: Add merrifield machine
	driver
Date: Tue, 06 May 2014 20:17:18 +0200
Message-ID: <5369272E.5010803@metafoo.de>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
 <536905CD.4030007@metafoo.de> <20140506165820.GE28638@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 3531C2651AF
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 20:17:23 +0200 (CEST)
In-Reply-To: <20140506165820.GE28638@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/06/2014 06:58 PM, Vinod Koul wrote:
> On Tue, May 06, 2014 at 05:54:53PM +0200, Lars-Peter Clausen wrote:
>> On 05/05/2014 08:01 PM, Vinod Koul wrote:
>> [...]
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/io.h>
>>> +#include <linux/async.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/gpio.h>
>>> +#include <sound/pcm.h>
>>> +#include <sound/pcm_params.h>
>>> +#include <sound/soc.h>
>>> +#include <sound/jack.h>
>>> +#include <linux/input.h>
>>> +
>>> +#include <linux/mfd/wm8994/core.h>
>>> +#include <linux/mfd/wm8994/registers.h>
>>> +#include <linux/mfd/wm8994/pdata.h>
>>> +#include "../../codecs/wm8994.h"
>>> +#include "../platform-libs/controls_v2.h"
>>
>> I don't think that include exists in upstream.
> which one ../platform-libs/controls_v2.h is part of this patch.

I just saw it's part of patch 4 of this series. But still, it should added 
before the user is added.

[..]
>>
>>> +static struct snd_soc_dai *find_codec_dai(struct snd_soc_card *card, const char *dai_name)
>>> +{
>>> +	int i;
>>> +	for (i = 0; i < card->num_rtd; i++) {
>>> +		if (!strcmp(card->rtd[i].codec_dai->name, dai_name))
>>> +			return card->rtd[i].codec_dai;
>>> +	}
>>> +	pr_err("%s: unable to find codec dai\n", __func__);
>>> +	/* this should never occur */
>>> +	WARN_ON(1);
>>> +	return NULL;
>>> +}
>>
>> The proper way to do this is to implement the init callback for the
>> dai link. There you get a pointer to the codec and the dai and
>> everything else. If you need one for later store them in the private
>> struct of the card driver.
> again the driver would need to store the pointers to cards (we multi codec
> systems) and multi dais. Somehow I dont feel this might be worth thr trouble.
> Earlier we always had card->codec pointing to _one_ codec but with multi-codec
> systems that is not the case, so we need ot lookup, but yes am not sure if above
> is best way or something else..

Another thing you could do is just use card->rtd[X].codec_dai. The rtds are 
in the same order as the DAI links so you know which rtd is for which DAI.

[...]
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "DMIC2DAT");
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT1P");
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT1N");
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT2P");
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT2N");
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "IN1RN");
>>> +	snd_soc_dapm_nc_pin(&card->dapm, "IN1RP");
>>
>> Set the fully_routed flag on the card and this will happen automatically.
> I havent looked thos changes up, will this mark as nc asll the unrouted pins?

It will mark any input, output and micbias pin that has no external 
connection as not connected. Which is typically what you want.

- Lars
