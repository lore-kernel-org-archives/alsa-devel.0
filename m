From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda - program ICT bits to support
 HBR audio
Date: Tue, 19 Sep 2017 17:15:28 -0500
Message-ID: <62dca14d-ce69-0906-8e6a-ac6f4638bc41@linux.intel.com>
References: <1505833201-22363-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hwp4ue9f5.wl-tiwai@suse.de>
 <cefe96a7-a75b-04d1-faf5-915d595f851c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EBD8D2671F3
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 00:15:32 +0200 (CEST)
In-Reply-To: <cefe96a7-a75b-04d1-faf5-915d595f851c@linux.intel.com>
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
To: Takashi Iwai <tiwai@suse.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: patches.audio@intel.com, Sriram Periyasamy <sriramx.periyasamy@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 09/19/2017 04:31 PM, Pierre-Louis Bossart wrote:
> On 9/19/17 3:10 PM, Takashi Iwai wrote:
>> On Tue, 19 Sep 2017 17:00:01 +0200,
>> Subhransu S. Prusty wrote:
>>>
>>> From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>>>
>>> On recent Intel platforms (Haswell, Broadwell, Skylake, ApolloLake,
>>> KabyLake, ...), the IEC Coding Type (ICT) bitfield in the Digital
>>> Converter Control #3 needs to be set explicitly for HDMI/DisplayPort
>>> High Bit Rate (HBR) audio playback to work. This was not required in
>>> earlier platforms when HBR was first introduced. The ICT bits are
>>> defined in Section 7.3.3.9 of the HDaudio 1.0a specification.
>>>
>>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98797
>>>
>>> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>>> Signed-off-by: Pierre-Louis Bossart 
>>> <pierre-louis.bossart@linux.intel.com>
>>> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>>> ---
>>>   include/sound/hda_verbs.h  |  1 +
>>>   sound/pci/hda/patch_hdmi.c | 18 ++++++++++++++++++
>>>   2 files changed, 19 insertions(+)
>>>
>>> diff --git a/include/sound/hda_verbs.h b/include/sound/hda_verbs.h
>>> index d0509db6d0ec..d2004d7feb2b 100644
>>> --- a/include/sound/hda_verbs.h
>>> +++ b/include/sound/hda_verbs.h
>>> @@ -54,6 +54,7 @@ enum {
>>>   #define AC_VERB_GET_EAPD_BTLENABLE        0x0f0c
>>>   #define AC_VERB_GET_DIGI_CONVERT_1        0x0f0d
>>>   #define AC_VERB_GET_DIGI_CONVERT_2        0x0f0e /* unused */
>>> +#define AC_VERB_SET_DIGI_CONVERT_3        0x73e
>>
>> The SET verb should be placed in the dedicated section instead.
>>
>>
>>>   #define AC_VERB_GET_VOLUME_KNOB_CONTROL        0x0f0f
>>>   /* f10-f1a: GPIO */
>>>   #define AC_VERB_GET_GPIO_DATA            0x0f15
>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>> index 53f9311370de..2dcd99d2a757 100644
>>> --- a/sound/pci/hda/patch_hdmi.c
>>> +++ b/sound/pci/hda/patch_hdmi.c
>>> @@ -906,6 +906,7 @@ static int hdmi_setup_stream(struct hda_codec 
>>> *codec, hda_nid_t cvt_nid,
>>>                     hda_nid_t pin_nid, u32 stream_tag, int format)
>>>   {
>>>       struct hdmi_spec *spec = codec->spec;
>>> +    unsigned int param;
>>>       int err;
>>>         err = spec->ops.pin_hbr_setup(codec, pin_nid, 
>>> is_hbr_format(format));
>>> @@ -915,6 +916,23 @@ static int hdmi_setup_stream(struct hda_codec 
>>> *codec, hda_nid_t cvt_nid,
>>>           return err;
>>>       }
>>>   +    /*
>>> +     * on recent platforms IEC Coding Type is required for HBR 
>>> support,
>>> +     * read current Digital Converter settings and set ICT bitfield if
>>> +     * needed.
>>> +     */
>>> +    param = snd_hda_codec_read(codec, cvt_nid, 0,
>>> +                AC_VERB_GET_DIGI_CONVERT_1, 0);
>>> +
>>> +    param = (param >> 16) & ~(AC_DIG3_ICT);
>>> +
>>> +    /* on recent platforms ICT mode is required for HBR support */
>>> +    if (is_hbr_format(format))
>>> +        param |= 0x1;
>>> +
>>> +    snd_hda_codec_write(codec, cvt_nid, 0,
>>> +                AC_VERB_SET_DIGI_CONVERT_3, param);
>>
>> Do all codecs support this verb?  I'm a bit worried, since this
>> function gets called for all codecs, and some of them must be fairly
>> old.
>
> My favorite hobby: forensic software engineering...
>
> This converter contains both the ICT (IEC coding type) and KAE (Keep 
> Alive Enable).
> The HDaudio 1.0 spec dated (April 15, 2004) makes no reference to any 
> of those bits - even if it lists HDMI as a supported output (HDMI 1.0 
> was released in 2002).
>
> HDMI 1.3 added support for HDMI HBR and was released on June 22, 2006,
>
> The first DCN I see with those bits is from June 6, 2009
> https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/high-definition-audio-low-power.pdf 
>
> KAE became mandatory after July 1st, 2011.
>
> So yes in theory there is a risk that on a platform produced between 
> 2004 and 2009 (maybe 2011) accessing this verb might generate an error 
> or an warning. I don't know the standard and implementation enough to 
> know if this can be queried and what happens when accessing undefined 
> verbs. The oldest working machine I have is from 2010, older stuff was 
> scrapped/recycled.
>
> I guess we could set a capability and set it for newer platforms 
> making use of intel_hsw_common_init() in patch_hdmi.c (we already use 
> the codec ID to match the relevant quirks). We could also check on 
> Baytrail if it's needed with a Minnowboard.
I just tested on Baytrail and this fix is not needed. It's also not 
needed on Cantiga/IronLake, so adding a is_haswell_plus test should be 
enough to both enable HBR and avoid accessing a register for no good 
reason. will send a v2 shortly.
