From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Thu, 16 Jun 2011 20:50:40 +0200
Message-ID: <BANLkTi=iwVeUooaLUUrYzESWgzYaxvR7Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf301fb905de23b404a5d8be6f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7D0282441A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 20:50:42 +0200 (CEST)
Received: by wyg36 with SMTP id 36so1400832wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 11:50:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--20cf301fb905de23b404a5d8be6f
Content-Type: text/plain; charset=ISO-8859-1

(Sorry for previous message being too long)

2011/6/14 Raymond Yau <superquad.vortex2@gmail.com>:
- Nascondi testo citato -
> 2011/6/8 alex dot baldacchino dot alsasub at gmail dot com
> <alex.baldacchino.alsasub@gmail.com>:
>>
>>
>> http://pastebin.ca/2076750
>>
>>
>> By the way, should something like the above be done for capture
>> streams as well? I've noticed (with front panel disabled) that
>> controls "Front Mic Playback Volume" and "Front Mic Playback Switch"
>> are correctly missing from audio-mixer widget 0x21, but node 0x29 is
>> still 'attached' to control "Front Mic Boost Capture Volume", which is
>> accessible through a mixer (though I didn't try to play with it; it is
>> listed also by amixer output in above linked document). Is this the
>> wanted/expected behaviour?
>
> It seem that 0x2b and 0x29 does not have any mic boost capture volume,
> that look like "Playback Switch" when they are retasked as output for
> 3 jacks motherboard
>
> Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>  Control: name="Front Mic Boost Capture Volume", index=0, device=0
>    ControlAmp: chs=3, dir=In, idx=0, ofs=0
>  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>  Amp-Out vals:  [0x80 0x80]
>  Pincap 0x0000233c: IN OUT HP Detect
>    Vref caps: HIZ 50 100
>  Pin Default 0x02a19037: [Jack] Mic at Ext Front
>    Conn = 1/8, Color = Pink
>    DefAssociation = 0x3, Sequence = 0x7
>  Pin-ctls: 0x21: IN VREF_50
>  Unsolicited: tag=20, enabled=1
>  Power states:  D0 D1 D2 D3
>  Power: setting=D3, actual=D3
>  Connection: 1
>     0x1c
>
> Node 0x2b [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>  Control: name="Mic Boost Capture Volume", index=0, device=0
>    ControlAmp: chs=3, dir=In, idx=0, ofs=0
>  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>  Amp-Out vals:  [0x80 0x80]
>  Pincap 0x00002334: IN OUT Detect
>    Vref caps: HIZ 50 100
>  Pin Default 0x01a19036: [Jack] Mic at Ext Rear
>    Conn = 1/8, Color = Pink
>    DefAssociation = 0x3, Sequence = 0x6
>  Pin-ctls: 0x21: IN VREF_50
>  Unsolicited: tag=20, enabled=1
>  Power states:  D0 D1 D2 D3
>  Power: setting=D0, actual=D0
>  Connection: 2
>     0x0a* 0x0c
>

That pastebin was alsa-info.sh output with front panel disabled in
bios, to show via_build_pcms() can be fixed to avoid creating a
sencond playback pcm substream (thus, a second subdevice) when there's
no front audio panel in the system (or is disabled), even if
snd_hda_find_mixer_ctl() cannot find control "Independent HP" if
called from within via_build_pcms:

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT2020 Analog [VT2020 Analog]
 Subdevices: 1/1
 Subdevice #0: subdevice #0


But I might have pasted a wrong file (sorry for that), correct output
for that (sort of) patch would be:


Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
 Control: name="Front Mic Boost Capture Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=0, ofs=0
 Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
 Amp-Out vals:  [0x80 0x80]
 Pincap 0x0000233c: IN OUT HP Detect
   Vref caps: HIZ 50 100
 Pin Default 0x42a190f7: [N/A] Mic at Ext Front
   Conn = 1/8, Color = Pink
   DefAssociation = 0xf, Sequence = 0x7
 Pin-ctls: 0x00: VREF_HIZ
 Unsolicited: tag=20, enabled=1
 Power states:  D0 D1 D2 D3
 Power: setting=D3, actual=D3
 Connection: 1
    0x1c


Front audio panel not connected (not seen by the BIOS) -> front mic
not available -> power setting D3 (because of set_pin_power_state()
checking for presence, I guess)


Node 0x2b [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
 Control: name="Mic Boost Capture Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=0, ofs=0
 Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
 Amp-Out vals:  [0x80 0x80]
 Pincap 0x00002334: IN OUT Detect
   Vref caps: HIZ 50 100
 Pin Default 0x01a19036: [Jack] Mic at Ext Rear
   Conn = 1/8, Color = Pink
   DefAssociation = 0x3, Sequence = 0x6
 Pin-ctls: 0x21: IN VREF_50
 Unsolicited: tag=20, enabled=1
 Power states:  D0 D1 D2 D3
 Power: setting=D3, actual=D3
 Connection: 2
    0x0a* 0x0c


Rear jack present (on the motherboard), but nothing connected to it ->
power state D3


> /* capture mixer elements */
> static const struct snd_kcontrol_new vt1718S_capture_mixer[] = {
>        HDA_CODEC_VOLUME("Capture Volume", 0x10, 0x0, HDA_INPUT),
>        HDA_CODEC_MUTE("Capture Switch", 0x10, 0x0, HDA_INPUT),
>        HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x11, 0x0, HDA_INPUT),
>        HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x11, 0x0, HDA_INPUT),
> -       HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x2b, 0x0, HDA_INPUT),
> -       HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x29, 0x0,
> -                        HDA_INPUT),
>
>


