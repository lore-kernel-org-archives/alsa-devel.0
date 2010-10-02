From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: asihpi: Control naming
Date: Sat, 2 Oct 2010 12:10:26 +0800
Message-ID: <AANLkTikZ7tHB2YhBT496DSvSCE85Qm-s3dfVLPVwCXLb@mail.gmail.com>
References: <4CA4078E.6010601@audioscience.com> <s5h62xng4wm.wl%tiwai@suse.de>
	<4CA4F1D8.50800@audioscience.com> <s5haamz9che.wl%tiwai@suse.de>
	<4CA5010E.4050705@gmx.de> <4CA58856.8070505@ladisch.de>
	<4CA5C69B.4000703@gmx.de> <4CA5DFFC.40004@ladisch.de>
	<4CA63F38.7000307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6008624554
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 06:10:27 +0200 (CEST)
Received: by eye27 with SMTP id 27so1495382eye.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 21:10:27 -0700 (PDT)
In-Reply-To: <4CA63F38.7000307@gmx.de>
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

2010/10/2 Sebastian H. <vand2@gmx.de>

> Am 01.10.2010 15:19, schrieb Clemens Ladisch:
> > Sebastian H. wrote:
> >> Am 01.10.2010 09:05, schrieb Clemens Ladisch:
> >>> Those are elements where the simple mixer code doesn't know the
> >>> direction (because the driver author didn't put "Playback" or "Capture"
> >>> into the name).
> >>
> >> Ok, but I wonder how to interpret this state in which both functions
> >> return zero.
> >
> > There are cases where the playback/capture direction is obvious from the
> > name ("just implement an AI!"), but these can be considered bugs.
>
> Ok, I'll stick to the element name list from Raymond then for an
> automated detection.
>

I just only mention the keywords in those capture controls in sound card
drivers.
They may have slightly different name (e.g. 'Mic Boost (+20dB)' , 'Front Mic
Boost' )


In simple_none.c , it also defined some keywords for stanard ac97 control
too

some of them are used (e.g. "3D Control - Switch" is regarded a pswitch) but
"Depth and Rear Depth are regarded as volume )


Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control '3D Control Sigmatel - Depth',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]
Simple mixer control '3D Control Sigmatel - Rear Depth',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]

They are just 3D effect and have no dB information.

However alsa-python return run-time error when you try to use the function
get_volume_range_dB() to find out whether the mixer elem has dB Info or not



>
> > In the other cases, the control really doesn't belong to a direction.
> > (Which doesn't prevent many mixers that have two pages from just
> > throwing them in with the playback controls.)
>
> Bringing up a separate page for rare *general* elements doesn't seem
> worthwile then and the *playback* page should be fine.
>
> Cheers,
> Sebastian
>
>
