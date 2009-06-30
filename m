From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: External PCM hook SO is dlclosed after
	calling	install, making it hard to have hooks in it
Date: Tue, 30 Jun 2009 10:38:04 +0400
Message-ID: <20090630063804.GF23025@home.pavel.comp>
References: <20090629221101.GD23025@home.pavel.comp>
	<s5hd48mi76e.wl%tiwai@suse.de>
	<20090630062054.GE23025@home.pavel.comp>
	<s5hab3qi638.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f210.google.com (mail-bw0-f210.google.com
	[209.85.218.210])
	by alsa0.perex.cz (Postfix) with ESMTP id F2DC910385F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 08:38:56 +0200 (CEST)
Received: by bwz6 with SMTP id 6so1150279bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 23:38:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hab3qi638.wl%tiwai@suse.de>
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
Cc: Joerg Reisenweber <joerg@openmoko.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 30, 2009 at 08:33:15AM +0200, Takashi Iwai wrote:
> > It looks like we're talking about different things. You seem to be
> > talking about external PCM plugins, i'm talking about external functions
> > for the "hook" PCM plugin. The code i question is in pcm/pcm_hooks.c
> > in function snd_pcm_hook_add_conf:
> > 
> >         if (err >= 0) {
> >                 if (args && snd_config_get_string(args, &str) >= 0) {
> >                         err = snd_config_search_definition(root,
> >                 "hook_args", str, &args);
> >                         if (err < 0)
> >                                 SNDERR("unknown hook_args %s", str);
> >                         else
> >                                 err = install_func(pcm, args);
> >                         snd_config_delete(args);
> >                 } else
> >                         err = install_func(pcm, args);
> >                 snd_dlclose(h);
> >         }
> 
> Ah, I understand now.  Yes, this looks like a bug.
> Meanwhile, it makes another bug if we just remove it.  There would be
> no dlclose(), then.  It'd need resource tracking.

Exactly the reason i haven't tried to make a proper patch ;)

>  A lack of dlclose is no serious bug, though.

I hope you know better than me ;)

> So... just removing snd_dlclose() there fixes your problem?
> If yes, I'll commit the fix.

TBH, i've not tried but i'm pretty sure it will fix the problem. I
tried with dlopen workaround (to increase the refcounter) in install
function and i tried with LD_PRELOAD'ing the library before starting
an alsa app; both workarounds worked.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
