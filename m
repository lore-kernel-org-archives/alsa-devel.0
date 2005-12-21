From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 17:29:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512201728020.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de>  <20051220155216.GA19797@master.mivlgu.local>
  <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>  <20051220191412.GA4578@stusta.de>
  <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>  <43A86B20.1090104@superbug.co.uk>
  <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <1135117067.27101.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18ED317E
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 02:29:27 +0100 (MET)
In-Reply-To: <1135117067.27101.5.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Tue, 20 Dec 2005, Lee Revell wrote:
> 
> With modules it's possible to test a new ALSA version without
> recompiling the kernel or even rebooting

That's TOTALLY irrelevant.

Kernel modules work fine for developers. I'm not saying that _you_ 
shouldn't use modules.

I'm saying that you have absolutely no business telling others not to 
compile these things in.  Statically compiled drivers have advantages.

			Linus


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
