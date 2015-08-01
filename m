From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - mic selection not working
Date: Sat, 1 Aug 2015 09:41:12 +0800
Message-ID: <CAN8cciYavRQVFoacVxJdiH01ezRfKMvJqxO18HFmLqwGkaJyAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DE92617E0
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 03:41:13 +0200 (CEST)
Received: by obbop1 with SMTP id op1so66037868obb.2
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 18:41:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>
>>   Ports:
>>
>>                 analog-output-speaker: Speakers (priority: 10000)
>>                 analog-output-headphones: Headphones (priority: 9000,
not available)
>>         Active Port: analog-output-speaker
>>
>>
>> When you select model=dell-headset-multi, the driver create "Headphone
Mic Jack" kctl with type 1 which is SND_JACK_HEADPHONE
>>
>> type 2 is SND_JACK_MICROPHONE
>>
>> type 3 is SND_JACK_HEADSET but hda jack does not use this type
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/sound/jack.h
>>
>> JACK created Headphone Mic, type 1
>> CTRL: add: Headphone Mic Jack:0
>> JACK report Headphone Mic, status 0
>> JACK created Headset Mic Phantom, type 2
>> CTRL: add: Headset Mic Phantom Jack:0
>> JACK report Headset Mic Phantom, status 2
>> CTL Notify: Headset Mic Phantom Jack:0, mask=1
>> JACK created Internal Mic Phantom, type 2
>> CTRL: add: Internal Mic Phantom Jack:0
>> JACK report Internal Mic Phantom, status 2
>> CTL Notify: Internal Mic Phantom Jack:0, mask=1
>> JACK created Speaker Front Phantom, type 4
>> CTRL: add: Speaker Front Phantom Jack:0
>> JACK report Speaker Front Phantom, status 4
>> CTL Notify: Speaker Front Phantom Jack:0, mask=1
>> JACK created External Subwoofer, type 4
>> CTRL: add: External Subwoofer Jack:0
>>
>> The problem of hda jack kctls are those retaskable I/O jack controls
>>
>> 1) multi io jacks in those 3 stack desktop
>> 2) headphone/mic jack in asus netbook
>> 3) dell-headset-multi combo jack
>>
>> the role of the jack in 1) change from input to output when "Channel
mode" change from "2ch" to "4ch" or "6ch"
>>
>> the role of the jack in 2) and 3) change from Output to Input when
"Capture Source" change from Internal Mic/Headset Mic to Headphone Mic
>>
>> In your case, Headphone Mic Jack kctl return the presence of HP jack
except when the combo jack is set to support conventional mic (i.e. when
the driver change pin ctl of hp pin node 0x15 to zero and set pin ctl of
mic pin to IN),
>>
>> The driver already unmute the internal speaker when you change capture
source to Headphone Mic
>>
>> The only point is whether pulseaudio still regard this Headphone Mic
Jack as the availability of the headphone port when the capture source is
Headphone Mic
>>
>>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=ca4942e89cf462e5f8c36ca9b8b689879083af6b
>>
>>
>

>
> I really appreciate your efforts in this matter. Unfortunately I
understand parts of our talks and I am unsure what I can do.
> I am not a kernel / driver developer.
>
> Are there any steps I can do knowing my limited skills on driver
development?
> If so, would you mind to describe them step by step, so this beginner
understands? :D

Don't forget cc David since he implement dell-headset-multi

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=73bdd597823e2231dc882577dbbaf8df92fe1775

static void alc_update_headset_mode(struct hda_codec *codec)
+{
+ struct alc_spec *spec = codec->spec;
+
+ hda_nid_t mux_pin = spec->gen.imux_pins[spec->gen.cur_mux[0]];
+ hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+
+ int new_headset_mode;
if (!snd_hda_jack_detect(codec, hp_pin))
+ new_headset_mode = ALC_HEADSET_MODE_UNPLUGGED;
+ else if (mux_pin == spec->headset_mic_pin)
+ new_headset_mode = ALC_HEADSET_MODE_HEADSET;
+ else if (mux_pin == spec->headphone_mic_pin)
+ new_headset_mode = ALC_HEADSET_MODE_MIC;
+ else
+ new_headset_mode = ALC_HEADSET_MODE_HEADPHONE;
+
+ if (new_headset_mode == spec->current_headset_mode)
+ return;
+
+ switch (new_headset_mode) {
+ case ALC_HEADSET_MODE_UNPLUGGED:
+ alc_headset_mode_unplugged(codec);
+ spec->gen.hp_jack_present = false;
+ break;
+ case ALC_HEADSET_MODE_HEADSET:
+ if (spec->current_headset_type == ALC_HEADSET_TYPE_UNKNOWN)
+ alc_determine_headset_type(codec);
+ if (spec->current_headset_type == ALC_HEADSET_TYPE_CTIA)
+ alc_headset_mode_ctia(codec);
+ else if (spec->current_headset_type == ALC_HEADSET_TYPE_OMTP)
+ alc_headset_mode_omtp(codec);
+ spec->gen.hp_jack_present = true;
+ break;
+ case ALC_HEADSET_MODE_MIC:
+ alc_headset_mode_mic_in(codec, hp_pin, spec->headphone_mic_pin);
+ spec->gen.hp_jack_present = false;
+ break;
+ case ALC_HEADSET_MODE_HEADPHONE:
+ alc_headset_mode_default(codec);
+ spec->gen.hp_jack_present = true;
+ break;
+ }
+ if (new_headset_mode != ALC_HEADSET_MODE_MIC) {
+ snd_hda_set_pin_ctl_cache(codec, hp_pin,
+   AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN);
+ if (spec->headphone_mic_pin)
+ snd_hda_set_pin_ctl_cache(codec, spec->headphone_mic_pin,
+   PIN_VREFHIZ);
+ }
+ spec->current_headset_mode = new_headset_mode;
+
+ snd_hda_gen_update_outputs(codec);
+}

You have to post the output of

pactl list sources

when the is no jack plugged, headphone plugged, headset plugged and mic
jack plugged

The logic is defined in alc_update_headset_mode()

Although auto mic selection is disabled when the combo jack can support
conventional mic and headset mic

The capture source of these kind of laptop is not as same as the capture
source of ac97 codec of pci sound cards, it is not really manually selected
in sound preference

When there is no jack plugged in, the  capture source should be internal
mic.

As the codec cannot differentitate headset, headphone and mic when there is
jack plugged in and driver use mux_pin to determine the type of the jack

In pulseaudio term,

[Jack Headphone Mic] can determine the availability of internal mic is YES
when unplugged but unknown when plugged

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-input-internal-mic.conf

[Jack Headphone Mic]

The availability of headphone mic is unknown when plugged and NO when
unplugged

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-input-headphone-mic.conf

[Jack Headphone Mic]

The availability of headset mic is unknown when plugged and NO when
unplugged

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-input-headset-mic.conf

It is not exactly UNKNOWN but determined by the capture source when plugged
