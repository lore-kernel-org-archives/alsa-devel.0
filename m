From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: Add accessor macros for TLV items
Date: Wed, 28 Mar 2018 10:55:18 +0900
Message-ID: <584434c8-33db-ee05-16c2-dfc4e0a44337@sakamocchi.jp>
References: <20180327183945.6551-1-ranjani.sridharan@linux.intel.com>
 <s5hh8p18fsw.wl-tiwai@suse.de> <1522184904.2236.14.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 9D5CB2671A9
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 03:55:22 +0200 (CEST)
In-Reply-To: <1522184904.2236.14.camel@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 28 2018 06:08, Ranjani Sridharan wrote:
>>> --- a/include/sound/tlv.h
>>> +++ b/include/sound/tlv.h
>>> @@ -49,6 +49,11 @@
>>>   
>>>   #define TLV_DB_GAIN_MUTE		SNDRV_CTL_TLVD_DB_GAIN_MUT
>>> E
>>>   
>>> +#define TLV_ITEM_TYPE			SNDRV_CTL_TLVD_ITEM_T
>>> YPE
>>> +#define TLV_ITEM_LEN			SNDRV_CTL_TLVD_ITEM_LE
>>> N
>>> +#define TLV_DB_MIN			SNDRV_CTL_TLVD_DB_SCALE_
>>> MIN
>>> +#define TLV_DB_MUTE_AND_STEP		SNDRV_CTL_TLVD_DB_SCAL
>>> E_MUTE_AND_STEP
>>
>> What's the reason of these redundant redefinitions?
> 
> I followed the other definitions in this file which were aliases to the
> ones in uapi/sound/tlv.h. I suppose these can be avoided. I'll fix this
>   in v2.

When adding new macros relevant to TLV, please add them into 
'include/uapi/sound/tlv.h' instead of 'include/sound/tlv.h'. This is 
required to share declarations to user space. The latter should be going 
to be obsoleted with replacement of all of macros but developers 
including me have been lazy to do it for a small concerns.

>>> --- a/include/uapi/sound/tlv.h
>>> +++ b/include/uapi/sound/tlv.h
>>> @@ -60,6 +60,13 @@
>>>   	unsigned int name[] = { \
>>>   		SNDRV_CTL_TLVD_DB_SCALE_ITEM(min, step, mute) \
>>>   	}
>>> +/* Accessor macros for TLV type and len */
>>> +#define SNDRV_CTL_TLVD_ITEM_TYPE		0
>>> +#define SNDRV_CTL_TLVD_ITEM_LEN			1
>>> +
>>> +/* Accessor macros for min, mute and step values from dB scale
>>> type TLV */
>>> +#define SNDRV_CTL_TLVD_DB_SCALE_MIN		2
>>> +#define SNDRV_CTL_TLVD_DB_SCALE_MUTE_AND_STEP	3
>>
>> These are no "macros" but constants.  And, they use the same prefix
>> SNDRV_CTL_TLVD_* as other existing macros.  SNDTV_CTL_TLVD_*() is a
>> macro to define/expand a TLV descriptor.  It's not for defining the
>> offset value as added in the patch.
>>
>> That is, better to choose another unique prefix to distinguish the
>> definitions clearly.
> 
> Sure, will change the prefix as well. Thanks!

And in my opinion when adding such new lines, it's better to post actual 
usage of them with the same patch serie. Addition of them are easy, but 
maintenance of them is not easy as the same.

In short:

"These will be used by drivers to extract the TLV data while loading 
topology." from your patch comment.

This comment seems to be just from your in-house tree, in reviewer's 
eyes. Please show actual usage of the new macros to evaluate your 
changes. At least, it's better ways to add changes into core features.


Regards

Takashi Sakamoto
