From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 33/40] soundwire: intel: Add basic power
 management support
Date: Fri, 26 Jul 2019 09:57:06 -0500
Message-ID: <41f71476-4205-7982-9422-5d00e55c24d3@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-34-pierre-louis.bossart@linux.intel.com>
 <0e439b41-503d-7ffb-827f-422d63e439eb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e439b41-503d-7ffb-827f-422d63e439eb@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 5:50 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> +static int intel_resume(struct device *dev)
>> +{
>> +    struct sdw_intel *sdw;
>> +    int ret;
>> +
>> +    sdw = dev_get_drvdata(dev);
>> +
>> +    ret = intel_init(sdw);
>> +    if (ret) {
>> +        dev_err(dev, "%s failed: %d", __func__, ret);
>> +        return ret;
>> +    }
>> +
>> +    sdw_cdns_enable_interrupt(&sdw->cdns);
>> +
>> +    return ret;
>> +}
>> +
>> +#endif
> 
> Suggestion: the local declaration + initialization via dev_get_drvdata() 
> are usually combined.

yes, will do.

> 
> Given the upstream declaration of _enable_interrupt, it does return 
> error code/ success. Given current flow, if function gets to 
> _enable_interrupt call, ret is already set to 0. Returning 
> sdw_cds_enable_interrupt() directly would both simplify the definition 
> and prevent status loss.

sounds good, will do, thanks!
