From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Wed, 21 Dec 2005 10:32:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512211026190.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk>
 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <s5hpsnqzf86.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 596241B4
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 19:32:51 +0100 (MET)
In-Reply-To: <s5hpsnqzf86.wl%tiwai@suse.de>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Wed, 21 Dec 2005, Takashi Iwai wrote:
>
> (And, interestingly, fs_initcall() is rarely used in the whole fs/
>  codes!  "grep -r fs_initcall linux/fs" hits only one file.)

Yes. That thing was probably mis-named. It's much more commonly used for a 
"helper subsystem", ie things like pcmcia (that want PCI to be fully 
initialized and probed, but want to run before the actual device drivers 
start probing).

> So, a "safe" solution for the time being appears to be either
> - to look through the whole codes and adjust *_initcall() levels,
> - to force to build saa7134-alsa as a module, or
> - to move saa7134-alsa.c to sound/ directory.

Well, you dropped the easiest: make saa7134 just use "late_initcall()".

It's not "correct", but it's certainly no less correct than just forcing a 
driver to be moved for link order reasons.

		Linus


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
