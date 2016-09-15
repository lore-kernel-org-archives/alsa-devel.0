From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT
	as deprecated"
Date: Thu, 15 Sep 2016 23:41:43 +0900
Message-ID: <6357ad44-b194-7dfd-b3e8-938af89f4b54@sakamocchi.jp>
References: <1473947149-6663-1-git-send-email-o-takashi@sakamocchi.jp>
 <20160915142148.GR21682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 87EBB266726
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 16:41:57 +0200 (CEST)
In-Reply-To: <20160915142148.GR21682@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@linaro.org, tiwai@suse.de, clemens@ladisch.de, vinod.koul@intel.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sep 15 2016 23:21, Charles Keepax wrote:
> On Thu, Sep 15, 2016 at 10:45:49PM +0900, Takashi Sakamoto wrote:
>> SND_SOC_BYTES_TLV brings confusions to user land because it doesn't follow
>> to a protocol of ctl and tlv operation. At least, this macro and related
>> kernel APIs include two misunderstandings:
>>  - 'struct snd_ctl_elem_info.count' can also represent the length of TLV
>>    packet paylaod, snd_soc_bytes_info_ext() performs in this way.
>>  - 'struct snd_ctl_tlv.tlv' can include arbitrary data regardless of TLV
>>    packet structure, snd_soc_bytes_tlv_callback() performs in this way.
>>
>> In a policy of kernel land development, it's quite worse to break protocols
>> for applications. Therefore, developers are discouraged to use these kernel
>> APIs.
>>
>> In the first place, SND_SOC_BYTES_TLV was added to satisfy a request of
>> developers who need to add control elements which transfer data larger than
>> the size which 'struct snd_ctl_elem_value' can represent; e.g. over 512
>> bytes. However, as long as the size is less than the size; e.g. 512 bytes,
>> SND_SOC_BYTES_EXT is still available. Although there is actually the
>> limitation of maximum data size, it's better to use this API for stable
>> application interface till better alternative ways are implemented in
>> future.
>>
>> For these reasons, this commit reverts the previous commit which lead
>> developers to the worse behaviour.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
> 
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Yeah would be better to use normal controls for <512 bytes, so
> this looks good to me.
> 
> Although you might want to resend using Mark's kernel.org address
> as I imagine he would be the one to apply the change and that is
> the address he normally uses for patches.

Oh, he uses the domain instead of linaro.org. I missed it.

Now I add him to CC list.


Thanks

Takashi Sakamoto
