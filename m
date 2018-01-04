From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5645: add fallback case for jack
 detection support
Date: Thu, 4 Jan 2018 09:15:19 -0600
Message-ID: <a3b2eeea-40da-ae40-af01-46d6002d56de@linux.intel.com>
References: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
 <6b845088-9900-789c-1137-811321e23252@redhat.com>
 <20180104115918.GB10774@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F6622678B8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 16:15:22 +0100 (CET)
In-Reply-To: <20180104115918.GB10774@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vinod.koul@intel.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 1/4/18 5:59 AM, Mark Brown wrote:
> On Wed, Jan 03, 2018 at 11:20:38PM +0100, Hans de Goede wrote:
> 
>>> +	else if (rt5645_check_dp(&i2c->dev))
>>>    		rt5645_parse_dt(rt5645, &i2c->dev);
>>> +	else
>>> +		rt5645->pdata = jd_mode3_platform_data;
> 
>> How about:
> 
>> 		rt5645->pdata.jd_mode = 3;
> 
>> instead and remove jd_mode3_platform_data and the 2 dmi table entries
>> pointing to it ?
> 
> I'm not sure it's best practice to remove the entries that have been
> explicitly added; on the other hand if the default is jd_mode = 3 then
> it's not like we'll be adding any more.

Yes, I didn't want to remove existing quirks since I can't test for 
non-regressions on those devices. We will most likely have to add new 
quirks for the capture part, there is a large variability in how the 
analog inputs are handled. The jd_mode3 default will help mostly 
identify if the device is functional out-of-the-box on the playback side 
(the speaker part relies on a separate amplifier so it's hit or miss).

I will resubmit a patch with a clearer commit message, indeed there is 
no harm in reading non-existent properties. What I meant is that their 
absence can be used as a signal to use the default.
Thanks for the quick feedback.
-Pierre
