From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Wed, 21 Dec 2005 10:32:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512211029200.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk>
 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <43A989CF.3000901@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B9521B4
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 19:32:26 +0100 (MET)
In-Reply-To: <43A989CF.3000901@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Wed, 21 Dec 2005, Steve deRosier wrote:
> 
> Thankfully, we've never had to deal with this sort of failure; all of our Alsa
> drivers and services have been well behaved (mostly).

Yes, I think the common case is that built-in _does_ work. I certainly 
have used sound that way. This one case is a bit special just because it's 
not under the sound/ directory, but I suspect that may be true of some USB 
sound"cards" too. 

Now, hot-plug devices tend to have a stronger case for being built as 
modules, although even there I personally actually end up just building in 
the devices I have (whether cardbus cards or things like the USB
printer/mouse/keyboard).

So I don't think sound is terminally broken here, just a few small details 
that it gets wrong that causes some odder drivers to not like being built 
in.

		Linus


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
