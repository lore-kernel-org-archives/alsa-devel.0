From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] ASoC: core: Change power state before
 rechecking endpoint
Date: Mon, 23 Nov 2015 19:13:12 +0100
Message-ID: <56535738.1000802@metafoo.de>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
 <1448293951-32071-4-git-send-email-vinod.koul@intel.com>
 <56533991.8000601@metafoo.de> <20151123172825.GU25173@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-151.synserver.de
 [212.40.185.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D5B2654C6
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 19:13:18 +0100 (CET)
In-Reply-To: <20151123172825.GU25173@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On 11/23/2015 06:28 PM, Vinod Koul wrote:
> On Mon, Nov 23, 2015 at 05:06:41PM +0100, Lars-Peter Clausen wrote:
>> On 11/23/2015 04:52 PM, Vinod Koul wrote:
>>> From: Jeeja KP <jeeja.kp@intel.com>
>>>
>>> For DAPM resume, we should first change the power state of the
>>> card and then recheck the endpoints. This ensures the dapm is
>>> resumed first and then userspace can resume the streams.
>>
>> The problem is that DAPM uses the userspace state to decide whether to power
>> up or not. So this change won't work, it will keep the endpoints suspended.
> 
> Well our observation are bit different...
> 
> When testing with aplay and suspending the system the DAPM was suspending
> fine and then alsa suspends PCMs, but on resume the DAPM is resumed last and
> the PCMs first, due to which the devices start underun!
> The DAPM should be resumed first and then we should allow userspace access
> (PCM resume from aplay)
> 
> The change of order here helps in that

Sorry, overlooked something. We go to D2 earlier on and DAPM only is
suspended when the state is D3 and not only when it is not in D0.

Patch looks good.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
