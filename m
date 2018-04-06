From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 10/13] soundwire: cdns: Add port routines
Date: Fri, 6 Apr 2018 10:29:11 -0500
Message-ID: <15eaa926-ecf8-0185-ed58-bbc4dcc6c521@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-11-git-send-email-vinod.koul@intel.com>
 <cc86f00d-dcf8-6609-ba01-f97ec69807d1@linux.intel.com>
 <20180406085524.GL6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A49266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 17:29:13 +0200 (CEST)
In-Reply-To: <20180406085524.GL6014@localhost>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 4/6/18 3:55 AM, Vinod Koul wrote:
> On Thu, Apr 05, 2018 at 07:19:43PM -0500, Pierre-Louis Bossart wrote:
>> On 4/5/18 11:48 AM, Vinod Koul wrote:
> 
>>> +static int cdns_allocate_pdi(struct sdw_cdns *cdns,
>>> +			struct sdw_cdns_pdi **stream,
>>> +			u32 start, u32 num, u32 pdi_offset)
>>
>> the start parameter doesn't seem to be used, remove and remove the useless
>> zeroes in all the calls to this routine?
> 
> Yes this seems to be the case, will fix
> 
>>> +
>>> +pdm_error:
>>> +	kfree(stream->bd);
>>> +	kfree(stream->in);
>>> +	kfree(stream->out);
>>> +
>>> +pcm_error:
>>> +	stream = &cdns->pcm;
>>> +	kfree(stream->bd);
>>> +	kfree(stream->in);
>>> +	kfree(stream->out);
>>
>> call me a grumpy old fart if you want, I still don't like people freeing
>> memory they never allocated. It may be legal but it's sloppy.
> 
> Actually looking at it freeing is not required as we are doing devm_
> allocations, so this can be removed and return error should do the trick and
> we propagate the error and cleanup, thanks for the catch

sounds good.
