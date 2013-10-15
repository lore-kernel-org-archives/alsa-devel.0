From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: Add an
 interface to override its functions
Date: Tue, 15 Oct 2013 11:02:44 +0200
Message-ID: <525D04B4.3050606@metafoo.de>
References: <1381823360-8672-1-git-send-email-b42378@freescale.com>
 <525CF814.6090403@metafoo.de> <20131015082229.GA18714@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B452926087C
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 11:00:41 +0200 (CEST)
In-Reply-To: <20131015082229.GA18714@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/15/2013 10:22 AM, Nicolin Chen wrote:
> Hi Lars,
> 
> On Tue, Oct 15, 2013 at 10:08:52AM +0200, Lars-Peter Clausen wrote:
>> On 10/15/2013 09:49 AM, Nicolin Chen wrote:
>>> Each implementation of gerneric pcm dmaengine has been naturally
>>> limited by the pre-defined gerneric functions. Thus add an extra
>>> interface for user to create a backdoor so that they can override
>>> those fixed functions for some uncommon requirements: using on-chip
>>> memory for DMA buffers and accordingly different mmap function for
>>> example, while at the meantime, they can continue to benifit from
>>> the concise and wise generic pcm dmaengine.
>>>
>>> Signed-off-by: Nicolin Chen <b42378@freescale.com>
>>
>> We do have the dmaengine pcm helper functions (sound/core/pcm_dmaengine.c)
>> and the generic dmaengine pcm ASoC driver
>> (sound/soc/soc-generic-dmaengine-pcm.c). The generic dmaengine pcm ASoC
>> driver uses the dmaengine pcm helper functions, but it is not the only user
>> of them. So your patch breaks all other users of the helper functions.
>>
>> The helper functions are designed in a way that you can either wrap them in
>> your own pcm driver driver or not use them at all. E.g. take a look at
>> sound/soc/omap/omap-pcm.c on how to overwrite specific functions.
>>
>> - Lars
> 
> If this modification to sound/core/pcm_dmaengine.c is not fair,
> what about moving the modification to soc-gerneric-dmaengine-pcm.c?
> 
> For example, instead of using snd_dmaengine_pcm_trigger() directly
> in gerneric soc dmaengine driver, we create a new one inside gerneric
> soc dmaengine driver and check the override:
> 
> static int snd_soc_dmaengine_pcm_trigger(substream, cmd) {
> 	if (config->driver->ops->trigger)
> 		return config->driver->ops->trigger(substream, cmd);
> 		
> 	return snd_dmaengine_pcm_trigger(substream, cmd);
> }
> 
> Since it happens inside generic dmaengine pcm ASoC driver, it won't break
> those helper functions.
> 
> I'm trying this just because I hope generic dmaengine can be more flexible
> Admittedly, using helper functions might be more plausible way in current
> ASoC structure. However, there might be so much change for an generic soc
> dmaengine implementation even if it just wants to override one single func.

Well the idea of the generic dmaengine driver is to be generic and not
require SoC specific hacks since those should not be necessary if things are
done right. What exactly do you want to implement in the overwritten ops?

- Lars
