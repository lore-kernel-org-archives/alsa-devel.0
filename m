From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [BUG] Linux 2.6.20.1 - unable to handle kernel
	paging request - accessing freed memory?
Date: Tue, 27 Feb 2007 13:25:26 +0000 (GMT)
Message-ID: <797678.74613.qm__5272.92165575108$1172582934$gmane$org@web52901.mail.yahoo.com>
References: <s5h7iu4heun.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from web52901.mail.yahoo.com (web52901.mail.yahoo.com
	[206.190.49.11])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 970892EF
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 14:25:28 +0100 (MET)
In-Reply-To: <s5h7iu4heun.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote: 
> snd_timer_global_register() itself doesn't issue any tasklet, so it
> shouldn't be needed.

Hmm, this bug looks interesting:

http://www.ussg.iu.edu/hypermail/linux/kernel/0702.3/0514.html

Yes, my machine *is* a dual P4 with HT enabled...

Cheers,
Chris



		
___________________________________________________________ 
What kind of emailer are you? Find out today - get a free analysis of your email personality. Take the quiz at the Yahoo! Mail Championship. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
