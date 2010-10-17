From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Per Application Volume Control plugin for
	ALSA
Date: Sun, 17 Oct 2010 19:20:03 +0800
Message-ID: <AANLkTimCiGAp_ayBWbBT+4-GSUqbhmztTtH9Hth_TBeL@mail.gmail.com>
References: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
	<s5hsk05urj6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 04821244D8
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 13:20:03 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1399365ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 04:20:03 -0700 (PDT)
In-Reply-To: <s5hsk05urj6.wl%tiwai@suse.de>
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

2010/10/17 Takashi Iwai <tiwai@suse.de>

> At Wed, 29 Sep 2010 18:56:59 +0200,
> James Huk wrote:
> >
> > Hello everybody.
> >
> > This is my first "post" here, so please be "gentle".
> >
> > I have created PAVC plugin for ALSA, it is based on COPY plugin, and
> > use SOFTVOL plugin for sound output. As far as I can tell from current
> > tests - It works perfectly, and it doesn't break compatibility with
> > any apps I use (and PulseAudio does). So I was wondering - is there
> > any chance this plugin would be added to the next official ALSA
> > release?
> >
> > Here is the patch that enables it on current alsa-lib-1.0.23
> > (hopefully this mailing list is a good place to "post" this):
>
> Thanks for the patch.  I looked over this post until now.
>
> The idea is interesting, and I thought of a similar thing before PA
> gets popularized, too.
>
> Though, this implementation is a bit too hackish, especially the part
> using pipe & co.  If we have a more simpler and cleaner way for this,
> it's worth including to the standard plugin, I think.
>
>
> thanks,
>
> Takashi
>

Is it possible to implement per voice cvolume control for dmix similar to
those per voice volume control of those hardware mixing sound cards ?

does dmix allow an application open at least 16 voices ?
