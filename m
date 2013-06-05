From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: CONFIG_SND_DEBUG
Date: Wed, 5 Jun 2013 10:11:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306051008410.1078-100000@iolanthe.rowland.org>
References: <s5h4ndcvl4a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id D6A18265493
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:11:14 +0200 (CEST)
In-Reply-To: <s5h4ndcvl4a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>, Kernel team list <kernel-team@lists.ubuntu.com>, Andy Whitcroft <apw@canonical.com>, leann.ogasawara@canonical.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Jun 2013, Takashi Iwai wrote:

> > >> Andy/Leann - apparently CONFIG_SND_DEBUG is on by default from
> > >> upstream, and we explicitly disable it. Is there any reason why we
> > >> do that?
> > >
> > > config SND_DEBUG
> > >          bool "Debug"
> > >          help
> > >            Say Y here to enable ALSA debug code.
> > >
> > > It is off by default in upstream, and the really helpful description
> > > would cirtainly tend to lead to it being disabled.  But if it is helpful
> > > to your debugging efforts David then I suspect we can enable it in Saucy
> > > and see what happens.
> > 
> > Okay, so then the ball is back in Takashi's area - if we're recommended 
> > to turn CONFIG_SND_DEBUG on, why is it off by default in the upstream 
> > Linux kernel?
> 
> It's not off as default.  Simply there is no default, just like most
> of other options.
> 
> As already mentioned, if the device is known to work well with the
> kernel, there is no reason to set it on.  Then it'll saves the memory
> and code space.  That is, for custom kernels, it's good to be off.
> But for generic kernels like distro kernel, it'd be better to take a
> safer side with more safety checks that is built in by that option.

Given this description, the symbol's name is very misleading.  Instead 
of being called CONFIG_SND_DEBUG, it should be called 
CONFIG_SND_SAFETY_CHECKS or something like that.

IMO, distributions are completely justified in turning off any symbol 
which is named (and described in the help text!) as being used for 
debugging only.

Alan Stern
