From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Mon, 14 Jan 2013 11:42:23 +0800
Message-ID: <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE4D2651A0
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2013 04:42:25 +0100 (CET)
Received: by mail-ie0-f169.google.com with SMTP id c14so4593541ieb.0
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 19:42:24 -0800 (PST)
In-Reply-To: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Miro Hodak <mhodak127@gmail.com>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, diaz.manolo@gmail.com
List-Id: alsa-devel@alsa-project.org

>
> Commit identified in the subject (ALSA: HDA - Add Independent Headphone
for
> all models of ad1988/ad1989) causes problem with audio on at least two
Asus
> boards and is still present in current kernel. The boards on which this
> problem is seen are Asus M3A79-T DELUXE and Asus Rampage II Gene (actually
> a slightly modified version used in Asus CG5290 desktop).
>
> The symptoms:
> 1. XFCE and Gnome2 audio mixers crash whenever sound is started or
stopped.
> The error message is:
> simple_none.c:1350: get_enum_item_ops: Assertion `helem' failed.

This is caused by the active access flag of independent headphone control

static void activate_ctl(struct hda_codec *codec, const char *name, int
active)
{
       struct snd_kcontrol *ctl = snd_hda_find_mixer_ctl(codec, name);
       if (ctl) {
-               ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-               ctl->vd[0].access |= active ? 0 :
-                       SNDRV_CTL_ELEM_ACCESS_INACTIVE;
               ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_WRITE;
               ctl->vd[0].access |= active ?
                       SNDRV_CTL_ELEM_ACCESS_WRITE : 0;
               snd_ctl_notify(codec->bus->card,
                              SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
       }
}

>
> 2. On one of the boards (Asus M3A79-T DELUXE) the mixer control labels are
> misconfigured since muting the Master channel does not turn the sound off.

For model=auto

It is bug of hda parser which put node 0x1a in speaker out pin when the
pincap only support input

Your need either

ignore this node in hda parser or

Ignore the node as speaker when pincap is INPUT in patch_analog.c

/* add playback controls for speaker and HP outputs */
static int ad1988_auto_create_extra_out(struct hda_codec *codec, hda_nid_t
pin,
                                        const char *pfx)
{
        struct ad198x_spec *spec = codec->spec;
        hda_nid_t nid;
        int i, idx, err;
        char name[32];

        if (! pin)
                return 0;

+
+     if ((snd_hda_query_pin_caps(codec, pin) & AC_PINCTL_OUT_EN) == 0)
+          return 0;
+
        idx = ad1988_pin_idx(pin);
        nid = ad1988_idx_to_dac(codec, idx);


Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x911711f0: [Fixed] Speaker at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN

Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1e 0x1e]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0

Node 0x22 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x37 0x21

> Either Master is mislabeled or it does not work correctly.
>
> Other than that, the sound actually works fine, but it is very annoying
> when mixer keeps crashing. Reverting to kernel just before the commit
fixes
> these issues. Thus it appears that the commit
> 34588709af61be1550b4e2bcee5c85d0ac4f34d4 breaks autodetect for these
> boards. A workaround is to force the 6stack-dig model and this fixes
> problems on both boards, but, of course, it would be preferred if things
> work out of the box.
>

If  possible try the proposed generic hda parser from sound-unstable.git

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/058330.html

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/058367.html

>
> Alsa-info for both boards can be found below.
>

Model=auto does not include headphone as slave of virtual master , the
volume of headphone and line out jacks are controlled independently since
you can play different streams to headphone and line out jacks (multi
stream playback)

May need dynamically inlcude/exclude headphone play volume and switch as
slave of the virtual master controls

Do  you need to include HDMI playback volume as slave of the virtual master
volume ?

Can HDMI and SPDIF work independently since there are two digital audio
output convertor and the number of SDO of hda controller is 4 ?

Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="IEC958 Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x0145f1a0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0xa, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02

Node 0x1d [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="HDMI Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x1856f1b0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Other
    DefAssociation = 0xb, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b

For 6stack-dig

Thus model create digital capture even when there is no spdif  in pin
complex

Node 0x07 [Audio Input] wcaps 0x130391: Stereo Digital
  Control: name="IEC958 Capture Switch", index=0, device=0
  Control: name="IEC958 Capture Default", index=0, device=0
  Device: name="AD198x Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
  Delay: 3 samples
  Connection: 1
     0x1c

Node 0x1c [Pin Complex] wcaps 0x40020b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97]
  Pincap 0x00000020: IN
  Pin Default 0x41c5f160: [N/A] SPDIF In at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN

> Results of alsa-info
>
> Asus Rampage II Gene:
>
> Before the commit: http://pastebin.com/gCZurk6D
> After the commit (autodetect): http://pastebin.com/3hNX2g1c
> After the commit (6stack_dig model): http://pastebin.com/dL0UGeTW
>
> More recent kernel:
> 3.6.11-gentoo (autodetect): http://pastebin.com/0gjnhYA2
> 3.6.11-gentoo (6stack_dig model): http://pastebin.com/K9bsWBWW

>
> Asus M3A79-T DELUXE
>
> Before the commit: http://pastebin.com/hyUBmpDL
> After the commit (autodetect) : http://pastebin.com/gzGg60bM
> After the commit (6stack_dig model): http://pastebin.com/y88jCMhM
