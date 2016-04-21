From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 1/4] ASoC: Export snd_soc_find_dai()
Date: Thu, 21 Apr 2016 14:55:25 +0800
Message-ID: <5718795D.2080303@linux.intel.com>
References: <cover.1461042239.git.mengdong.lin@linux.intel.com>
 <5e7147f76b2c54d2d23eb1f6a1146a3716bd5172.1461042239.git.mengdong.lin@linux.intel.com>
 <20160420161226.GN3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 712F32604DF
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:52:39 +0200 (CEST)
In-Reply-To: <20160420161226.GN3217@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 04/21/2016 12:12 AM, Mark Brown wrote:
> On Tue, Apr 19, 2016 at 01:12:25PM +0800, mengdong.lin@linux.intel.com wrote:
>
>>   }
>>
>> -static struct snd_soc_dai *snd_soc_find_dai(
>> +struct snd_soc_dai *snd_soc_find_dai(
>>   	const struct snd_soc_dai_link_component *dlc)
>>   {
>>   	struct snd_soc_component *component;
>> @@ -959,6 +959,7 @@ static struct snd_soc_dai *snd_soc_find_dai(
>>
>>   	return NULL;
>>   }
>> +EXPORT_SYMBOL_GPL(snd_soc_find_dai);
>
> Can you please add a kerneldoc comment as well since this is getting
> exported?
>

Okay, I'll do this. Thanks for your reminding.

Regards
Mengdong
