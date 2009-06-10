From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: problems with fedora 11 and pulseaudio and svn
	x-fi driver
Date: Wed, 10 Jun 2009 11:23:30 -0500
Message-ID: <1244651010.2065.1.camel@localhost.localdomain>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<1244623151.4093.3.camel@localhost.localdomain>
	<1244623955.6367.0.camel@localhost.localdomain>
	<s5hljo0mo7i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id B44DA103817
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 18:23:35 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so495224qwj.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 09:23:34 -0700 (PDT)
In-Reply-To: <s5hljo0mo7i.wl%tiwai@suse.de>
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

Sorry:
ftp://kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.bz2

Every app I've tried it with:)

Sound Blaster X-Fi SB0670 PCI Sound Card with emu20k1 chipset.


On Wed, 2009-06-10 at 11:29 +0200, Takashi Iwai wrote:

> At Wed, 10 Jun 2009 03:52:35 -0500,
> Ted T. Logan wrote:
> > 
> > I killed pulseaudio and the problem is the same as far as every few seconds,
> > just a different sound.  it seems to be the xfi driver.
> 
> Please be more specific, what apps did you test and how, and on which
> hardware, with which alsa-driver.  There is no svn alsa-driver at
> all, at least, as I know of.
> 
> If it's emu20k1 chip (not emu20k2), try use_system_timer=1 module
> option snd-ctxfi driver.  This will take the timer management back to
> the old one using the system timer.
> 
> 
> thanks,
> 
> Takashi
> 
> > I did not have this problem with XFiDrv_Linux_Public_US_1.00.tar.gz
> > however, I am trying to get away from that driver because of other issues.
> > 
> > Thanks!
> > 
> > On Wed, 2009-06-10 at 03:39 -0500, Ted T. Logan wrote:
> > 
> >     Hello,
> >    
> >     I upgraded to fedora 11 with PA 9.15 and got the svn alsa-driver and
> >     installed it for the x-fi driver.
> >    
> >     The problem is, with pulseaudio, i get a pop every few seconds
> >     like, every 3 seconds, "pop" and it does it over and over and over
> >    
> >     I seem to get no sound at all with the card if I bypass pulse
> >    
> >     What can I do?
> > 
> > 
