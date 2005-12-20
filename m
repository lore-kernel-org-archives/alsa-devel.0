From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 21:23:25 +0100
Message-ID: <20051220202325.GA3850__2371.16101566262$1135110455$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 2DE8B1B6
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 21:23:26 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2005 at 11:59:20AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Dec 2005, Adrian Bunk wrote:
> >
> > > Adrian, does it work if you change the "module_init()" in 
> > > sound/sound_core.c into a "fs_initcall()"?
> > 
> > No, this didn't work.
> > 
> > What did work was to leave sound/sound_core.c alone
> 
> Can you do try the other way again, with sound/core/sound.c fixed too?
>...

This works in the sense that the kernel boots and my saa7134 TV card is 
giving both audio and video output.

But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
longer working.

> 	Thanks,
> 
> 		Linus

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
