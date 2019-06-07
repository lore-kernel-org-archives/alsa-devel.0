From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] next/master boot bisection: next-20190528 on
 sun8i-h3-libretech-all-h3-cc
Date: Fri, 7 Jun 2019 15:08:45 -0500
Message-ID: <6959db6d-1ab4-8f94-7e58-57606b8b42f6@linux.intel.com>
References: <5cef9f66.1c69fb81.39f30.21e8@mx.google.com>
 <s5hr28gszvj.wl-tiwai@suse.de>
 <8ca25787-fc03-7942-0705-3ec7d88862a6@collabora.com>
 <20190607190021.GK2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------00ECFFF18126FC8F2B9D28E7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607190021.GK2456@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Guillaume Tucker <guillaume.tucker@collabora.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, tomeu.vizoso@collabora.com, mgalka@collabora.com, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, "kernelci.org bot" <bot@kernelci.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------00ECFFF18126FC8F2B9D28E7
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/19 2:00 PM, Mark Brown wrote:
> On Fri, Jun 07, 2019 at 05:31:12PM +0100, Guillaume Tucker wrote:
>> On 30/05/2019 16:53, Takashi Iwai wrote:
> 
>>>> +	mutex_lock(&client_mutex);
>>>>   	for_each_rtdcom(rtd, rtdcom) {
>>>>   		component = rtdcom->component;
>>>>   
>>>>   		if (component->driver->remove_order == order)
>>>>   			soc_remove_component(component);
>>>>   	}
>>>> +	mutex_unlock(&client_mutex);
> 
>>> Ranjani, which code path your patch tries to address?  Maybe better to
>>> wrap client_mutex() in the caller side like snd_soc_unbind_card()?
> 
>> Is anyone looking into this issue?
> 
>> It is still occurring in next-20190606, there was a bisection
>> today which landed on the same commit.  There just hasn't been
>> any new bisection reports because they have been temporarily
>> disabled while we fix some issues on kernelci.org.
> 
> I was expecting that Ranjani or one of the other Intel people was
> looking into it...

Ack. We've all been underwater this week and this wasn't addressed, 
sorry about the delay. It's probably wise to revert this commit at this 
point while we look for an alternate solution?

There was an initial proposal submitted on GitHub [1] (patch attached) 
which implemented what Takashi suggested in his comments. This proposal 
was later optimized further, it could be that the optimization was one 
bridge too far.

Could you let us know if this attached patch has any negative effects on 
non-Intel platforms?

Thanks!

[1] 
https://github.com/thesofproject/linux/commit/9fd09dd417bc8be7a4a8bdd1621558151f8d117b

--------------00ECFFF18126FC8F2B9D28E7
Content-Type: text/x-patch;
 name="9fd09dd417bc8be7a4a8bdd1621558151f8d117b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="9fd09dd417bc8be7a4a8bdd1621558151f8d117b.patch"

>From 9fd09dd417bc8be7a4a8bdd1621558151f8d117b Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 22 May 2019 10:52:40 -0700
Subject: [PATCH] ASoC: core: lock client_mutex while removing link components

Removing link components results in topology unloading. So,
acquire the client_mutex before removing components in
snd_soc_unbind_card(). This will prevent lockdep warning
when the dai link is removed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2403bec2fccf3..5609398f05d80 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2839,12 +2839,14 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
 
+		mutex_lock(&client_mutex);
 		/* remove all components used by DAI links on this card */
 		for_each_comp_order(order) {
 			for_each_card_rtds(card, rtd) {
 				soc_remove_link_components(card, rtd, order);
 			}
 		}
+		mutex_unlock(&client_mutex);
 
 		soc_cleanup_card_resources(card);
 		if (!unregister)

--------------00ECFFF18126FC8F2B9D28E7--
