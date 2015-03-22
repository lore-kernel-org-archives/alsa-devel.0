From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Missing beep controls for Via HDA codec
	(snd_hda_codec_via)
Date: Sun, 22 Mar 2015 21:27:24 +0800
Message-ID: <CAN8cciZn1ozWhSZkLCcf8V9fUtnKuqu4uDjjx165XD6J2rbCVw@mail.gmail.com>
References: <20150322075449.GT18986@odin.tremily.us>
 <s5hsicx4fw4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id ADD0D2610B9
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 14:27:25 +0100 (CET)
Received: by oiag65 with SMTP id g65so122581620oia.2
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 06:27:24 -0700 (PDT)
In-Reply-To: <s5hsicx4fw4.wl-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "W. Trevor King" <wking@tremily.us>
List-Id: alsa-devel@alsa-project.org

> >
> > My VT1802 chip has a beep-generating node:
> >
> >   $ cat /proc/asound/card1/codec#0
> >   Codec: VIA VT1802
> >   ...
> >   Vendor Id: 0x11068446
> >   Subsystem Id: 0x15587410
> >   Revision Id: 0x100000
> >   ...
> >   Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
> >     Amp-Out caps: ofs=0x0a, nsteps=0x12, stepsize=0x05, mute=1
> >     Amp-Out vals:  [0x0a]
> >     Power states:  D0 D1 D2 D3
> >     Power: setting=D0, actual=D0
> >   ...
> >
> > But I'm missing the:
> >
> >   Control: name=...
> >
> > entries that I think I need to manage this widget from alsamixer.  For
> > example, sambrian posts codec output for a CX20561 chip which has [1]:
> >
> >   Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
> >     Control: name="Beep Playback Volume", index=0, device=0
> >     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
> >     Control: name="Beep Playback Switch", index=0, device=0
> >     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
> >     Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
> >     Amp-Out vals: [0x00]
> >
> > I can patch with something like this:
> >
> >   diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> >   index 3de6d3d..85a0c08 100644
> >   --- a/sound/pci/hda/patch_via.c
> >   +++ b/sound/pci/hda/patch_via.c
> >   @@ -1520,8 +1520,10 @@ static int patch_vt2002P(struct hda_codec
*codec)
> >           spec->gen.mixer_nid = 0x21;
> >           override_mic_boost(codec, 0x2b, 0, 3, 40);
> >           override_mic_boost(codec, 0x29, 0, 3, 40);
> >   -       if (spec->codec_type == VT1802)
> >   +       if (spec->codec_type == VT1802) {
> >   +               spec->gen.beep_nid = 0x22;
> >                   fix_vt1802_connections(codec);
> >   +       }
> >           add_secret_dac_path(codec);
> >
> >           snd_hda_pick_fixup(codec, NULL, vt2002p_fixups, via_fixups);
> >
> > to get a dmesg entry like:
> >
> >   input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1b.0/sound/card1/hdaudioC1D0/input15
> >
> > but that doesn't add the beep controls.  Looking at patch_analog.c,
> > patch_conexant.c, and patch_realtek.c for inspiration, I expect we'll
> > need an HDA_CODEC_MUTE_BEEP(_MONO) entry, and possibly an
> > HDA_CODEC_VOLUME(_MONO) entry, but I'm not sure if these should be
> > mono or not, or if they should be inputs (following patch_realtek.c)
> > or outputs (following patch_analog.c and patch_conexant.c).  I've
> > filled out Via's datasheet-request form [2], but I don't know how
> > likely that is to be accepted.
>
> According to your output, the node 0x22 has:
>
>    Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
>      Amp-Out caps: ofs=0x0a, nsteps=0x12, stepsize=0x05, mute=1
>      Amp-Out vals:  [0x0a]
>
> so this should mono and output.
>
> Other codecs may have different controls because rather controlling in
> the input of the mixer widget or such.
>
>

Why beep generator cannot automically found by auto parser  ?

7.3.4.5 Audio Function Group Capabilities

The Audio Parameter returns a set of bit fields describing the audio
capabilities of the Audio Function.

Parameter ID:  08h
Response Format:

31:17 16 15:12 11:8 7:4 3:0
Rsvd Beep Gen Rsvd Input Delay Rsvd Output Delay

Figure 85.  Audio Function Group Capabilities Response Format

BeepGen indicates the presence of an optional Beep Generator with this
Audio Function Group

Bit 16 of Audio Function Group Capabilities Response

or using

end_nid = codec->start_nid + codec->num_nodes;
for (nid = codec->start_nid; nid < end_nid; nid++) {
unsigned int wid_caps = get_wcaps(codec, nid);
unsigned int wid_type = get_wcaps_type(wid_caps);
if (wid_type == AC_WID_BEEP)
             spec->gen.beep_nid = nid;
  }
