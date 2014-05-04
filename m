From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Regression Intel Corporation Haswell-ULT HD Audio
	Controller
Date: Sun, 4 May 2014 11:09:49 +0800
Message-ID: <CAN8cciaBw0CZ7VhCs2XnRgKaE_KXZ-B7rLhLxG_Y7NfGUX6o1g@mail.gmail.com>
References: <CANNJ_zh6HXT-pdkOV9XpDor3J1aFVbi3zbHLyDnpgisu7DdMdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 190E32617BB
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 05:09:50 +0200 (CEST)
Received: by mail-qc0-f181.google.com with SMTP id m20so3214237qcx.26
 for <alsa-devel@alsa-project.org>; Sat, 03 May 2014 20:09:49 -0700 (PDT)
In-Reply-To: <CANNJ_zh6HXT-pdkOV9XpDor3J1aFVbi3zbHLyDnpgisu7DdMdA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Delcypher <delcypher@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I'm having an issue with " Intel Corporation Haswell-ULT HD Audio
> Controller" card which is inside the Dell XPS13 9333 developer edition
> [1].
>
> I've tried two different distributions
>
> * Arch Linux (kernel 3.14)
> Output of alsa-utlils-alsa-info.sh [2]
>
> * Ubuntu 14.04 LTS (kernel 3.13)
> Output of alsa-utlils-alsa-info.sh [3]
>
> The card behaves correctly under Ubuntu but under Arch Linux I've
> observed the following issues.
>
> - The microphone does not work correctly. In alsamixer I select
> "Internal Mic" as my capture device but when I do
>
>
how many audio jacks do your laptop have ?

/sys/class/sound/hwC1D0/init_pin_configs:
0x12 0x90a60140
0x14 0x90170110
0x15 0x0321101f
0x16 0x40000000
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40d6832d
0x1e 0x411111f0
0x1f 0x411111f0

/sys/class/sound/hwC1D0/driver_pin_configs:
0x19 0x03a1913d
0x1b 0x03a1113c


seem driver assign sequence number c and d to some of the pin to indicate
support of headset mic and headphone mic

do your laptop specification support headset, headphone or mic if your
laptop has only one jack ?

http://voices.canonical.com/david.henningsson/2014/03/07/headset-jacks-on-newer-laptops/

did the dialog popup ?

I've also tried enabling/disabling "CAPTURE" on the Capture channel at
> the same time - I don't really understand why this channel is here
> (seems a little bizarre) but enabling/disabling "CAPTURE" on this
> channel doesn't seem to make any difference anyway. Under Ubuntu the
> "arecord... aplay" command works correctly.
>
> - There probably isn't a way to reproduce this but when I first
> installed Arch Linux the sound card was put in a state where the
> headphone jack would not work at all. Sound would continue playing out
> of the speakers when the headphone jack was inserted and no sound
> would come out of the headphones. I did notice that if the headphone
> jack was only partially inserted I would get some sound sent to one of
> the headphones.
>
> My intuition is that the card is probably being incorrectly
> initialised because if you take a look at the output of
> alsa-utils-alsa-info.sh and diff them. Two very big differences I
> noticed were that
>
>
> One interesting I did notice is that under Arch Linux it is possible
> to use the microphone from the Audacity program by selecting "HDA
> Intel PCH: ALC3661Analog (hw0:0) Internal mic:0" as the input (this is
> not the default). Unfortunately I know of no way to make other
> applications use this.
>
> Any thoughts on how to fix this?
>
> [1] http://www.dell.com/uk/business/p/xps-13-linux/pd
> [2] https://gist.github.com/delcypher/11367224
> [3] https://gist.github.com/delcypher/11367302
>
>