This would eliminate both boost volume controls at once, but in normal
conditions (e.g. front audio panel enabled in bios, headset connected
to it) Front Mic Boost works (e.g. I can record sound louder and
noisier). I just wondered if creating "Front Mic Boost Capture Volume"
could have been done dynamically, instead, to match the driver
capability (as is) to avoid creating Volume and Switch controls (on
mixer 0x21) for Front Mic:

with front audio panel missing (disabled in bios):

Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
 Control: name="Mic Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Mic Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Line Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Control: name="Line Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
 Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x1f 0x1f] [0x80 0x80] [0x80 0x80]
 Power states:  D0 D1 D2 D3
 Power: setting=D0, actual=D0
 Connection: 5
    0x2c 0x2b 0x2a 0x29 0x28


otherwise:


Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
 Control: name="Front Mic Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=3, ofs=0
 Control: name="Front Mic Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=3, ofs=0
 Control: name="Rear Mic Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Rear Mic Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Line Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Control: name="Line Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
 Amp-In vals:  [0x80 0x80] [0x1f 0x1f] [0x1f 0x1f] [0x1f 0x1f] [0x80 0x80]
 Power states:  D0 D1 D2 D3
 Power: setting=D0, actual=D0
 Connection: 5
    0x2c 0x2b 0x2a 0x29 0x28


A possible solution:


/* capture mixer elements */
 static const struct snd_kcontrol_new vt1718S_capture_mixer[] = {
        HDA_CODEC_VOLUME("Capture Volume", 0x10, 0x0, HDA_INPUT),
        HDA_CODEC_MUTE("Capture Switch", 0x10, 0x0, HDA_INPUT),
        HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x11, 0x0, HDA_INPUT),
        HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x11, 0x0, HDA_INPUT),
       HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x2b, 0x0, HDA_INPUT),
 -       HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x29, 0x0,
 -                        HDA_INPUT),

...

+ static const struct snd_kcontrol_new vt1718S_front_mic_boost =
+     HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x29, 0x0,
+                         HDA_INPUT);


+ static int vt1718S_add_front_mic_boost( struct via_spec *spec ){
+        snd_kcontrol_new *knew;
+
+        if( spec->front_panel_out == HDA_HW_WITH_FRONT_PANEL){
+                 knew = via_clone_control( spec, &vt1718S_front_mic_boost );
+                 if( knew == NULL )
+                         return -ENOMEM;
+                 return 1;
+        }
+
+        return 0;
+ }


in struct via_spec:

...

       struct hda_pcm pcm_rec[ VIA_NUM_REC];
+       #define HDA_HW_WITHOUT_FRONT_PANEL      0 /* initial value*/
+       #define HDA_HW_WITH_FRONT_PANEL 1
+       unsigned int front_panel_out; /* used to determine the correct
number of playback pcm substreams */


in via_new_spec():

...

       codec->spec = spec;
       spec->codec = codec;
       spec->codec_type = get_codec_type(codec);
+       spec->front_panel_out = HDA_HW_WITHOUT_FRONT_PANEL;


in via_hp_build():

...

       knew = via_clone_control(spec, &via_hp_mixer[0]);
       if (knew == NULL){
               return -ENOMEM;
       }
       knew->subdevice = HDA_SUBDEV_NID_FLAG | nid;
       knew->private_value = nid;
+       spec->front_panel_out = HDA_HW_WITH_FRONT_PANEL; /* now we
know there's a valid secondary playback pcm substream */


in via_build_pcms():

...

       info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
               spec->multiout.dac_nids[0];
+       /* is this a multistream-capable environment? let's compute
real number of playback pcm substreams */
+       info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams = 1 +
spec->front_panel_out;


in patch_vt1718S():

...
       if (!spec->adc_nids && spec->input_mux) {
               spec->adc_nids = vt1718S_adc_nids;
               spec->num_adc_nids = ARRAY_SIZE(vt1718S_adc_nids);
               get_mux_nids(codec);
               override_mic_boost(codec, 0x2b, 0, 3, 40);
               override_mic_boost(codec, 0x29, 0, 3, 40);
               spec->mixers[spec->num_mixers] = vt1718S_capture_mixer;
               spec->num_mixers++;
+               vt1718S_add_front_mic_boost( spec );
       }


It worked for me, AFAICT:

