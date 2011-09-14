From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Dell XPS 13 (Codec: IDT 92HD73C1X5) and 3 stereo
 jack output
Date: Wed, 14 Sep 2011 08:35:52 +0800
Message-ID: <CAN8cciaKy4bBH+Kq0UfSM+zG+9s8yZFUnAeqaHMCaXtxNY1ocg@mail.gmail.com>
References: <BANLkTi=i5yUP+dKSU-ZU2_tTQiyFmOX5LQ@mail.gmail.com>
	<BANLkTikUP7wRZ8QBSHdWJWg6++izEkxF1A@mail.gmail.com>
	<BANLkTinQFHW2J_BMiWW05-rchg-K=cfk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2204F243BD
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 02:35:54 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1136535fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 17:35:52 -0700 (PDT)
In-Reply-To: <BANLkTinQFHW2J_BMiWW05-rchg-K=cfk4g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/6/1 Ruben Van Boxem <vanboxem.ruben@gmail.com>:

>>>
>>
>> I have been able to produce output from the third jack fiddling with
>> hda_analyzer. The diff is attached. I'm sure it is far from optimal,
>> but at least shows which pin needs modification. Plugging into the
>> jack won't mute the speakers, but I guess it needs the same settings
>> as the first two jacks (which do mute the speaker). With this
>> modification, I get the same output from the right jack as from the
>> left jack (meaning the front left and front right channels of a 5.1
>> setup).
>>
>>
>
> I will take this occasion to point to the bug report on this issue,
> which has been around for a while.
>
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4546
>
> I think the second anniversary is a nice time to help us poor users
> get this annoying issue fixed.
>
> Thanks!
>

Have you try the latest snapshot tarball ?

Does the internal dmic work ?

since the auto-mic detection conflict with retasking mic to support 5.1
as the driver still don't know whether you are plug the external mic
or speaker to the jack since jack detection does not check the
impedence


Node 0x0e [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Control: name="Mic Jack Mode", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Control: name="Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Connection: 4
     0x15* 0x16 0x17 0x1e

The support of your xps were added by this patch
a7662640104599249e15cda7839e9050f92e6a0e

+       SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0271,
+                               "unknown Dell", STAC_DELL_M6),

Refer to commit 7c2ba97b8a99c857758fd03513350b39a8b242d6

hda: Add 5.1 support for second headphone jack

however using hda-emu


hda_codec: model 'dell-m6-dmic' is selected for config 1028:271 (unknown Dell)
send: NID=0xa, VERB=0xf00(get_parameters), PARM=0xe(connect_len)
receive: 0x4
send: NID=0xa, VERB=0xf02(get_connect_list), PARM=0x0
receive: 0x1e171615
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0) type:speaker
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=2 (0xa/0xf/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: Mic=0xe
stac92xx: Enabling multi-HPs workaround

CTRL: add: Headphone Playback Volume:0
CTRL: add: Headphone Playback Switch:0
CTRL: add: Headphone Playback Volume:1
CTRL: add: Headphone Playback Switch:1
CTRL: add: Mic Jack Mode:0
CTRL: add: Beep Playback Switch:0
CTRL: add: Beep Playback Volume:0
CTRL: add: Speaker Playback Volume:0
CTRL: add: Speaker Playback Switch:0
CTRL: add: Capture Volume:0
CTRL: add: Capture Switch:0
CTRL: add: Mic Capture Volume:0
CTRL: add: Internal Mic Capture Volume:0
CTRL: add: Master Playback Volume:0

JACK created HP Out at Ext Left Jack, type 1
JACK created HP Out at Ext Left Jack, type 1
JACK created Mic at Ext Left Jack, type 2


The problem is snd_hda_parse_pin_def_config() put internal speaker to
spec->line out

it look like stac92xx_auto_create_multi_out_ctls()  can create "Mic
jack" switch to retask mic as output

static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
					       const struct auto_pin_cfg *cfg)
{
	struct sigmatel_spec *spec = codec->spec;
	hda_nid_t nid;
	int err;
	int idx;

	err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
				    spec->multiout.dac_nids,
				    cfg->line_out_type);
	if (err < 0)
		return err;

	if (cfg->hp_outs > 1 && cfg->line_out_type == AUTO_PIN_LINE_OUT) {
		err = stac92xx_add_control(spec,
			STAC_CTL_WIDGET_HP_SWITCH,
			"Headphone as Line Out Switch",
			cfg->hp_pins[cfg->hp_outs - 1]);
		if (err < 0)
			return err;
	}

	for (idx = 0; idx < cfg->num_inputs; idx++) {
		if (cfg->inputs[idx].type > AUTO_PIN_LINE_IN)
			break;
		nid = cfg->inputs[idx].pin;
		err = stac92xx_add_jack_mode_control(codec, nid, idx);
		if (err < 0)
			return err;
	}

	return 0;
}
