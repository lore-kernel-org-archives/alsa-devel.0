From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: No sound on Acer Aspire 6935G
Date: Tue, 28 Apr 2009 23:46:57 +0800
Message-ID: <4b8c423b0904280846r3c29c402ic54c4d1004ffe8f4@mail.gmail.com>
References: <4b8c423b0904250904i226fd458we275c263475a3b8c@mail.gmail.com>
	<s5hpreyh1bh.wl%tiwai@suse.de>
	<4b8c423b0904271901i2f32a3e2r40a8b3f481e46a1d@mail.gmail.com>
	<s5h63gp2usp.wl%tiwai@suse.de>
	<4b8c423b0904272308o5baaf3e0v703016169372a4c9@mail.gmail.com>
	<s5hws951esg.wl%tiwai@suse.de>
	<4b8c423b0904280744r1f0f08adn63d581fe2120c78d@mail.gmail.com>
	<s5hws9425r2.wl%tiwai@suse.de>
	<4b8c423b0904280810ie07e7d3h28f16df90708e5da@mail.gmail.com>
	<s5hocug2491.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D62010386F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:46:58 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so397845yxn.2
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 08:46:57 -0700 (PDT)
In-Reply-To: <s5hocug2491.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using the ubuntu stock kernel.. Should i compile a custom kernel with
this option?

Regards,
Karthik

On Tue, Apr 28, 2009 at 11:21 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 28 Apr 2009 23:10:03 +0800,
> Karthik Ramgopal wrote:
> >
> > The only line about the audio from dmesg is:
> >
> > [   39.421278] hda-intel: IRQ timing workaround is activated for card #0.
> > Suggest a bigger bdl_pos_adj.
>
> Did you set CONFIG_SND_DEBUG=y kernel config?
>
>
> Takashi
>
> > On Tue, Apr 28, 2009 at 10:49 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     At Tue, 28 Apr 2009 22:44:25 +0800,
> >     Karthik Ramgopal wrote:
> >     >
> >     > cat /sys/modules/snd_hda_intel/parameters/model gives
> >     >
> >     > acer-aspire-4930g,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
> >
> >     And how is the kernel message?
> >
> >     Takashi
> >
> >
>
