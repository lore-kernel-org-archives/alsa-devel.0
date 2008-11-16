From: "Andrei Tanas" <andrei@tanas.ca>
Subject: Re: digital audio on ASUS P5QL-EM motherboard
Date: Sun, 16 Nov 2008 12:45:12 -0500
Message-ID: <006001c94813$134a8880$39df9980$@ca>
References: <6d799ca1be9af898f664f82ade06d669@localhost>
	<20081115002724.GA5073@mail.ustc.edu.cn>
	<002f01c94770$adeba2a0$09c2e7e0$@ca>
	<20081116021525.GA7795@localhost>
	<003801c947b4$b857ffb0$2907ff10$@ca>
	<20081116082733.GA20129@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FE7245B5
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 18:45:01 +0100 (CET)
In-Reply-To: <20081116082733.GA20129@localhost>
Content-Language: en-ca
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Wu Fengguang' <fengguang.wu@gmail.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > How did you find out that it's 0x10 instead of 0x06? Has
> documentation on
> > ALC1200 become available?
> 
> It's easy:
> grep -i -C6 spdif /proc/asound/card0/codec\#0
> grep -i -C6 'stereo digital' /proc/asound/card0/codec\#0
> 
> And check the connectivity between pin complex and audio output nodes.
That's the kind of stuff that would be great to know for somebody who wants
to troubleshoot something for the first time. Thanks.


> Now you can do a 'cat /proc/asound/card0/codec\#1' and read about the
> HDMI codec. For it to work, you may need the bleeding edge Xorg
> drivers.
That will be for somebody else to test I guess, I don't have the hardware -
it turns out my TV does not take digital audio through its HDMI port.


> So let's create a new model?
I should have gave it a shot myself I guess.

> +#define ALC883_DIGOUT_NID_ASUS_P5Q	0x10
Why not ALC1200_DIGOUT_NID? Or is it really specific to Asus P5Q?

The patch worked perfectly.

Thank you,
Andrei.

Dmesg:
[    8.666785] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #0
probed OK
[    8.666912] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #1
probed OK
[    8.668891] ALSA sound/pci/hda/hda_codec.c:2612: hda_codec: model
'asus-p5q' is selected for config 1043:82fe (Asus P5Q-EM HDMI)
