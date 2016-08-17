From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: Skylake: Add token
 support for topology data
Date: Wed, 17 Aug 2016 14:59:28 +0800
Message-ID: <57B40B50.8000105@linux.intel.com>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
 <20160812104107.GB9347@sirena.org.uk> <20160812105531.GL9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EF5D2654CD
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 08:53:41 +0200 (CEST)
In-Reply-To: <20160812105531.GL9681@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, liam.r.girdwood@linux.intel.com, Mengdong <mengdong.lin@intel.com>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 08/12/2016 06:55 PM, Vinod Koul wrote:
> On Fri, Aug 12, 2016 at 11:41:07AM +0100, Mark Brown wrote:
>> On Fri, Aug 12, 2016 at 12:29:49PM +0530, Vinod Koul wrote:
>>> With topology changes in alsa-lib, driver data for modules can now be
>>> passed in topology conf file using tuples.
>>>
>>> These changes allow private data to represented by tuples of type UUID,
>>> byte, short, word and strings.
>>
>> A question I ask quite often: the topology code has been in mainline
>> since v4.2 but still has a big old #error at the top preventing any
>> actual use from userspace.  We're now more than a year after the code
>> was originally merged and still no patches to actually make this ABI
>> usable from userspace.  Where are we at with that?
>
> Mengdong was working on last set of features for providing DAIlinks. After
> that we dont have any more updates planned on topology API.

There will be 2 more series to bring some topology ABI update. The code 
is ready and verified. And we will not modify ABI to break backward 
compatibility after this.

>
> So I think we cna remove it for current cycle. Mengdong cna you please
> confirm..

I think we may remove those #error after this cycle of upstreaming. 
We'll resume the patch upstreaming this week.

Thanks
Mengdong
