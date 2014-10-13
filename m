From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/1] ALSA: ALC283 codec - Avoid pop noise
 on headphones during suspend/resume
Date: Mon, 13 Oct 2014 12:50:52 +0200
Message-ID: <543BAE8C.3090007@canonical.com>
References: <1412852696-32423-1-git-send-email-harshapriya.n@intel.com>
 <s5h38ax13xl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C2215260469
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 12:50:54 +0200 (CEST)
In-Reply-To: <s5h38ax13xl.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Harsha Priya <harshapriya.n@intel.com>
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 2014-10-09 20:41, Takashi Iwai wrote:
> At Thu,  9 Oct 2014 11:04:56 +0000,
> Harsha Priya wrote:
>> This patch sets the headphones mode to default before suspending
>> which helps avoid the pop noise on headphones
> The change looks simple, but since it's a mysterious COEF, I'd like to
> hear from people testing with other machines with this codec before
> applying the patch.
>
> David, do you know anyone in your team have such a machine to test?

Looping Hui here, do you have a machine with ALC283 to test with or 
knows who has one?

>
>
> thanks,
>
> Takashi
>
>> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 69d1236..e839e7a 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -2884,6 +2884,9 @@ static void alc283_shutup(struct hda_codec *codec)
>>   
>>   	alc_write_coef_idx(codec, 0x43, 0x9004);
>>   
>> +	/*depop hp during suspend*/
>> +	alc_write_coef_idx(codec, 0x06, 0x2100);
>> +
>>   	snd_hda_codec_write(codec, hp_pin, 0,
>>   			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
>>   
>> -- 
>> 1.9.1
>>
