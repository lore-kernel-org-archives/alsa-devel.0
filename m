From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 20:14:12 +0100
Message-ID: <20051220191412.GA4578__5009.50407372347$1135106442$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B5E0419A
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 20:14:12 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
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

On Tue, Dec 20, 2005 at 10:24:55AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Dec 2005, Sergey Vlasov wrote:
> > 
> > saa7134-alsa is trying to initialize before the ALSA core has initialized.
> > Probably no one has tested CONFIG_VIDEO_SAA7134=y.
> 
> Adrian, does it work if you change the "module_init()" in 
> sound/sound_core.c into a "fs_initcall()"?

No, this didn't work.

What did work was to leave sound/sound_core.c alone and make the 
module_init() in drivers/media/video/saa7134/saa7134-alsa.c a 
late_initcall() (plus disabling building of saa7134-oss.o because
otherwise saa7134-alsa.o wouldn't do anything).

> That should make sure that the sound core gets to initialize before normal 
> drivers do.
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
