From: James Gardiner <renidragsemaj@yahoo.com>
Subject: Re: [ALSA - patch_sigmatel.c for HP dv4-1222nr laptop
	9/9Patch to patch_sigmatel.c for HP dv4-1222nr laptop
Date: Thu, 16 Apr 2009 22:39:35 -0700 (PDT)
Message-ID: <730476.70849.qm@web54507.mail.re2.yahoo.com>
References: <s5hprff2xew.wl%tiwai@suse.de>
Reply-To: renidragsemaj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web54507.mail.re2.yahoo.com (web54507.mail.re2.yahoo.com
	[206.190.49.157])
	by alsa0.perex.cz (Postfix) with SMTP id DD3891037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 07:39:36 +0200 (CEST)
In-Reply-To: <s5hprff2xew.wl%tiwai@suse.de>
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





--- On Tue, 4/14/09, Takashi Iwai <tiwai@suse.de> wrote:

> 
> Thanks for the patch.  The change looks almost good to me.
> See some comments below
>
>
> 
> > +		spec->num_dmics = 1;
> > +		spec->num_dmuxes = 2;
> > +		stac92xx_auto_set_pinctl(codec, 0x1c, 2);
> 
> The number "2" doesn't look cute... 
> 
> Could you fix and repost the patch?
> 
> 
> thanks,
> 
> Takashi

Are you worried it looks like a magic number? Or am I supposed to be looking for something else?  Or would a '#define' be more what you're talking about?

Oh, and by the way, I figured out what pulseaudio was doing. I still don't like it, but it seems to be the norm for it.

Can you (simple) explain to me what the PCI_QUIRK stuff does? I've tried adding to it to get the autodetect to work and I really don't know what I'm doing there. If not, manual setting is fine, I just wanted to make the patch work automatically. I've read the source, read your driver handbook, and I still don't get it. :P

Thanks,
James
