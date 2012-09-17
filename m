From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Mon, 17 Sep 2012 16:44:16 +0800
Message-ID: <CAN8cciZQyzsvNRNQdP++vga5CypWWM584agfWts78FqSN5WuUw@mail.gmail.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <s5hligmw3s0.wl%tiwai@suse.de> <5049D9EB.5070301@canonical.com>
 <s5h8vcmvy9s.wl%tiwai@suse.de> <5049E5F6.8010007@canonical.com>
 <s5h1uievwk6.wl%tiwai@suse.de> <5049ECD4.2040501@canonical.com>
 <CAN8cciYOMpjXfEpQxYFwTve94rz_LLzJyA=nBdCCdtwOJ5Lnbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6328C26165D
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 10:44:17 +0200 (CEST)
Received: by qcse14 with SMTP id e14so5036672qcs.38
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 01:44:16 -0700 (PDT)
In-Reply-To: <CAN8cciYOMpjXfEpQxYFwTve94rz_LLzJyA=nBdCCdtwOJ5Lnbw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, ian_minett@creativelabs.com, 995156@bugs.launchpad.net, 1033996@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

>>>>>> But I still wonder why PulseAudio cares the headphone jack state even
>>>>>> though this has only one output at all?
>>>>>
>>>>>
>>>>> When seeing the system as a whole, there can be other outputs on other
>>>>> cards - HDMI, USB etc. If somebody e g plugs a USB headset in it will
be
>>>>> simpler for the user if PulseAudio does not also show the unplugged
3.5
>>>>> mm jack

phantom port of internal speaker or internal Mic is ok but

how about those jack spdif, CD , Aux which does not have jack detect
circuit

Is it feasible for driver implement a read/ write kcontrol for those port
and allow the user to change the state of those port by using special
application (e.g. qashctl) ?

>
> That said, it's not super difficult to comment out a few lines in
> /usr/share/pulseaudio/alsa-mixer/paths/*.conf, and also, most mixer UIs
(e g pavucontrol) still allows you to route audio to an unavailable port.

For ad1988 which still not support auto mute nor hda jack detect. The user
still able to use the card in gnome but not in unity.

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/995169

And ca0132 which does not implement auto mute ?

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1043621

And the other ad198x which support auto mute but not implement hda jack
detect

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1051494

The other cases are those on-board ac97 controller (e.g.  Intel8x0,
atiixp,...) with ac97 codecs which have the headphone playback volume
control.

What is the usage of those "Headphone Jack Sense" control of AC97 codecs ?
Some of them seem have inverted control

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1033996
