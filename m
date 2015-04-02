From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] fix dig out type to SPDIF when there are
 two digital pins with different type - VT1708S lost SPDIF device after
 upgrade
Date: Thu, 2 Apr 2015 08:42:26 +0800
Message-ID: <CAN8ccib=bPddvi60hz_fwyJ27R7c85JQaD4mAugFQN3M1x6WyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 31214264E9F
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 02:42:27 +0200 (CEST)
Received: by obvd1 with SMTP id d1so106620066obv.0
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 17:42:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >
> > Thank you for your reply,
> >
> > Please see below the output of alsa-info.sh before and after the
headphone plugged in
> >
> > Before:
http://www.alsa-project.org/db/?f=a316eebf7b150b5897838be37bce4e8c9d95eaae
> > After:
http://www.alsa-project.org/db/?f=0f163003e9005972db5f97f21a45be67816e3801
> >
> > I have 6 Jacks at the rear panel and two at the top (one output one
input)
> > I am afraid I do not know how to switch channel mode to retask.
> >
> > Also, the computer is of a certain age, and the issue has started
several month ago but I never really looked into it, so I am not sure that
change in power management will be relevant has it seems quite recent.
> >

What is the model of your asus motherbroad ?

>
> Seem lost the digial device 1 for SPDIF out
>
> Pin Default 0x985601f0: [Fixed] Digital Out at Int HDMI
>
> Is this internal spdif connector ?
>
> Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
>   Device: name="VT1708S Digital", type="HDMI", device=3
>
> APLAY
>
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: VT1708S Analog [VT1708S Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 3: VT1708S Digital [VT1708S Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
>
> Node 0x12 [Audio Output] wcaps 0x611: Stereo Digital
>   Control: name="IEC958 Playback Con Mask", index=0, device=0
>   Control: name="IEC958 Playback Pro Mask", index=0, device=0
>   Control: name="IEC958 Playback Default", index=0, device=0
>   Control: name="IEC958 Playback Switch", index=0, device=0
>   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
>   Device: name="VT1708S Digital", type="HDMI", device=3
>   Converter: stream=5, channel=0
>   Digital:
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x5e0]: 44100 48000 88200 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>
>   Power states:  D0 D1 D2 D3
>   Power: setting=D0, actual=D0
>
> Node 0x15 [Audio Output] wcaps 0x611: Stereo Digital
>   Converter: stream=5, channel=0
>   Digital:
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x5e0]: 44100 48000 88200 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>
>   Power states:  D0 D1 D2 D3
>   Power: setting=D0, actual=D0
>
> Node 0x20 [Pin Complex] wcaps 0x400701: Stereo Digital
>   Control: name="HDMI Phantom Jack", index=0, device=0
>   Pincap 0x00000010: OUT
>   Pin Default 0x985601f0: [Fixed] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>
>   Power states:  D0 D1 D2 D3
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x12
> Node 0x21 [Pin Complex] wcaps 0x400701: Stereo Digital
>   Control: name="SPDIF Phantom Jack", index=0, device=0
>   Pincap 0x00000010: OUT
>   Pin Default 0x074511f0: [Jack] SPDIF Out at Ext Rear Panel
>     Conn = Optical, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>
>   Power states:  D0 D1 D2 D3
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x15

Do the driver need a pin fixup for the digital pin or more check when
assign dig out type ?

If codec has two digital pin complex with diffferent type, check whether
the primary digital pin complex support DETECT

case AC_JACK_SPDIF_OUT:
case AC_JACK_DIG_OTHER_OUT:
if (cfg->dig_outs >= ARRAY_SIZE(cfg->dig_out_pins)) {
codec_info(codec,
   "ignore pin 0x%x, too many assigned pins\n",
   nid);
continue;
}
cfg->dig_out_pins[cfg->dig_outs] = nid;
cfg->dig_out_type[cfg->dig_outs] =
(loc == AC_JACK_LOC_HDMI) ?
HDA_PCM_TYPE_HDMI : HDA_PCM_TYPE_SPDIF;
cfg->dig_outs++;
+        if (cfg->dig_outs == 2)
+             if (cfg->dig_out_type[0] != cfg->dig_out_type[1])
+                  if (! snd_hda_query_pin_caps(codec,
cfg->dig_out_pins[0]) & AC_PINCAP_PRES_DETECT))
+                        cfg-> dig_out_type[0] = HDA_PCM_TYPE_SPDIF;

break;
