From: Adam Gray <adam@randalflagg.net>
Subject: Re: ALSA on Alienware M17x
Date: Wed, 2 Sep 2009 00:26:33 +0930
Message-ID: <200909020026.33466.adam@randalflagg.net>
References: <200908281621.20263.adam@randalflagg.net>
	<200909020009.14994.adam@randalflagg.net>
	<s5hskf6soxn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from randalflagg.net (randalflagg.net [150.101.102.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F9FE24362
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 16:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by randalflagg.net (Postfix) with SMTP id 10F4323609A
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2009 00:26:34 +0930 (CST)
In-Reply-To: <s5hskf6soxn.wl%tiwai@suse.de>
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


On Wed, 2 Sep 2009 12:16:28 am Takashi Iwai wrote:
> At Wed, 2 Sep 2009 00:09:14 +0930,
> 
> Adam Gray wrote:
> > On Wed, 2 Sep 2009 12:04:48 am you wrote:
> > > At Fri, 28 Aug 2009 16:21:20 +0930,
> > >
> > > Adam Gray wrote:
> > > > Hi guys,
> > > >
> > > > I'm having a lot of trouble getting sound out of my Alienware M17x.
> > > > I've attached the output from alsa-info. I'm running kernel version
> > > > 2.6.28 with ALSA driver version 1.0.18.
> > >
> > > 1.0.18 is very old.  Any chance to try the later version?
> > >
> > >
> > > Takashi
> >
> > I'm now running with the latest version (1.0.21), initially with the same
> > results. After some fiddling I've managed to get the headphones working
> > by adding:
> >
> > options snd-hda-intel model=dell-m6
> >
> > to /etc/modprobe.d/alsa-base.conf. But still no speakers.
> 
> Try model=intel first.  This will use the BIOS setup together with
> GPIO1.
> 
> 
> Takashi

After setting model=intel I now have the speakers working, but no headphones.
