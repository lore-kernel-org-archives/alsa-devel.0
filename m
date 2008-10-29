From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: Warn when control names are truncated
Date: Wed, 29 Oct 2008 19:31:25 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810291757060.12044@tm8103.perex-int.cz>
References: <1225291230-17812-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5habcnmpb1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0810291548310.12044@tm8103.perex-int.cz>
	<s5h8ws7moxa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 26F8F2441A
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 19:31:26 +0100 (CET)
In-Reply-To: <s5h8ws7moxa.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Oct 2008, Takashi Iwai wrote:

> At Wed, 29 Oct 2008 15:51:40 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Wed, 29 Oct 2008, Takashi Iwai wrote:
> > 
> > > At Wed, 29 Oct 2008 14:40:30 +0000,
> > > Mark Brown wrote:
> > > > 
> > > > This is likely to confuse user interfaces since the end of the control
> > > > name is interpreted (eg, "Volume", "Switch").
> > > > 
> > > > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > 
> > > Thanks, applied now.
> > > 
> > > 
> > > > +		if (strcmp(ncontrol->name, kctl.id.name) != 0)
> > 
> > Maybe better is to just use end char comparsion to save few CPU ticks:
> > 
> > if (kctl.id.name[sizeof(kctl.id.name)-2] != '\0' &&
> >     ncontrol->name[sizeof(kctl.id.name)-1] != '\0')
> 
> No, this may cause segfault

How? The first check in the fixed size variable initialized with zeros 
allocated on heap ensures that ncontrol->name string is at least 
sizeof(kctl.id.name) long. There is no possibility of segfault.

> (and way too hacky to understand what's the purpose of the code...)

The printk explains check nicely.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
