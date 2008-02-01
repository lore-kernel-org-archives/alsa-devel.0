From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: Re: Intel ICH Modem init fails for laptop built-in	SiS
	modem
Date: Fri, 01 Feb 2008 13:00:43 +0000
Message-ID: <1201870843.2956.14.camel@castor.localdomain>
References: <1201797931.2968.16.camel@castor.localdomain>
	<s5h7iho3lge.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa0.perex.cz (Postfix) with ESMTP id E8ADD24479
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 14:00:46 +0100 (CET)
In-Reply-To: <s5h7iho3lge.wl%tiwai@suse.de>
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


On Fri, 2008-02-01 at 13:33 +0100, Takashi Iwai wrote:
> At Thu, 31 Jan 2008 16:45:31 +0000,
> Richard Kennedy wrote:
> > 
> > My JVC mininote laptop has an inbuilt SiS modem
> >  00:01.6 Modem [0703]: Silicon Integrated Systems [SiS] AC'97 Modem Controller [1039:7013] (rev a0)
...
> > kernel: Intel ICH Modem: probe of 0000:00:01.6 failed with error -5
> > 
> > I never use the modem so I blacklisted the snd-intel8x0m module in
> > modprobe.conf just to make the messages go away.
> > 
> > I'm currently running the fedora 2.6.23 kernel but it has been broken
> > for a long time.
> > 
> > Is this fixable?
> > or shall I just go on ignoring it ;) ?
> 
> The latter unless you really need the support of it ;)
> We have no datasheet for this SIS chipset, so it's hard to fix,
> unfortuantely.
> 
> 
> Takashi

Right, thanks.

In that case should we remove it from then supported devices list ?

[ from intel8x0m.c ]

MODULE_SUPPORTED_DEVICE("{{Intel,82801AA-ICH},"
	...
                "{SiS,7013},"
	...
                "{AMD,AMD768}}");

Cheers
Richard
