From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 07/13] soundwire: Add stream
 configuration APIs
Date: Mon, 23 Apr 2018 08:30:47 -0500
Message-ID: <cf20c1f6-0804-70df-0f2d-6ad670481321@linux.intel.com>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-8-git-send-email-vinod.koul@intel.com>
 <bca948a4-a668-73d0-5e6d-63287a21a636@linux.intel.com>
 <20180421161315.GO6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 70B9B266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 15:30:54 +0200 (CEST)
In-Reply-To: <20180421161315.GO6014@localhost>
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


>>> +
>>> +	if (!bus->params.bandwidth) {
>>> +		bus->params.row = 0;
>>> +		bus->params.col = 0;
>>> +		goto exit;
>>
>> What is the intent with this test+goto? Shouldn't you program the parameters
>> if you want to change the frame shape?
> 
> hmmm that seems correct point to me, but then we are going idle and should
> ideally power down. Let me check again if that is the reason.

what about clock stop? what about the default frame shape specified in 
the DisCo spec? I don't see the reason why we'd go to 48x2 - especially 
on Intel platforms where we'll typically use  50x2 to remain aligned 
with a 48kHz frame rate.
