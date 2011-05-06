From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
	Headphone with realtek codec
Date: Fri, 6 May 2011 11:30:16 +0800
Message-ID: <BANLkTinz8=YMH0sE35abu_cneaJpra_eEg@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<s5hoc3hmq0b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3692624426
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 05:30:17 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2264266fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 20:30:17 -0700 (PDT)
In-Reply-To: <s5hoc3hmq0b.wl%tiwai@suse.de>
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

2011/5/5 Takashi Iwai <tiwai@suse.de>

> At Wed, 4 May 2011 23:42:24 +0800,
> Raymond Yau wrote:
> >
> > Request for testers to test the patch
> >
> > Multistreaming allows you to listen to one audio source through the back
> > panel speakers and a second audio source through front panel headphones
> or
> > speakers.
> >
> > Hardware requirement
> > 1) 10 channels realtek codec (e.g. alc892) which already work with
> > model=auto
> > 2) Headphone at front panel and Line out at rear panel
> >
> > "hw:0,0" is used for the rear panel audio jack
> > "hw:0,2" is used for the front panel headphone when "Independent HP" is
> > switched ON
>
> I'd name it differently, e.g. "Headphone Stream Mode" taking "Slave" and
> "Independent", or such.  An enum with "ON" and "OFF" is no sensible choice.
>
>
> Takashi
>

Use "Independent HP" just because patch_via.c already used it so it is
better to use a standard name for all hda codecs
