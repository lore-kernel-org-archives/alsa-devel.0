From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add FE DAIs
 dynamically
Date: Tue, 16 Feb 2016 14:22:52 +0800
Message-ID: <56C2C03C.2060203@linux.intel.com>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
 <b7e208201542e5a27d052eb9e9f780056542db03.1452844210.git.mengdong.lin@linux.intel.com>
 <56A89457.4040307@metafoo.de> <20160215193542.GA18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3662607E9
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 07:21:48 +0100 (CET)
In-Reply-To: <20160215193542.GA18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


On 02/16/2016 03:35 AM, Mark Brown wrote:
> On Wed, Jan 27, 2016 at 10:56:39AM +0100, Lars-Peter Clausen wrote:
>> On 01/15/2016 09:13 AM, mengdong.lin@linux.intel.com wrote:
>> [...]
>>> +		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
>>> +							caps->rate_max);
>
>> How about just setting stream->rate_min and stream->rate_max?
>
> I'll apply this but please send a followup patch fixing this.
>

I've sent out a patch to fix this:
[PATCH] ASoC: topology: Fix setting of stream rates, rate_min and rate_max

Please review and overlook my v3 series which just merged this fix with 
the applied patches.

Thanks
Mengdong
