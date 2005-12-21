From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Wed, 21 Dec 2005 23:42:27 +0100
Message-ID: <20051221224227.GD3917@stusta.de>
References: <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk> <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <s5hpsnqzf86.wl%tiwai@suse.de> <Pine.LNX.4.64.0512211026190.4827@g5.osdl.org> <s5hwthyxoz1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id AD7FF1B6
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 23:42:27 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hwthyxoz1.wl%tiwai@suse.de>
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
Cc: Linus Torvalds <torvalds@osdl.org>, James Courtier-Dutton <James@superbug.co.uk>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2005 at 07:52:02PM +0100, Takashi Iwai wrote:
> At Wed, 21 Dec 2005 10:32:41 -0800 (PST),
> Linus Torvalds wrote:
>...
> > > So, a "safe" solution for the time being appears to be either
> > > - to look through the whole codes and adjust *_initcall() levels,
> > > - to force to build saa7134-alsa as a module, or
> > > - to move saa7134-alsa.c to sound/ directory.
> > 
> > Well, you dropped the easiest: make saa7134 just use "late_initcall()".
> > 
> > It's not "correct", but it's certainly no less correct than just forcing a 
> > driver to be moved for link order reasons.
> 
> Yep, that's obviously the easiest one.  I'd vote for this, at least
> for 2.6.15, once after it's confirmed to work.

I've already stated somewhere in this thread that this did fix it for 
me.

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
