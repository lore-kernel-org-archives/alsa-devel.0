From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 20:35:44 +0000
Message-ID: <43A86B20.1090104@superbug.co.uk>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 380991B6
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 21:35:49 +0100 (MET)
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
Cc: Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Linus Torvalds wrote:
> 
> On Tue, 20 Dec 2005, Adrian Bunk wrote:
> 
>>>Adrian, does it work if you change the "module_init()" in 
>>>sound/sound_core.c into a "fs_initcall()"?
>>
>>No, this didn't work.
>>
>>What did work was to leave sound/sound_core.c alone
> 
> 
> Can you do try the other way again, with sound/core/sound.c fixed too?
> 
> A regular driver really _should_ use the regular "module_init()" sequence 
> (it is indeed just a compatibility define for "driver_init()").
> 
> The "late_init()" stuff is meant for stuff that literally runs after 
> everything else is up and running, it might want all drivers functional 
> (now, nobody really cares about a sound driver, so in that sense it would 
> be ok..)
> 
> 	Thanks,
> 
> 		Linus
> 

This is an interesting problem actually.
alsa consists of a number of different modules.
They all load in the correct order if they are modules. The problem 
comes when one compiles them into the kernel. They then load in the 
wrong order and bad things happen, resulting in the recommendation that 
alsa should always be modules.
In this basis, we should not have to change the code in alsa at all, but 
instead change the kernel to understand the load order, even if compiled 
into the kernel and not as modules.

I have no idea how to get the kernel to do this though. Any pointers?

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
