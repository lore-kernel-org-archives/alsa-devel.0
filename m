From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC Patch] ALSA - EMU10K1 - Remove Center LFE
 Wave Center and Wave LFE control for SB Live! Platinum
Date: Tue, 5 Apr 2011 17:44:30 +0800
Message-ID: <BANLkTik6RpZG-WFPvY0GHEe_j+ne=cEnPQ@mail.gmail.com>
References: <AANLkTikxq8K=91jGGqKsmb=0A8tELF_d_wH7O05sjwRr@mail.gmail.com>
	<s5hbp0mtgwk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9CC2F2436A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 11:44:30 +0200 (CEST)
Received: by fxm5 with SMTP id 5so150405fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2011 02:44:30 -0700 (PDT)
In-Reply-To: <s5hbp0mtgwk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/4 Takashi Iwai <tiwai@suse.de>

> At Wed, 30 Mar 2011 20:50:51 +0800,
> Raymond Yau wrote:
> >
> > SB Live! Platinum CT4760P is just a 4 channels sound card with STAC9721
> and
> > Philips UDA1334 DAC
> >
> > Is it feasible to remove "Center" , "LFE", "Wave Cetner" and "Wave LFE"
> > Playback Volume control ?
> >
> > or add a bitmap to disable the creation of those controls
> >
> > Anyone know whether this patch has any side effect for the user with
>  Live
> > Drive
>
> The side-effect is that opening surround51 would spew annoying error
> messages as you've seen.  It should return an error without much
> complaint.
>
> I'm not sure what is the best way to solve it.
> Defining another conf such as EMU10K1-4ch.conf would be an option,
> but it's not elegant...
>
>
The side effect is not related to my patch but exout

#define EXTOUT_HEADPHONE_L 0x06 /* LiveDrive - Headphone - left */
#define EXTOUT_HEADPHONE_R 0x07 /* LiveDrive - Headphone - right */

I just follow Documentation/ALSA-Configuration.txt to set extout to 0x1f03
for my SB Live! Platinum without Live! Drive


Input & Output configurations [extin/extout]

* Creative Card wo/Digital out [0x0003/0x1f03]
* Creative Card w/Digital out [0x0003/0x1f0f]
* Creative Card w/Digital CD in [0x000f/0x1f0f]
* Creative Card wo/Digital out + LiveDrive [0x3fc3/0x1fc3]
* Creative Card w/Digital out + LiveDrive [0x3fc3/0x1fcf]
* Creative Card w/Digital CD in + LiveDrive [0x3fcf/0x1fcf]
* Creative Card wo/Digital out + Digital I/O 2 [0x0fc3/0x1f0f]
* Creative Card w/Digital out + Digital I/O 2 [0x0fc3/0x1f0f]
* Creative Card w/Digital CD in + Digital I/O 2 [0x0fcf/0x1f0f]
* Creative Card 5.1/w Digital out + LiveDrive [0x3fc3/0x1fff]
* Creative Card 5.1 (c) 2003 [0x3fc3/0x7cff]
* Creative Card all ins and outs [0x3fff/0x7fff]


As Philips UDA1334 has no hardware volume control

The problem is pulseaudio expect the Front Channel and Rear Channels volume
controls have same dB range


Card hw:1 'Live'/'SB Live! Platinum [CT4760P] (rev.7, serial:0x80401102) at
0xb880, irq 23'
  Mixer name    : 'SigmaTel STAC9721,23'
  Components    : 'AC97a:83847609'
  Controls      : 198
  Simple ctrls  : 30
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Tone',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Bass',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 21 [52%]
  Front Right: 21 [52%]
Simple mixer control 'Treble',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 20 [50%]
  Front Right: 20 [50%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control '3D Control Sigmatel - Depth',0
  Capabilities: pvolume pvolume-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 0 [0%]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [on]
  Front Right: Playback 23 [74%] [0.00dB] [on]
Simple mixer control 'Front',0
  Capabilities: cvolume cswitch cswitch-joined penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 2147483647
  Front Left: Capture 0 [0%] [-99999.99dB] [off]
  Front Right: Capture 0 [0%] [-99999.99dB] [off]
Simple mixer control 'Surround',0
  Capabilities: pvolume cvolume cswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 2147483647 Capture 0 - 2147483647
  Front Left: Playback 2147483647 [100%] [0.00dB] Capture 0 [0%]
[-99999.99dB] [off]
  Front Right: Playback 2147483647 [100%] [0.00dB] Capture 0 [0%]
[-99999.99dB] [off]
