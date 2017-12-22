From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 1/1] ASoC: rsnd: ssi: Fix issue in dma
 data address assignment
Date: Thu, 21 Dec 2017 18:27:19 -0800
Message-ID: <5A3C6D87.6080508@mentor.com>
References: <1513832314-29727-1-git-send-email-jiada_wang@mentor.com>
 <87k1xgbnfz.wl%kuninori.morimoto.gx@renesas.com>
 <5A3B5EFE.8070606@mentor.com>
 <87ind0bkte.wl%kuninori.morimoto.gx@renesas.com>
 <5A3B7BF7.7060400@mentor.com>
 <87d137ob24.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 93266266D61
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 03:27:29 +0100 (CET)
In-Reply-To: <87d137ob24.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

On 12/21/2017 04:43 PM, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your feedback
> I understand your situation
>
>> We have enabled TDM Split and Ex-Split mode in our kernel,
>> and SSI(U)'s dma address diffs based on the BUSIF it is using,
>> so have a single dma data struct per rsnd_ssi will cause issue when
>> SSI isn't working with BUSIF0.
> First of all, "TDM (Ex) Split mode" is not yet supported.
> And unfortunately, your patch is not enough for it.
> I guess you enabled it with many local patches,
> and posted one of them ?
>
> It is very advanced feature, we need to consider about
> channel/sampling rate/data width/settings/address etc etc etc...
> Lots of things we need to solve/care !
> DMA pointer is one of them.
>
> If we focus only to DMA, your patch is still wrong I think.
> "Playback/Capture direction" is not related to this topic.
> 1 DMA on 1 DAI is enough ?
> And we need to update rsnd_gen2_dma_addr() too for DMA address.
Yes, this patch is only one of a serial patch set to enable TDM (Ex) 
Split mode,
I submitted it alone because think it is independent,
but you are right, to make the background more clear,
I will submit the whole patch set together with this single patch in v2,
(this probably will take some time)

Thanks,
Jiada
>> Do you have any suggestion to address this issue?
> I have no idea at this point.
> Missing part for TDM (Ex) Split mode is not only DMA pointer.
>
> Why do you want to use it ?
> If you want to do is only "use 2 DAIs for playback",
> how about to use MIXer ? It is already supported on upstream.
> Best regards
> ---
> Kuninori Morimoto
