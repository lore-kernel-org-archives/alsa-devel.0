From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Fri, 08 May 2015 14:05:56 -0500
Message-ID: <554D0914.2040404@linux.intel.com>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <20150507125142.GW15510@sirena.org.uk> <554BAED7.4080705@linux.intel.com>
 <20150507183629.GM22845@sirena.org.uk> <554CBA8C.4080909@linux.intel.com>
 <20150508164633.GA2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C7A3B260547
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 21:06:00 +0200 (CEST)
In-Reply-To: <20150508164633.GA2761@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 5/8/15 11:46 AM, Mark Brown wrote:
> On Fri, May 08, 2015 at 08:30:52AM -0500, Pierre-Louis Bossart wrote:
>
>> Agree, but there wasn't a clear message provided to the readers of this
>> mailing list. A 'should' is a recommendation that provides no real incentive
>> to move to the new gpiod framework. The message would be clearer if
>> maintainers stated that new contributions using of_get_named_gpio() will no
>> longer be merged in the mainline (maybe after a specific milestone). That
>> would set the direction for everyone.
>
> That's what's been happening...

We are in agreement. I wasn't trying to argue but make sure everyone 
noticed this change. I saw a commit with of_get_named_gpio in sound/soc 
as recent as December 30, 2014 and we talked to 3rd parties unaware of 
this change. Now they are :-)
