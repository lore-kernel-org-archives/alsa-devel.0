From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ALSA: hda - Turn on PIN_OUT from hdmi
	playback prepare.
Date: Thu, 19 Jul 2012 02:34:24 -0700
Message-ID: <CAEUnVG4RZGHUibSVu2Ex2fBp5d3=v-qJA=K9=WU0ioEWUJNSMQ@mail.gmail.com>
References: <1342689551-20669-1-git-send-email-dgreid@chromium.org>
 <s5h4np4gkzd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 0526B265275
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 11:34:42 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so4422903wib.2
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 02:34:45 -0700 (PDT)
In-Reply-To: <s5h4np4gkzd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 19, 2012 at 2:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 19 Jul 2012 02:19:11 -0700,
> Dylan Reid wrote:
>>
>> Turn on the pin widget's PIN_OUT bit from playback prepare. The pin is
>> enabled in open, but is disabled in hdmi_init_pin which is called during
>> system resume. This causes a system suspend/resume during playback to
>> mute HDMI/DP. Enabling the pin in prepare allows calling snd_pcm_prepare
>> after a system resume to restore audio.
>
> Then we can remove the corresponding code in
> generic_hdmi_playback_pcm_open()?
good point, I'll run a quick test and send a new patch.
>
>
> Takashi
>
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>>  sound/pci/hda/patch_hdmi.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 0b4a1ea..c53f99c 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -1153,11 +1153,17 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>>       struct hdmi_spec *spec = codec->spec;
>>       int pin_idx = hinfo_to_pin_index(spec, hinfo);
>>       hda_nid_t pin_nid = spec->pins[pin_idx].pin_nid;
>> +     int pinctl;
>>
>>       hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
>>
>>       hdmi_setup_audio_infoframe(codec, pin_idx, substream);
>>
>> +     pinctl = snd_hda_codec_read(codec, pin_nid, 0,
>> +                                 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
>> +     snd_hda_codec_write(codec, pin_nid, 0,
>> +                         AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl | PIN_OUT);
>> +
>>       return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
>>  }
>>
>> --
>> 1.7.11.2.138.g2b53359
>>
