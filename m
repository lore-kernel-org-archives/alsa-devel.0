From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
Date: Tue, 20 Dec 2005 14:09:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512201405550.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de>
 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
 <20051220211359.GA5359@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7D36719A
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 23:09:11 +0100 (MET)
In-Reply-To: <20051220211359.GA5359@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Tue, 20 Dec 2005, Adrian Bunk wrote:
> 
> Thinking about this, what about the patch below?
> 
> I don't know whether this might break anything else, but it fixes my 
> problem.

I'd be much more worried about this than about your patch that just 
modifies one driver.

Basically, this would make _all_ sound drivers initialize before the other 
drivers, and that just makes me suspect you'll have a lot of new bugs that 
get uncovered by the fact that the configuration changed radically.

So I'd much rather either fix one single sound driver (that can't mess up 
anything else), or fix the sound _core_ to just initialize in the right 
place. Moving _all_ sound drivers earlier sounds risky as hell, for no 
good reason.

		Linus


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
