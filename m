From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Wed, 14 Mar 2012 08:50:53 +0800
Message-ID: <CAN8cciZqB3oVVGMS4=RBSGZH+nSJAZoUT_a8hFu=pBnNJ3gwfw@mail.gmail.com>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
	<CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
	<87zkc1cvaa.fsf@ti.com>
	<CAN8ccib90y8m0KLTYKe7Jz5sXVZFY=D7aUwm8vog3aZvZPHH0Q@mail.gmail.com>
	<874nu99k9y.fsf@ti.com>
	<CAN8cciayARuQGLH=DHsReH0sYbz92K3BPNhmNEqYmSjc6wUUVw@mail.gmail.com>
	<87d38wfag6.fsf@ti.com>
	<CAN8cciaB6-GUvsPS8+bpftLb7BaawdpCsgY3Z7R9H+XdkJ8LNA@mail.gmail.com>
	<87booesssh.fsf@ti.com>
	<CAN8ccibbw109Sxb_X_ZKVO4GnpVUfbEyK0yyM8g90g8K8v4Jtw@mail.gmail.com>
	<87zkbvne5k.fsf@ti.com>
	<CAN8cciaEKB2Gf3n6NWFkoJmk=kuH6nNHJYLqQtoRiiPmfLcFcw@mail.gmail.com>
	<s5h62eiqlcn.wl%tiwai@suse.de> <87399lfpef.fsf@ti.com>
	<s5h1up5qxmc.wl%tiwai@suse.de> <87ipid4rvv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 656B8103AC1
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 01:50:54 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so5224773wib.2
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 17:50:54 -0700 (PDT)
In-Reply-To: <87ipid4rvv.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/10, Kevin Hilman <khilman@ti.com>:
>
> Ah, that's a little easier to tinker with for the uninformed like me. :)
>
> Using that, it seems that the above registers work on my coded (cs4206)
> too.  I was able to determine that the built-in mic is ADC2 right
> channel, and can at least make the built-in mic switch from the right to
> left (swap channel mode)
>
>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x180a
>
> or make the right channel go to both HDA channels (mono mode):
>
>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x100a
>
> However, I still can't figure out where the headset mic is and how to
> enable it.
>
> Here's what I think I know (c.f. alsa-info.sh  output below)
>

do you mean that you cannot record mono using sysdefault  which use a
route to copy left channel channel to both if the internal mic is at
the right channel?

arecord --vumeter=mono -c 1 -f S16_LE -r 48000 -Dsysdefault /dev/null
