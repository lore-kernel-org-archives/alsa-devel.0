From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Wed, 31 Aug 2016 13:30:02 +0900
Message-ID: <57C65D4A.9090209@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 80914266CCB
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 06:30:07 +0200 (CEST)
In-Reply-To: <20160831042040.GO9355@localhost>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@linaro.org, Clemens Ladisch <clemens@ladisch.de>, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

On Aug 31 2016 13:20, Vinod Koul wrote:
>> The layout of TLV packet is:
>> struct snd_ctl_tlv {
>>     unsigned int numid;   # numerical ID of a control element
>>     unsigned int length;  # length of payload
>>     unsigned int tlv[0];  # payload
>> };
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h?h=sound-4.8-rc4#n945
>>
>> In our implementaion, TLV packet payload (struct snd_ctl_tlv.tlv) is
>> used to transfer data. For pure threshold level information, we expects
>> applications and drivers to fill the payload with this protocol:
>> struct snd_ctl_tlv.tlv[0]:  one of SNDRV_CTL_TLVT_XXX
>> struct snd_ctl_tlv.tlv[1]:  length of data
>> struct snd_ctl_tlv.tlv[2..]: data
>>
>> (You can see SNDRV_CTL_TLVT_XXX in this header.
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/tlv.h?h=sound-4.8-rc4
>> )
>>
>> On the other hand, ALSA SoC part performs:
>> struct snd_ctl_tlv.tlv[0..]: arbitrary data
>>
>> If your 'tlv[1]' means the 'struct snd_ctl_tlv.tlv[1]', no sense.
>>
>> The issue I address is current implementation cannot correctly handle
>> this case:
>>  - applications request a buffer with a certain size
>>  - drivers processes the request with smaller size
>>  - application cannot get the size
>>
>> When implementing I/O operation, in my understanding, this situation
>> often occurs, depending on driver implementation. Fortunately, current
>> implementation of WM-ADSP is free from this concern, but it's better for
>> us not to expect this luck always.
> 
> Thanks for the detailed explanation,
> 
> IIUC, the fix would be to ensure that drivers or ASoC does return the length
> value in snd_ctl_tlv.tlv[1] per the API expectations. As I said, in ASoC we
> tend to move code to core, so snd_soc_bytes_tlv_callback should be updated

Instead of it, I proposed to use 'struct snd_ctl_tlv.length' for the
length of TLV packet payload, because the original protocol is too rough
as I/O operations. The issue I suggested for ALSA SoC part is one of
actual examples. We can generate similar issues on user-defined control
element set.


Regards

Takashi Sakamoto
