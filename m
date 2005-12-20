From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 10:57:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512201056060.4827__10083.48669061$1135105208$gmane$org@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220183455.GC19797@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F68E1B2
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 19:57:53 +0100 (MET)
In-Reply-To: <20051220183455.GC19797@master.mivlgu.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org, Sergey Vlasov <vsu@altlinux.ru>
List-Id: alsa-devel@alsa-project.org


Sergey points out (but only to me) that sound/core/sound.c probably needs 
the same thing.

Sound people, can you pls check the dependencies? Are there any other 
"sound core" initialization that needs to happen early?

		Linus

On Tue, 20 Dec 2005, Sergey Vlasov wrote:

> On Tue, Dec 20, 2005 at 10:24:55AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 20 Dec 2005, Sergey Vlasov wrote:
> > > 
> > > saa7134-alsa is trying to initialize before the ALSA core has initialized.
> > > Probably no one has tested CONFIG_VIDEO_SAA7134=y.
> > 
> > Adrian, does it work if you change the "module_init()" in 
> > sound/sound_core.c into a "fs_initcall()"?
> 
> And in sound/core/sound.c (ALSA causes the problem here, not OSS).
> 
> > That should make sure that the sound core gets to initialize before normal 
> > drivers do.
> 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
