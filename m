From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [bug] SPDIF (digital-out) not working on
	NForce4/CK804
Date: Tue, 7 Oct 2014 11:21:58 +0800
Message-ID: <CAN8cciZ=22ph3yFKjWf0h=hUXgBbO9_m=7f_YBga1nrdHOwrTw@mail.gmail.com>
References: <542D95C8.8060701@gmail.com>
 <CAN8cciYnAm6ivNk_FG6WbWAicskXQ9E2Pi+LLAb2jLSSwuJC+Q@mail.gmail.com>
 <542F0EFE.6020303@gmail.com>
 <CAN8ccia720EFBH8mHdYV4V4_pwx6r2GGUhsZZXsbbNHxdZCeJA@mail.gmail.com>
 <542FBF1B.9050500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
 [209.85.216.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 99381260393
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 05:21:59 +0200 (CEST)
Received: by mail-qc0-f173.google.com with SMTP id x13so5044875qcv.18
 for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2014 20:21:58 -0700 (PDT)
In-Reply-To: <542FBF1B.9050500@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gilles Hemberg <gilles.hemberg@gmail.com>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> It works!
>
>
>
> Solution (in OpenElec 4.2.0; settings on other distros would be similar):
> * Create custom asound.state in /storage/.config/ with the following
contents:http://sprunge.us/SiHH(this state-file will, among other things,
unmute the appropriate mixer controls, set proper output formats, ...).
>
> * Load the above state file with the following command:
>
>     alsactl nrestore 0 -f /storage/.config/asound.state
>     (replace the "0" with the card-number corresponding to CK804 on your
system)
>
>   You may want to add this command to a custom autostart.sh in
/storage/.config/ so the state is restored on every boot.
>
> * Create intel8x0.conf in /storage/.config/modprobe.d/ with the following
contents:
>
>     options snd-intel8x0 spdif_aclink=1
>     (I am told that this above setting depends on the specific
motherboard, so this may not work for everyone: it does work on my ASUS
A8N-SLI Deluxe)
>
>   This was the final setting that solved the issue for me. I did try this
setting before, but it seems that some sources on the Internet had this
mis-written as "options snd-intel-8x0 spdif_aclink=1" (notice the extra
dash).
>
> * In XBMC, select the SPDIF out as both the audio-device AND the
passthrough device.
>
>

Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:04.0 0401: 10de:0059 (rev a2)
Subsystem: 1043:812a

You can add pci subsystem id into spdif_aclink_defaults

static struct snd_pci_quirk spdif_aclink_defaults[] __devinitdata = {
SND_PCI_QUIRK(0x147b, 0x1c1a, "ASUS KN8", 1),
{ } /* end */
};

>> >>
>> >> Simple mixer control 'IEC958 Playback AC97-SPSA',0
>> >>   Capabilities: volume volume-joined
>> >>   Playback channels: Mono
>> >>   Capture channels: Mono
>> >>   Limits: 0 - 3
>> >>   Mono: 0 [0%]

Does it use slot front left and front right slots for pcm playback?

Does it use spdif left/right slot for ac3 passthrough?  default for alc850
after cold boot

Can it get signal from the other two setting : rear left/right slot or
center/lfe slot?
