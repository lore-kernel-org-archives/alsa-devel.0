From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Fri, 08 May 2015 08:30:52 -0500
Message-ID: <554CBA8C.4080909@linux.intel.com>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <20150507125142.GW15510@sirena.org.uk> <554BAED7.4080705@linux.intel.com>
 <20150507183629.GM22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2144B265D26
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 15:30:53 +0200 (CEST)
In-Reply-To: <20150507183629.GM22845@sirena.org.uk>
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

On 5/7/15 1:36 PM, Mark Brown wrote:
> On Thu, May 07, 2015 at 01:28:39PM -0500, Pierre-Louis Bossart wrote:
>> On 5/7/15 7:51 AM, Mark Brown wrote:
>
>>> You shouldn't be using of_get_named_gpio() for DT stuff either, use
>>> gpiod_get() which follows the usual pattern of taking a string which is
>>> used to do the lookup with whatever firmware is in use.
>
>> But to Bard's credit the use of_get_named_gpio() is pretty common - i see 18
>> occurrences in soc/codecs alone, others will have the same problem...
>> we talked internally (RafaelW, Darren Hart, LiamG and me) about reaching out
>> to gpio and audio maintainers and aligning some sort of coordinated change
>> to the gpiod framework w/ guidance to developers, did that thread start?
>
> I'm not sure there's any particular need for coordination here, the APIs
> are in place already - the gpiod_ APIs will already transparently look
> up both ACPI and DT (see __gpiod_get_index() for the implementation) and
> new drivers should really be using gpiod_ anyway regardless of trying to
> do both ACPI and DT.

Agree, but there wasn't a clear message provided to the readers of this 
mailing list. A 'should' is a recommendation that provides no real 
incentive to move to the new gpiod framework. The message would be 
clearer if maintainers stated that new contributions using 
of_get_named_gpio() will no longer be merged in the mainline (maybe 
after a specific milestone). That would set the direction for everyone.
