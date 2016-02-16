From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add FE DAIs
 dynamically
Date: Tue, 16 Feb 2016 13:35:09 +0800
Message-ID: <56C2B50D.4090907@linux.intel.com>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
 <b7e208201542e5a27d052eb9e9f780056542db03.1452844210.git.mengdong.lin@linux.intel.com>
 <56A89457.4040307@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 39C972655DB
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 06:34:06 +0100 (CET)
In-Reply-To: <56A89457.4040307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: vinod.koul@intel.com, mengdong.lin@intel.com, subhransu.s.prusty@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com
List-Id: alsa-devel@alsa-project.org



On 01/27/2016 05:56 PM, Lars-Peter Clausen wrote:
> On 01/15/2016 09:13 AM, mengdong.lin@linux.intel.com wrote:
> [...]
>> +		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
>> +							caps->rate_max);
>
> How about just setting stream->rate_min and stream->rate_max?
>
> - Lars

Yes, we can directly set the stream's rates, rate_min and rate_max from 
the topology caps. I revised this as you suggested in v3.

Sorry for the late reply. I'm just back from a two weeks CNY holiday.

Thanks
Mengdong