With front audio panel _enabled_ in bios:

Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
 Control: name="Front Mic Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=3, ofs=0
 Control: name="Front Mic Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=3, ofs=0
 Control: name="Rear Mic Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Rear Mic Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Line Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Control: name="Line Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
 Amp-In vals:  [0x80 0x80] [0x1f 0x1f] [0x1f 0x1f] [0x1f 0x1f] [0x80 0x80]
 Power states:  D0 D1 D2 D3
 Power: setting=D0, actual=D0
 Connection: 5
    0x2c 0x2b 0x2a 0x29 0x28


Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
 Control: name="Front Mic Boost Capture Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=0, ofs=0
 Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
 Amp-Out vals:  [0x80 0x80]
 Pincap 0x0000233c: IN OUT HP Detect
   Vref caps: HIZ 50 100
 Pin Default 0x02a19037: [Jack] Mic at Ext Front
   Conn = 1/8, Color = Pink
   DefAssociation = 0x3, Sequence = 0x7
 Pin-ctls: 0x21: IN VREF_50
 Unsolicited: tag=20, enabled=1
 Power states:  D0 D1 D2 D3
 Power: setting=D0, actual=D0
 Connection: 1
    0x1c


aplay -l output

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT2020 Analog [VT2020 Analog]
 Subdevices: 2/2
 Subdevice #0: subdevice #0
 Subdevice #1: subdevice #1
[...]


and front mic boost control listed in amixer:

Simple mixer control 'Front Mic Boost',0
 Capabilities: cvolume penum
 Capture channels: Front Left - Front Right
 Limits: Capture 0 - 3
 Front Left: Capture 0 [0%] [0.00dB]
 Front Right: Capture 0 [0%] [0.00dB]


With front audio panel _disabled_ in bios:


Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
 Control: name="Mic Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Mic Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=1, ofs=0
 Control: name="Line Playback Volume", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Control: name="Line Playback Switch", index=0, device=0
   ControlAmp: chs=3, dir=In, idx=2, ofs=0
 Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
 Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x1f 0x1f] [0x80 0x80] [0x80 0x80]
 Power states:  D0 D1 D2 D3
 Power: setting=D0, actual=D0
 Connection: 5
    0x2c 0x2b 0x2a 0x29 0x28


Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
 Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
 Amp-Out vals:  [0x80 0x80]
 Pincap 0x0000233c: IN OUT HP Detect
   Vref caps: HIZ 50 100
 Pin Default 0x42a190f7: [N/A] Mic at Ext Front
   Conn = 1/8, Color = Pink
   DefAssociation = 0xf, Sequence = 0x7
 Pin-ctls: 0x00: VREF_HIZ
 Unsolicited: tag=20, enabled=1
 Power states:  D0 D1 D2 D3
 Power: setting=D3, actual=D3
 Connection: 1
    0x1c


aplay -l output:

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT2020 Analog [VT2020 Analog]
 Subdevices: 1/1
 Subdevice #0: subdevice #0
[...]

and control "Front Mic Boost" missing in amixer output. Attaching
alsa-info.sh outputs.

Perhaps other codecs could benefit of that, like VT1708S, VT1716S,
VT2002P, VT1812, all creating a "Front Mic Boost Capture Volume"
control statically (each one needing its own modification to
vtxxxxx_capture_mixer, patch_vtxxxxx(), and
vt1718S_add_front_mic_boost() function renamed, moved upward in the
file before patch_vt1708S() and modified with a further
snd_kcontrol_new argument to be used by all others, e.g. called as
vt_add_front_mic_boost( spec, &vt1718S_front_mic_boost ):

+ static int vt_add_front_mic_boost( struct via_spec *spec, const
struct snd_kcontrol_new *fmb_ctl ){
+        snd_kcontrol_new *knew;
+
+        if( spec->front_panel_out == HDA_HW_WITH_FRONT_PANEL){
+                 knew = via_clone_control( spec, fmb_ctl );
+                 if( knew == NULL )
+                         return -ENOMEM;
+                 return 1;
+        }
+
+        return 0;
+ }


 ).


>
> The problem is in hda_verb vt1718S_volume_init_verbs
>
>        /* Amp Indices: CD = 1, Mic1 = 2, Line = 3, Mic2 = 4 */
>        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
>        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
>        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
>        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
>        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
>
> node 0x21 of your vt2020 has only 5 connections
>
> Refer to commit 4ab2d53a99b6dcee86837d2a9739bfb9f468db45
>
> you will need to ask the author of this patch since the patch
> explicitly change this non exisiting connection of node 0x21 on your
> vt2020
>
> -       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
> +       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
>
>

Will do. Perhaps there could be the need to create a separate
vt2020_volume_init_verbs, unless that operation is due to internal
implementation of the codec (reacting properly to the non-existing
connection write query). Thank you for everything.
- Nascondi testo citato -


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

--20cf301fb905de23b404a5d8be6f
Content-Type: application/x-gzip; name="alsa-info-outputs.tar.gz"
Content-Disposition: attachment; filename="alsa-info-outputs.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gp02aywz0

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
Dj1BEARBEARBEARBEIQ/4AJ0mHKhAGgBAA==
--20cf301fb905de23b404a5d8be6f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf301fb905de23b404a5d8be6f--
