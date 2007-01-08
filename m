From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: ALSA patches for 2.6.16
Date: Mon, 8 Jan 2007 23:14:05 +0100
Message-ID: <20070108221405.GH6167@stusta.de>
References: <20070106035913.GO20714@stusta.de> <s5h64bhyekp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6BA79196
	for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2007 23:14:00 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h64bhyekp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, perex@suse.cz, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 08, 2007 at 11:53:42AM +0100, Takashi Iwai wrote:
> At Sat, 6 Jan 2007 04:59:13 +0100,
> Adrian Bunk wrote:
> > 
> > The following patches that were added to the -stable 2.6.18 seem to make 
> > sense for 2.6.16:
> > 
> > 2.6.18.1:
> > ALSA: Fix initiailization of user-space controls
> > 
> > 2.6.18.2:
> > ALSA: emu10k1: Fix outl() in snd_emu10k1_resume_regs()
> > ALSA: snd_rtctimer: handle RTC interrupts with a tasklet
> > 
> > For an easier review, I've attached the patches.
> > 
> > Do these patches look OK for 2.6.16, or should I not apply some or all?
> 
> Yes, all these patches are fine.  Please apply.

Thanks, I've applied them.

> > Are there any critical patches I missed?
> 
> There are some fixes in SUSE SP1 kernel.  I'll check whether they are
> included in the latest 2.6.16.x tree.

Thanks a lot!

> thanks,
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
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
