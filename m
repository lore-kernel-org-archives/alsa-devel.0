From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 07/13] soundwire: Add stream
 configuration APIs
Date: Fri, 6 Apr 2018 10:28:00 -0500
Message-ID: <8bb8a892-1889-c5a1-d5c8-c0529ce90e08@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-8-git-send-email-vinod.koul@intel.com>
 <06b35225-232a-7220-ffda-e42b5c6c9366@linux.intel.com>
 <20180406084851.GJ6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 84B3F266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 17:28:03 +0200 (CEST)
In-Reply-To: <20180406084851.GJ6014@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/6/18 3:48 AM, Vinod Koul wrote:
> On Thu, Apr 05, 2018 at 06:40:20PM -0500, Pierre-Louis Bossart wrote:
> 
>>> +int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (!stream) {
>>> +		pr_err("SoundWire: Handle not found for stream");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mutex_lock(&stream->m_rt->bus->bus_lock);
>>> +
>>> +	if (stream->state == SDW_STREAM_DISABLED)
>>> +		goto error;
>>> +
>>> +	if (stream->state != SDW_STREAM_CONFIGURED) {
>>> +		ret = -EINVAL;
>>> +		goto error;
>>> +	}
>>
>> this seems to be a new pattern in this file.
>> Why is the first test even needed?
> 
> Looking it again, the state transition is from CONFIGURED, so the first
> check is not required and will be removed.
> 
>>> +int sdw_enable_stream(struct sdw_stream_runtime *stream)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (!stream) {
>>> +		pr_err("SoundWire: Handle not found for stream");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mutex_lock(&stream->m_rt->bus->bus_lock);
>>> +
>>> +	if (stream->state == SDW_STREAM_ENABLED)
>>> +		goto error;
>>> +
>>> +	if ((stream->state != SDW_STREAM_PREPARED) &&
>>> +		(stream->state != SDW_STREAM_DISABLED)) {
>>> +		ret = -EINVAL;
>>> +		goto error;
>>> +	}
>>
>> same here, why would you enable a stream that's already enabled? Why is this
>> an error that returns 0?
> 
> So first, we think stream should not be enabled if it is already enabled.
> The code right now doesnt treat it as error, but we should so will fix it
> up...
> 

ok

>>> +int sdw_disable_stream(struct sdw_stream_runtime *stream)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (!stream) {
>>> +		pr_err("SoundWire: Handle not found for stream");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mutex_lock(&stream->m_rt->bus->bus_lock);
>>> +
>>> +	if (stream->state == SDW_STREAM_DISABLED)
>>> +		goto error;
>>> +
>>> +	if (stream->state != SDW_STREAM_ENABLED) {
>>> +		ret = -EINVAL;
>>> +		goto error;
>>> +	}
>>
>> and here to.
> 
> yup, here too :)
> 
