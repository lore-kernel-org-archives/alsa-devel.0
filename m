From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Remove over-initialization of
	mux in ALC269VB
Date: Fri, 11 Mar 2011 09:51:37 +0100
Message-ID: <4D79E299.5070300@canonical.com>
References: <4D7884DA.4040409@canonical.com> <s5h1v2fnqc0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030207050605040301050201"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id CF240103823
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 09:51:39 +0100 (CET)
In-Reply-To: <s5h1v2fnqc0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030207050605040301050201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-03-10 12:54, Takashi Iwai wrote:
> At Thu, 10 Mar 2011 08:59:22 +0100,
> David Henningsson wrote:
>>
>> Takashi, would you like to give this one a thought to make sure I
>> haven't missed any case where this verb is needed. For both models (amic
>> and dmic), the verb is re-issued, and the autoparser would either add a
>> mux, or at least set it to a correct start.
>
> Could you give some sample alsa-info outputs affected by this bug?

Hmm, at least I can get you codec proc (attached) and PCI IDs (8086:27d8 
(rev 02), SSID 1043:8437). Let me know if you need anything else.

> Basically, setting the verbs in that init table should be harmless
> if the driver overwrites the setting properly in alc269_auto_init()
> or via amp-cache/verb-cache on resume.

Ok, although the initialisation verb is still superfluous :-)

> Does the patch like below fix the issue?

It does fix the issue when I run it in hda-emu, thanks! I've asked the 
person with the hardware to test it there as well and I'm awaiting his 
reply.

>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai<tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Initialize special cases for input src in init phase
>
> Currently some special handling for the unusual case like dual-ADCs
> or a single-input-src is done in the tree-parse time in
> set_capture_mixer().  But this setup could be overwritten by static
> init verbs.
>
> This patch moves the initialization into the init phase so that
> such input-src setup won't be lost.
>
> Signed-off-by: Takashi Iwai<tiwai@suse.de>
> ---
>   sound/pci/hda/patch_realtek.c |   19 ++++++++++++++++---
>   1 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 4261bb8..c1ad3e9 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -394,6 +394,7 @@ struct alc_spec {
>   	/* other flags */
>   	unsigned int no_analog :1; /* digital I/O only */
>   	unsigned int dual_adc_switch:1; /* switch ADCs (for ALC275) */
> +	unsigned int single_input_src:1;
>   	int init_amp;
>   	int codec_variant;	/* flag for other variants */
>
> @@ -3919,6 +3920,8 @@ static struct hda_amp_list alc880_lg_loopbacks[] = {
>    * Common callbacks
>    */
>
> +static void alc_init_special_input_src(struct hda_codec *codec);
> +
>   static int alc_init(struct hda_codec *codec)
>   {
>   	struct alc_spec *spec = codec->spec;
> @@ -3929,6 +3932,7 @@ static int alc_init(struct hda_codec *codec)
>
>   	for (i = 0; i<  spec->num_init_verbs; i++)
>   		snd_hda_sequence_write(codec, spec->init_verbs[i]);
> +	alc_init_special_input_src(codec);
>
>   	if (spec->init_hook)
>   		spec->init_hook(codec);
> @@ -5585,6 +5589,7 @@ static void fixup_single_adc(struct hda_codec *codec)
>   			spec->capsrc_nids += i;
>   		spec->adc_nids += i;
>   		spec->num_adc_nids = 1;
> +		spec->single_input_src = 1;
>   	}
>   }
>
> @@ -5596,6 +5601,16 @@ static void fixup_dual_adc_switch(struct hda_codec *codec)
>   	init_capsrc_for_pin(codec, spec->int_mic.pin);
>   }
>
> +/* initialize some special cases for input sources */
> +static void alc_init_special_input_src(struct hda_codec *codec)
> +{
> +	struct alc_spec *spec = codec->spec;
> +	if (spec->dual_adc_switch)
> +		fixup_dual_adc_switch(codec);
> +	else if (spec->single_input_src)
> +		init_capsrc_for_pin(codec, spec->autocfg.inputs[0].pin);
> +}
> +
>   static void set_capture_mixer(struct hda_codec *codec)
>   {
>   	struct alc_spec *spec = codec->spec;
> @@ -5611,7 +5626,7 @@ static void set_capture_mixer(struct hda_codec *codec)
>   		int mux = 0;
>   		int num_adcs = spec->num_adc_nids;
>   		if (spec->dual_adc_switch)
> -			fixup_dual_adc_switch(codec);
> +			num_adcs = 1;
>   		else if (spec->auto_mic)
>   			fixup_automic_adc(codec);
>   		else if (spec->input_mux) {
> @@ -5620,8 +5635,6 @@ static void set_capture_mixer(struct hda_codec *codec)
>   			else if (spec->input_mux->num_items == 1)
>   				fixup_single_adc(codec);
>   		}
> -		if (spec->dual_adc_switch)
> -			num_adcs = 1;
>   		spec->cap_mixer = caps[mux][num_adcs - 1];
>   	}
>   }


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------030207050605040301050201
Content-Type: text/plain;
 name="alc269vb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alc269vb.txt"

Codec: Realtek ALC269VB
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0269
Subsystem Id: 0x10438437
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC269VB Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=5, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=5, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x8b 0x8b]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="ALC269VB Analog", type="Audio", device=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1f 0x1f]
  Converter: stream=1, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 5
     0x18 0x19 0x1a 0x1b 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00] [0x00]
  Connection: 2
     0x02 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40000b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x03 0x03]
  Pincap 0x00000020: IN
  Pin Default 0x99a30920: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x0c* 0x0d
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00001734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0d
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001724: IN Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003c: IN OUT HP Detect
  Pin Default 0x03211c1f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=04, enabled=1
  Connection: 2
     0x0c 0x0d*
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4006852d: [N/A] Line Out at Ext N/A
    Conn = Digital, Color = Purple
    DefAssociation = 0x2, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=25
Node 0x21 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x0c* 0x0d
Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 6
     0x18 0x19 0x1a 0x1b 0x1d 0x0b


--------------030207050605040301050201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030207050605040301050201--
