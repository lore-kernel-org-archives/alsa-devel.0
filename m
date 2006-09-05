From: Adrian Bunk <bunk@stusta.de>
Subject: Re: ALSA patches for 2.6.16
Date: Tue, 5 Sep 2006 21:41:36 +0200
Message-ID: <20060905194136.GH9173@stusta.de>
References: <20060831211756.GW18276@stusta.de> <s5h3bbbooqp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 33FC2236
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Sep 2006 21:41:43 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5h3bbbooqp.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 01, 2006 at 12:38:54PM +0200, Takashi Iwai wrote:
> At Thu, 31 Aug 2006 23:17:56 +0200,
> Adrian Bunk wrote:
> > 
> > The following 8 patches that were included in 2.6.17.7 seem to also make 
> > sense in 2.6.16:
> > 
> > ALSA: Suppress irq handler mismatch messages in ALSA ISA drivers
> 
> This one can't be applied.  2.6.16 has no SA_PROBEIRQ flag.
> 
> > ALSA: RME HDSP - fixed proc interface (missing {})
> > ALSA: hda-intel - Fix race in remove
> > ALSA: Fix workaround for AD1988A rev2 codec
> > ALSA: Fix model for HP dc7600
> > ALSA: Fix missing array terminators in AD1988 codec support
> > ALSA: Fix a deadlock in snd-rtctimer
> > ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port
> 
> The others are good to apply.

Thanks for the review, I've applied the latter 7 patches.

> Thanks,
> 
> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
