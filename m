From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Thu, 07 May 2015 13:28:39 -0500
Message-ID: <554BAED7.4080705@linux.intel.com>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <20150507125142.GW15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F7CE265A08
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 20:28:39 +0200 (CEST)
In-Reply-To: <20150507125142.GW15510@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 5/7/15 7:51 AM, Mark Brown wrote:
> On Thu, May 07, 2015 at 05:34:27AM +0000, Bard Liao wrote:
>
>>>> We should really be using device_property_() instead of of_property_()
>>>> APIs since we will have to support both DT and ACPI properties.
>
>> Unfortunately, I can't find a way to test it.
>
> Why can't you test it - weren't you testing your original version of the
> code?

You can test it on an platform using device tree, the device_property_ 
code will fetch the same information as before.
If you want to test on an ACPI platform, I can help with some examples 
(off-list) showing how to override the DSDT table and to add those 
properties in an ASL device entry. You may not be able to test all the 
configurations but at least you can add basic checks that show the data 
is passed from ACPI to your driver. I used all this stuff for a proof of 
concept on AsusT100 where the audio routing in the machine driver is 
passed from ACPI.

>
>> Is that ok we just replace all of_property_ with device_property_?
>> Also, is there any corresponding API for of_get_named_gpio?
>> Or we can replace it with device_property_read_u32?
>> I tried the change above, and it can build. However I don't know
>> if it can work.
>
> You shouldn't be using of_get_named_gpio() for DT stuff either, use
> gpiod_get() which follows the usual pattern of taking a string which is
> used to do the lookup with whatever firmware is in use.

But to Bard's credit the use of_get_named_gpio() is pretty common - i 
see 18 occurrences in soc/codecs alone, others will have the same 
problem...
we talked internally (RafaelW, Darren Hart, LiamG and me) about reaching 
out to gpio and audio maintainers and aligning some sort of coordinated 
change to the gpiod framework w/ guidance to developers, did that thread 
start?
