From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] - ALSA hda ad1988 - Add Independent HP
	Switch to model 6stack-dig-fp
Date: Fri, 29 Apr 2011 22:36:24 +0800
Message-ID: <BANLkTimRTixd=5CbAmSVbKkisvG2S1qVMQ@mail.gmail.com>
References: <BANLkTinM2ae5t-egbJbMKwxLM-fKBqL1sg@mail.gmail.com>
	<s5h8vuxcnfq.wl%tiwai@suse.de>
	<BANLkTimxoGNJT+GwF0mM_w92GYB5AU23Pw@mail.gmail.com>
	<s5hoc3q8q5c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C2D8A1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 16:36:24 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2901101fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2011 07:36:24 -0700 (PDT)
In-Reply-To: <s5hoc3q8q5c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/28 Takashi Iwai <tiwai@suse.de>


> > As for the upmixing feature, I wonder why no one complain about sending
> left
> > channel to the center and right channel to subwoofer
>
> Well, maybe because usually you set up 5.1 properly when you have such
> systems, then upmixing right in the backend, not in the driver.
>
>
I  have Creative 4.1 speakers which only has green and black jacks.

Refer to commit d29240ce57d96db7300360d1e6f18357810a5c2b

hda-intel driver unconditionally assigns the stream to multiple output pins
in copy-front mode

I can hear the stereo in all 4 jacks in rear panel because of copy-front
mode even in OSS emulation

This is why ad1988 still can use "Headphone Playback Volume" at DAC0 when
switch off "independent Headphone"f
