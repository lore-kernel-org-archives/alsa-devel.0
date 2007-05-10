From: "xinyun liu" <xinyunliu.osc@gmail.com>
Subject: Re: detect extern/internel mic
Date: Fri, 11 May 2007 04:24:22 +0800
Message-ID: <afc365e50705101324nd532b2bk6d6db4a84075a372@mail.gmail.com>
References: <afc365e50705090943k23f5e482k672b59101cd587b2@mail.gmail.com>
	<s5hmz0ej5fs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 51B5E24406
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 22:24:24 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so708988nzf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 13:24:23 -0700 (PDT)
In-Reply-To: <s5hmz0ej5fs.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have test on my laptop by playing a long .wav file.

During playing, I plugged the external headphone, and the sound is
continuously and switch from external headphone to internal speaker.
It uses hda-intel driver. Does this mean it's the hardware do it?

Thx

2007/5/10, Takashi Iwai <tiwai@suse.de>:
> At Thu, 10 May 2007 00:43:07 +0800,
> xinyun liu wrote:
> >
> > It's interesting that when I plug in a headphone or an external
> > microphone, the build in headphone and microphone will not work.
> >
> > Is it a driver feature or the hardware do it?
> >
> > Can anyone give some clue? I'd like to see the code but don't know how
> > to start. Please give me help. Thx!
>
> Needs more hardware information of your device for better diagnosis.
>
> I guess it's a hardware, but some hda-intel drivers do that by
> themselves for usability, for example.
>
>
> Takashi
>
