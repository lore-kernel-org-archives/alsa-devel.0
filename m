From: "Piotr G." <pejotr@wp.pl>
Subject: Re: [PATCH 1/1] sound/usb: Add Asus Xonar U7 Mixer -
 input support
Date: Fri, 1 Jul 2016 09:30:24 +0200
Message-ID: <57761C10.9050104@wp.pl>
References: <55B4929D.5030401@wp.pl> <55B4938C.6080808@wp.pl>
 <s5hpp3dx0lb.wl-tiwai@suse.de> <55F197E8.2020301@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
 by alsa0.perex.cz (Postfix) with ESMTP id A36072614A7
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 09:27:23 +0200 (CEST)
In-Reply-To: <55F197E8.2020301@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?Johan_Rast=c3=a9n?= <johan@oljud.se>
List-Id: alsa-devel@alsa-project.org

Hello Guys,
I made some sniffing of USB protocol with Windows10 and Windows8 drivers
for Asus Xonar U7.
ALSA has no Capture Volume controls for Line Input and Mic Input. Mic
doesn't work. According to Windows drivers when using Mic or Line in
sliders:


wValue:	 0x8202 [L] -> 0x82 It's not declared in UAC2
	 0x8201 [R] -> 0x82 It's not declared in UAC2

AudioControl Interface Descriptor:
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                16
        bSourceID               4 (Mic Terminal)
        bmaControls( 0)      0x00000003
          Mute Control (read/write)
        bmaControls( 1)      0x00000000 (No Volume Control?)
        bmaControls( 2)      0x00000000 (No Volume Control?)
        iFeature                0

AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                17
        bSourceID               5 (Line in Terminal)
        bmaControls( 0)      0x00000003
          Mute Control (read/write)
        bmaControls( 1)      0x00000000 (No Volume Control?)
        bmaControls( 2)      0x00000000 (No Volume Control?)
        iFeature                0

It's looks like firmware doesn't declare Volume or Input Gain in FU with
0x82 CS. How can I properly add it do the source? (redefine mixer_maps?)

wIndex:	 0x1100 (Line In)  -> 0x1100 ALSA FU16 OK
	 0x1000 (Mic) 	   -> 0x1000 ALSA FU17 OK

In Alsamixer in Capture section we have only
Line and Mic Controls where we can toggle On or Off.
This is correct when parsing upper FU only Mute Control is declared
Where or how I can manual declare that this controls have Volume Control
with CS 0x82 (Control Selector)? WHat is the correct way?

