From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Wed, 31 Aug 2016 07:04:12 +0900
Message-ID: <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 4C767265E0C
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 00:04:19 +0200 (CEST)
In-Reply-To: <20160830145136.GE9355@localhost>
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

On Aug 30 2016 23:51, Vinod Koul wrote:
> On Tue, Aug 30, 2016 at 04:09:33PM +0900, Takashi Sakamoto wrote:
>> On Aug 30 2016 16:05, Clemens Ladisch wrote:
>>> Takashi Sakamoto wrote:
>>>> [...] APIs return operated length, while TLV feature
>>>> can't. This is inconvenient to applications.
>>>>
>>>> This commit enables control core to return operated length of TLV feature.
>>>> This changes the prototype of 'snd_kcontrol_tlv_rw_t' to get a pointer to
>>>> size variable so that each implementation of the prototype can modify the
>>>> variable with operated length.
>>>
>>> I'll use this function as an example:
>>>
>>>> --- a/sound/usb/mixer.c
>>>> +++ b/sound/usb/mixer.c
>>>> @@ -535,17 +535,20 @@ int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
>>>>  * TLV callback for mixer volume controls
>>>>  */
>>>> int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
>>>> -			 unsigned int size, unsigned int __user *_tlv)
>>>> +			 unsigned int *size, unsigned int __user *_tlv)
>>>> {
>>>> 	struct usb_mixer_elem_info *cval = kcontrol->private_data;
>>>> 	DECLARE_TLV_DB_MINMAX(scale, 0, 0);
>>>>
>>>> -	if (size < sizeof(scale))
>>>> +	if (*size < sizeof(scale))
>>>> 		return -ENOMEM;
>>>> 	scale[2] = cval->dBmin;
>>>> 	scale[3] = cval->dBmax;
>>>> 	if (copy_to_user(_tlv, scale, sizeof(scale)))
>>>> 		return -EFAULT;
>>>> +
>>>> +	*size = sizeof(scale);
>>>> +
>>>> 	return 0;
>>>> }
>>>
>>> The size is already returned in scale[1] (it's initialized by
>>> DECLARE_TLV_DB_MINMAX()).  That's exactly what the "L" in "TLV" means.
>>>
>>> All other TLV callbacks also take care to set this field correctly.
>>>
>>> If there were any TLV callback that did not set _tlv[1] to the actual
>>> size, it would be buggy, and just needed to be fixed to do so.
>>
>> As I described, TLV feature of ALSA control interface is not only
>> used to transfer threshold level information, but also arbitrary
>> data for I/O by developers in ALSA SoC part. The '_tlv[1]' protocol
>> is not necessarily kept by them.
> 
> can you explain what you mean by 'to transfer threshold level information'
> 
> And on this discussion, IIUC, we should fill tlv[1] with size being returned
> right? For the asoc part, I think we should fix snd_soc_bytes_tlv_callback()
> to update this.

The layout of TLV packet is:
struct snd_ctl_tlv {
    unsigned int numid;   # numerical ID of a control element
    unsigned int length;  # length of payload
    unsigned int tlv[0];  # payload
};
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h?h=sound-4.8-rc4#n945

In our implementaion, TLV packet payload (struct snd_ctl_tlv.tlv) is
used to transfer data. For pure threshold level information, we expects
applications and drivers to fill the payload with this protocol:
struct snd_ctl_tlv.tlv[0]:  one of SNDRV_CTL_TLVT_XXX
struct snd_ctl_tlv.tlv[1]:  length of data
struct snd_ctl_tlv.tlv[2..]: data

(You can see SNDRV_CTL_TLVT_XXX in this header.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/tlv.h?h=sound-4.8-rc4
)

On the other hand, ALSA SoC part performs:
struct snd_ctl_tlv.tlv[0..]: arbitrary data

If your 'tlv[1]' means the 'struct snd_ctl_tlv.tlv[1]', no sense.

The issue I address is current implementation cannot correctly handle
this case:
 - applications request a buffer with a certain size
 - drivers processes the request with smaller size
 - application cannot get the size

When implementing I/O operation, in my understanding, this situation
often occurs, depending on driver implementation. Fortunately, current
implementation of WM-ADSP is free from this concern, but it's better for
us not to expect this luck always.


Regards

Takashi Sakamoto
