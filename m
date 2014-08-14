From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [v4 02/12] ASoC: Intel: mrfld: set private data
 for cpu-dai
Date: Thu, 14 Aug 2014 08:16:37 +0200
Message-ID: <53EC5445.6020404@metafoo.de>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
 <53EBC193.9070105@metafoo.de>
 <20140814053637.GA6106@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-210.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB1F26565B
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 08:16:37 +0200 (CEST)
In-Reply-To: <20140814053637.GA6106@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 08/14/2014 07:36 AM, Subhransu S. Prusty wrote:
> On Wed, Aug 13, 2014 at 09:50:43PM +0200, Lars-Peter Clausen wrote:
>> [...]
>>> +static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
>>> +{
>>> +	struct sst_data *sst = dev_get_drvdata(cpu_dai->dev);
>>> +
>>> +	snd_soc_dai_set_drvdata(cpu_dai, sst);
>>
>> snd_soc_dai_set_drvdata does dev_set_drvdata(dai->dev, data)
>> internally, so this function does:
>>
>> 	dev_set_drvdata(cpu_dai->dev, dev_get_drvdata(cpu_dai->dev));
>>
>> That's pretty much a noop.
>>
>
> Agree. Intention was to use snd_soc_dai_* API. Anyway will remove and use
> dev_get_drvdata(dai->dev) directly.
>

It's totally fine to use snd_soc_dai_get_drvdata() through the driver. It's 
just that this probe function does nothing and can be removed.
