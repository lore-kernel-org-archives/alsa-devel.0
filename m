From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH] ALSA: hda - Turn on PIN_OUT from hdmi
 playback prepare.
Date: Thu, 19 Jul 2012 15:20:56 +0530
Message-ID: <5007D880.7000201@st.com>
References: <1342689551-20669-1-git-send-email-dgreid@chromium.org>
 <s5h4np4gkzd.wl%tiwai@suse.de>
 <CAEUnVG4RZGHUibSVu2Ex2fBp5d3=v-qJA=K9=WU0ioEWUJNSMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog113.obsmtp.com (eu1sys200aog113.obsmtp.com
 [207.126.144.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A1B3265280
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 11:51:03 +0200 (CEST)
In-Reply-To: <CAEUnVG4RZGHUibSVu2Ex2fBp5d3=v-qJA=K9=WU0ioEWUJNSMQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 7/19/2012 3:04 PM, Dylan Reid wrote:
> On Thu, Jul 19, 2012 at 2:26 AM, Takashi Iwai<tiwai@suse.de>  wrote:
>> At Thu, 19 Jul 2012 02:19:11 -0700,
>> Dylan Reid wrote:
>>>
>>> Turn on the pin widget's PIN_OUT bit from playback prepare. The pin is
>>> enabled in open, but is disabled in hdmi_init_pin which is called during
>>> system resume. This causes a system suspend/resume during playback to
>>> mute HDMI/DP. Enabling the pin in prepare allows calling snd_pcm_prepare
>>> after a system resume to restore audio.
>>
>> Then we can remove the corresponding code in
>> generic_hdmi_playback_pcm_open()?
> good point, I'll run a quick test and send a new patch.

Leave a blank line before and after your comment, so that it easy to locate.

~Rajeev

>>
>>
>> Takashi
>>
>>>
>>> Signed-off-by: Dylan Reid<dgreid@chromium.org>
>>> ---
>>>   sound/pci/hda/patch_hdmi.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>> index 0b4a1ea..c53f99c 100644
>>> --- a/sound/pci/hda/patch_hdmi.c
>>> +++ b/sound/pci/hda/patch_hdmi.c
>>> @@ -1153,11 +1153,17 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>>>        struct hdmi_spec *spec = codec->spec;
>>>        int pin_idx = hinfo_to_pin_index(spec, hinfo);
>>>        hda_nid_t pin_nid = spec->pins[pin_idx].pin_nid;
>>> +     int pinctl;
>>>
>>>        hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
>>>
>>>        hdmi_setup_audio_infoframe(codec, pin_idx, substream);
>>>
>>> +     pinctl = snd_hda_codec_read(codec, pin_nid, 0,
>>> +                                 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
>>> +     snd_hda_codec_write(codec, pin_nid, 0,
>>> +                         AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl | PIN_OUT);
>>> +
>>>        return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
>>>   }
>>>
>>> --
>>> 1.7.11.2.138.g2b53359
>>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> .
>
