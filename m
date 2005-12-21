From: R C <v4l@cerqueira.org>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Wed, 21 Dec 2005 22:50:43 +0000
Message-ID: <1135205444.3029.2.camel__27730.1097791225$1135205531$gmane$org@frolic>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <43A86B20.1090104@superbug.co.uk>
	 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
	 <s5hpsnqzf86.wl%tiwai@suse.de>
	 <Pine.LNX.4.64.0512211026190.4827@g5.osdl.org>
	 <s5hwthyxoz1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from home.cerqueira.org (cerqueira.net [195.23.98.191])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 410F31B6
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 23:51:08 +0100 (MET)
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
Cc: Linus Torvalds <torvalds@osdl.org>, James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all;

On Wed, 2005-12-21 at 19:52 +0100, Takashi Iwai wrote:
> > 
> > Well, you dropped the easiest: make saa7134 just use "late_initcall()".
> > 
> > It's not "correct", but it's certainly no less correct than just forcing a 
> > driver to be moved for link order reasons.
> 
> Yep, that's obviously the easiest one.  I'd vote for this, at least
> for 2.6.15, once after it's confirmed to work.
> 

I've just confirmed it works with rc6-git2. The driver activates
properly and works as expected.
I've just commited the changes to v4l, Mauro should send them upstream
later.

--
RC



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
