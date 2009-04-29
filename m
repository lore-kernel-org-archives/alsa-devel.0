From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: No sound on Acer Aspire 6935G
Date: Wed, 29 Apr 2009 10:16:29 +0800
Message-ID: <4b8c423b0904281916o6e292a1dp68d5fd23e41c1429@mail.gmail.com>
References: <4b8c423b0904250904i226fd458we275c263475a3b8c@mail.gmail.com>
	<s5hws951esg.wl%tiwai@suse.de>
	<4b8c423b0904280744r1f0f08adn63d581fe2120c78d@mail.gmail.com>
	<s5hws9425r2.wl%tiwai@suse.de>
	<4b8c423b0904280810ie07e7d3h28f16df90708e5da@mail.gmail.com>
	<s5hocug2491.wl%tiwai@suse.de>
	<4b8c423b0904280846r3c29c402ic54c4d1004ffe8f4@mail.gmail.com>
	<s5hljpksp9v.wl%tiwai@suse.de>
	<604760770904281334x4e0e00d2p130ef4c95a032deb@mail.gmail.com>
	<s5hr5zcihnv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5954924362
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 04:16:30 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so601324ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 19:16:29 -0700 (PDT)
In-Reply-To: <s5hr5zcihnv.wl%tiwai@suse.de>
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
Cc: Daniel Chen <seven.steps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I will recompile with the --with-debug option enabled and report my results
soon. But how to do this via the proc file?

thanks,
Karthik

On Wed, Apr 29, 2009 at 5:37 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 28 Apr 2009 16:34:03 -0400,
> Daniel Chen wrote:
> >
> > The stock ubuntu kernel has sound debugging disabled.
>
> I recommend to turn at least CONFIG_SND_DEBUG on.
> CONFIG_SND_DEBUG_VERBOSE would be too much, but CONFIG_SND_DEBUG is
> just for basic information.
> Also CONFIG_SND_DEBUG_XRUN would be good to have.  It alone won't do
> any harm unless you turn on the feature via proc file.
>
>
> thanks,
>
> Takashi
>
> >
> >     On Apr 28, 2009 12:43 PM, "Takashi Iwai" <tiwai@suse.de> wrote:
> >
> >     At Tue, 28 Apr 2009 23:46:57 +0800,
> >
> >     Karthik Ramgopal wrote: > > I am using the ubuntu stock kernel..
> Should i
> >     compile a custom kernel w...
> >
> >     Better to check the kernel config of the running kernel first.
> >
> >     Takashi
> >
> >     > > Regards, > Karthik > > On Tue, Apr 28, 2009 at 11:21 PM, Takashi
> Iwai
> >     <tiwai@suse.de> wrote: ...
> >
> >
>
