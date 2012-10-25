From: Liam Girdwood <lrg@ti.com>
Subject: Re: Back-end state transition query
Date: Thu, 25 Oct 2012 18:59:16 +0100
Message-ID: <50897DF4.1020402@ti.com>
References: <5088ECF2.8010007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C4E264FF7
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 19:59:20 +0200 (CEST)
In-Reply-To: <5088ECF2.8010007@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Patrick,

On 25/10/12 08:40, Patrick Lai wrote:
> Hi Liam,
> 
> I am facing an issue related to how DPCM manages state of back-end
> substream. Here is description of problem:
> 
> When front-end PCM substream is in paused state, back-end PCM substream
> will be put in paused state as well if given front-end PCM substream is
> the only client of given back-end. Based on current implementation of
> DPCM, when application closes front-end PCM substream, DPCM framework
> will not allow back-end enter HW_FREE state so back-end will never get
> shutdown completely as well.
> 
> refer to function soc_dpcm_be_dai_hw_free(), here is the check for states
> 
>     if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
>         (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
>         (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
>         (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
>                         continue;
> 
> Can't DPCM also allow back-end hardware being freed in STATE_PAUSED?

This seems like a bug. We should hw_free() the BE here.

> Even if DPCM expects trigger stop coming to update back-end state to STATE_STOP, the following condition check will never allow back-end enter stop state anyway
> 
> Refer to soc_dpcm_be_dai_trigger()
> 
>   case SNDRV_PCM_TRIGGER_STOP:
>      if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
>                                 continue;
> 
> Can you please take a look and recommend the appropriate state transition or it would be okay to allow PAUSED state in soc_dpcm_be_dai_hw_free()?

It should be OK to allow the paused state in hw_free(), but I'm thinking we should probably see the trigger stop when we close the FE (although I'm not 100% certain atm of seeing the STOP as I've not traced this PAUSE -> CLOSE sequence). I assume you have a patch that allows this ?

Thanks

Liam
