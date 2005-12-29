From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Date: Thu, 29 Dec 2005 14:23:55 +0100
Message-ID: <20051229132355.GA3811__35732.8319958926$1135862742$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051222011320.GL3917@stusta.de> <20051222071557.GA17346@suse.de> <s5hpsnpxrqw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E54B216F
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2005 14:23:55 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hpsnpxrqw.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2005 at 01:04:23PM +0100, Takashi Iwai wrote:
> At Wed, 21 Dec 2005 23:15:57 -0800,
> Greg KH wrote:
> > 
> > On Thu, Dec 22, 2005 at 02:13:20AM +0100, Adrian Bunk wrote:
> > > The following bug in the kernel Bugzilla contains a regressions in 
> > > 2.6.15-rc without a patch:
> > > - #5760 No sound with snd_intel8x0 & ALi M5455 chipset
> > >         (kobject_register failed)
> > 
> > We put code in the kobjet to report when callers fail, due to problems
> > in them, and the kobject code is blamed...
> > 
> > Looks like a sound driver issue, nothing has changed in the kobject
> > code.
> 
> But there is no relevant change in sound stuff between 2.6.15-rc4 and
> rc6 (except for minor fix of OSS drivers).  If it really worked with
> 2.6.15-rc4, something else got broken.

I don't know whether this is related to the problem, but the code giving 
the "AC'97 1 does not respond - RESET" warning that is present in both 
the working and the non-working cases for the submitter looks a bit 
fragile.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
