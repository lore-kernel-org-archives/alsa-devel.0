From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 1/8] ASoC: Intel: Skylake: fix widget
	handling
Date: Wed, 25 Jul 2018 09:04:48 -0500
Message-ID: <8f35758e-1592-cf0f-832c-cc358a7b2659@linux.intel.com>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-2-pierre-louis.bossart@linux.intel.com>
 <20180725105928.GL3661@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AAA752675D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 16:06:58 +0200 (CEST)
In-Reply-To: <20180725105928.GL3661@vkoul-mobl>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 7/25/18 5:59 AM, Vinod wrote:
> On 24-07-18, 19:50, Pierre-Louis Bossart wrote:
>> From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>>
>> include DAPM Mux and output widgets into the list.
> 
> Pierre,
> 
> Curious how is this a fix?

This is Skylake-specific topology black magic that you are probably 
better equiped to understand that me... This just takes out the outputs 
and mux from a number of topology handling cases.

> 
>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/skylake/skl-topology.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
>> index 76dde12cc2bb..2620d77729c5 100644
>> --- a/sound/soc/intel/skylake/skl-topology.c
>> +++ b/sound/soc/intel/skylake/skl-topology.c
>> @@ -108,6 +108,9 @@ static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w,
>>   	case snd_soc_dapm_aif_out:
>>   	case snd_soc_dapm_dai_out:
>>   	case snd_soc_dapm_switch:
>> +	case snd_soc_dapm_output:
>> +	case snd_soc_dapm_mux:
>> +
>>   		return false;
>>   	default:
>>   		return true;
>> -- 
>> 2.14.1
> 
