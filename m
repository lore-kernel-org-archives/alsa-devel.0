From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 1/2 v2] ALSA: Add snd_ctl_update() to
 dynamically update a control
Date: Wed, 16 Mar 2011 08:56:36 +0800
Message-ID: <AANLkTin0kRE-iD1XXcJ+5-R+uuCZj7MFQ4OZ1nyR8ek-@mail.gmail.com>
References: <1300192269-20435-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4D7F7516.7050009@ladisch.de> <s5hipvkea0v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3B8D2244C6
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 01:56:43 +0100 (CET)
Received: by fxm6 with SMTP id 6so1123637fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 17:56:39 -0700 (PDT)
In-Reply-To: <s5hipvkea0v.wl%tiwai@suse.de>
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

2011/3/15 Takashi Iwai <tiwai@suse.de>

> At Tue, 15 Mar 2011 15:17:58 +0100,
> Clemens Ladisch wrote:
> >
> > > +   up_write(&card->controls_rwsem);
> > > +   ret = snd_ctl_add(card, kcontrol);
> >
> > Doing this outside the semaphore doesn't look good.
>
> Using an internal function without semaphore would be preferred, yes.
>
> > I wonder whether snd_ctl_add() is the right function to use, because it
> > will assign a different numid event if the control didn't change.
>
> Hm, actually the function can compare whether it's really changed or
> not.  If any change, it makes really sense to assign a different
> numid.
>
>
>

does it mean that the driver can update "Input Source" controls for those
HDA codec on a motherboard with 3 audio jacks at rear panel ?

i.e. remove/add "Rear Mic" and "Line in" from/to "Input Source" when user
switch "channel_mode" between 2 and 6 or  switch"smart51" on/off
