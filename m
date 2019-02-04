From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 2/2] ASoC: dapm: harden use of lookup
 tables
Date: Mon, 4 Feb 2019 15:18:28 -0600
Message-ID: <0390e337-3f8a-3a57-98de-8d5edb8266ff@linux.intel.com>
References: <20190204202710.14547-1-pierre-louis.bossart@linux.intel.com>
 <20190204202710.14547-2-pierre-louis.bossart@linux.intel.com>
 <s5hbm3rfg7s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id A36EB267459
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 22:18:31 +0100 (CET)
In-Reply-To: <s5hbm3rfg7s.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


>> +	WARN_ONCE(ARRAY_SIZE(dapm_up_seq) != SND_SOC_DAPM_TYPE_LAST,
>> +		  "bad size for dapm_up_seq, expected %d\n",
>> +		  SND_SOC_DAPM_TYPE_LAST);
>> +
>> +	WARN_ONCE(ARRAY_SIZE(dapm_down_seq) != SND_SOC_DAPM_TYPE_LAST,
>> +		  "bad size for dapm_down_seq, expected %d\n",
>> +		  SND_SOC_DAPM_TYPE_LAST);
> Would BUILD_BUG_ON() work for these instead?
> It's not available, but if it works, better than the runtime check.

I misunderstood your earlier email then. I also felt testing a constant 
all the time wasn't necessarily very optimal, but since you mentioned 
WARN I used it for all cases.

Are you saying use WARN_ONCE for the uninitialized values and 
BUILD_BUG_ON for the array size check?

Thanks!