About Ranges:
Line in
Data: 	0x00a6 (160) - 0x00ff (255) (Mixer from 0 (-96dB) to 99 (-0.15dB)
log)
	0x0000 (0)   (Mixer 100 (0dB)

Mic
Data:
>From 0x00a6 (160) - 0x0000 (0) (Mixer from 0 (-96dB) to 50 (0dB) log)
>From 0x000 (0) - 0x0032 (50) (Mixer from 50 (0dB) to 100 (50dB) lin)

Thanks for support.

Piotr


W dniu 10.09.2015 o 16:47, Piotr SQ9FK pisze:
> Hello Takashi,Johan
> My patches are unessesary since following last patch was applied to the
> git:
> ALSA: usb-audio: Change internal PCM order
> 
> Capture working but there are no volume sliders for Line-In Capture or
> Mic-In Capture (I can only toggle on off). Probably the RANGES are
> broken?. From ASUS Windows driver I can see following ranges:
> 
> Master Volume: (Phisycal Knob on Asus)
> from 100 to 1 correspond 0dB to -70dB, 0 is -127dB
> Range from 1 to 100 -> 0dB to -70dB (logarythmic)
> 
> Mic-In:
> from 100 to 1 correspond 30dB to -10dB, 0 is -192dB
> Range from 1 to 10 -> -10dB to 10dB (linear?)
> Range from 11 to 100 -> 10dB to 30dB (logarythmic)
> 
> Line-In:
> from 100 to 1 correspond 0dB to -40dB, 0 is -192dB
> Range from 11 to 100 -> 10dB to 30dB (logarythmic)
> 
> Actual Situation:
> Input Gain Pad Control - 3 steps [0 - 50 - 100]
> Double Slider. In Capture and Playback Categories, both of them are
> controlled in the same time.
> Controls Playback Volume only, Capture not.
> 
> "Mic" and "Line" Switches [on/off]
> PCM Cature Source [Line/Mic]
> Electret Mic doesn't work. With all possible configurations - Silent.
> When I pluged Line level signal, I can record the signal without problems.
> PCM Capture Source [Line] - Line [on] Mic [off] - Sound
> PCM Capture Source [Line] - Line [on] Mic [on] - Sound
> PCM Capture Source [Line] - Line [off] Mic [off] - No Sound
> PCM Capture Source [Line] - Line [off] Mic [on] - No Sound
> The same with selected [Mic]. There is no Capture Volume control.
> 
> PCM 1 [mute/on]
> I think this is SPDIF switch. It doesn't work. When I switch it on ->
> Blue Led on Xonar doesn't light up.
> 
> I attached screen of alsamixer, usbmix from proc and my mixer_map from
> my old patch.
> I think there are is still bugs in parsing. Please point me how I can
> add manually Volume control for Capture?
> 
> Piotr Gaska
> 
> W dniu 2015-07-27 o 14:10, Takashi Iwai pisze:
>> On Sun, 26 Jul 2015 10:00:12 +0200,
>> Piotr G. wrote:
>>> Hello,
>>> This is my first patch to alsa-devel, and I'm not very skilled
>>> programmer. From lsusb -vvv, I've draw Xonar U7 map with all IT OT FU CS
>>> in mixer_map.c I don't know why the driver by default doesn't parse all
>>> info correctly. With this patch you can see Line Switch and Mic Switch
>>> in alsamixer. I can record my voice in Audacity with all supported bit
>>> and sampling rates in Mono or Stereo
>>> This is temporary solution. Please correct me if the patch is not
>>> properly made.
>>>
>>>     What doesn't work:
>>>     - Cannot change Capture Volume for Line/Mic. No mixer control in
>>> alsamixer
>>>     - Switching between Line/Mic doesn't work (Mute doesn't work)
>>>     - SPDIF not tested
>>>     As what I wrote at beginning I'm not skilled programmer so any
>>> help is
>>>     aprreciated
>>>
>>>
>>> proc-usbmixer -> cat /proc/asound/*/usbmix
>>> usb.debug -> lsusb -vv (only Asus Xonar U7)
>> The changes in mixer_maps.c look good, but what's the reason for
>> uac2_audio_feature_info[]?  It seems adding "Control" suffix to each
>> entry, which doesn't look correct.
>>
>>
>> thanks,
>>
>> Takashi
>>
>>
>>> ---
>>>     sound/usb/mixer.c      | 23 +++++++++++++++++++++--
>>>     sound/usb/mixer_maps.c | 48
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>     2 files changed, 69 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>>> index 6b3acba..027d160 100644
>>> --- a/sound/usb/mixer.c
>>> +++ b/sound/usb/mixer.c
>>> @@ -818,6 +818,25 @@ static struct usb_feature_control_info
>>> audio_feature_info[] = {
>>>         { "Phase Inverter Control",    USB_MIXER_BOOLEAN },
>>>     };
>>>
>>> +static struct usb_feature_control_info uac2_audio_feature_info[] = {
>>> +    /* UAC2 specific */
>>> +    { "Mute Control",        USB_MIXER_INV_BOOLEAN },
>>> +    { "Volume Control",        USB_MIXER_S16 },
>>> +    { "Bass Control",        USB_MIXER_S8 },
>>> +    { "Mid Control",        USB_MIXER_S8 },
>>> +    { "Treble Control",        USB_MIXER_S8 },
>>> +    { "Graphic Equalizer Control",    USB_MIXER_S8 },
>>> +    { "Automatic Gain Control",    USB_MIXER_BOOLEAN },
>>> +    { "Delay Control",        USB_MIXER_S16 }, /* FIXME: U32 in UAC2 */
>>> +    { "Bass Boost Control",        USB_MIXER_BOOLEAN },
>>> +    { "Loudness Control",        USB_MIXER_BOOLEAN },
>>> +    { "Input Gain Control",        USB_MIXER_S16 },
>>> +    { "Input Gain Pad Control",    USB_MIXER_S16 },
>>> +    { "Phase Inverter Control",    USB_MIXER_BOOLEAN },
>>> +    { "Underflow Control",        USB_MIXER_BOOLEAN },
>>> +    { "Overflow Control",        USB_MIXER_BOOLEAN },
>>> +};
>>> +
>>>     /* private_free callback */
>>>     void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl)
>>>     {
>>> @@ -1240,7 +1259,7 @@ static void build_feature_ctl(struct mixer_build
>>> *state, void *raw_desc,
>>>         snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
>>>         cval->control = control;
>>>         cval->cmask = ctl_mask;
>>> -    cval->val_type = audio_feature_info[control-1].type;
>>> +    cval->val_type = uac2_audio_feature_info[control-1].type;
>>>         if (ctl_mask == 0) {
>>>             cval->channels = 1;    /* master channel */
>>>             cval->master_readonly = readonly_mask;
>>> @@ -1318,7 +1337,7 @@ static void build_feature_ctl(struct mixer_build
>>> *state, void *raw_desc,
>>>             break;
>>>         default:
>>>             if (!len)
>>> -            strlcpy(kctl->id.name, audio_feature_info[control-1].name,
>>> +            strlcpy(kctl->id.name,
>>> uac2_audio_feature_info[control-1].name,
>>>                     sizeof(kctl->id.name));
>>>             break;
>>>         }
>>> diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
>>> index e5000da..07f510e 100644
>>> --- a/sound/usb/mixer_maps.c
>>> +++ b/sound/usb/mixer_maps.c
>>> @@ -341,6 +341,48 @@ static const struct usbmix_name_map
>>> scms_usb3318_map[] = {
>>>         { 0 }
>>>     };
>>>
>>> +/* ASUS Xonar U7 - USB CM6632A (ADC CS5361 // DAC Dolby CS4362A // DAC
>>> Stereo CS4398 */
>>> +/* Topology:
>>> +
>>> +USB_IN[1]------->FU[13]-----------CS[18]--->Spk_OUT[7]
>>> +
>>> +Dig_IN[2]------->FU[14]-----------CS[19]--->Dig_OUT[8]
>>> +
>>> +Mic_IN[4]------->FU[16]---+
>>> +                          SU[20]--CS[22]--->USB_OUT[11]
>>> +Line_IN[5]------>FU[17]---+
>>> +
>>> +*/
>>> +
>>> +static const struct usbmix_name_map xonar_u7_map[] = {
>>> +    /* 1: IT PCM  Analog (USB Streaming) */
>>> +    /* 2: IT PCM2 Digital (USB Streaming) */
>>> +    /* 4: IT Microphone */
>>> +    /* 5: IT Line IN */
>>> +    /* 7: OT Speaker */
>>> +    /* 8: OT SPDIF */
>>> +    /* 11 OT Capture Playback (USB Streaming) */
>>> +    { 13, "Speaker Playback" },    /* 13 FU Speaker Out Mute/Volume */
>>> +    { 14, "IEC958 Playback" },    /* 14 FU SPDIF Out Mute/Volume */
>>> +    { 16, "Mic Capture" },         /* 16 FU Capture Mic-in
>>> Mute/Volume */
>>> +    { 17, "Line Capture" },     /* 17 FU Capture Line-in Mute/Volume */
>>> +    /* 18 CS for 1 PCM (USB Streaming) Clock Source */
>>> +    /* 19 CS for 2 SPDIF (USB Streaming) Clock Source */
>>> +    { 20, "Capture Source" },     /* 20 SU Capture Source Selector */
>>> +    /* 22 CS Line-in and Mic-in Clock Source */
>>> +    { 0 }
>>> +};
>>> +
>>> +static struct usbmix_selector_map xonar_u7_selectors[] = {
>>> +{
>>> +                .id = 20,
>>> +                .count = 2,
>>> +                .names = (const char*[]) {"Mic", "Line"}
>>> +        },
>>> +        { 0 } /* terminator */
>>> +
>>> +};
>>> +
>>>     /*
>>>      * Control map entries
>>>      */
>>> @@ -451,6 +493,12 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
>>>             .id = USB_ID(0x25c4, 0x0003),
>>>             .map = scms_usb3318_map,
>>>         },
>>> +    {
>>> +        /* Asus Xonar U7 */
>>> +        .id = USB_ID(0x1043, 0x857c),
>>> +        .map = xonar_u7_map,
>>> +        .selector_map = xonar_u7_selectors,
>>> +    },
>>>         { 0 } /* terminator */
>>>     };
>>>
>>> -- 
>>> 2.3.6
>>>
> 
