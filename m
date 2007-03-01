From: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [BUG] Linux 2.6.20.1 - unable to handle kernel
 paging request - accessing freed memory?
Date: Thu, 1 Mar 2007 13:32:55 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0703011330330.29829__29022.4530421712$1172748814$gmane$org@sbz-30.cs.Helsinki.FI>
References: <462787.14129.qm@web52911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 029B73BB
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2007 12:32:56 +0100 (MET)
In-Reply-To: <462787.14129.qm@web52911.mail.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Chris Rankin <rankincj@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Chris,

On Thu, 1 Mar 2007, Chris Rankin wrote:
> Nope, no difference. Again, this happened while trying to start World of 
> Warcraft. However, this time there is no snd-rtctimer module in the 
> stack.

Please apply this patch to your kernel and try to reproduce:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20/2.6.20-mm2/broken-out/gregkh-driver-sysfs-crash-debugging.patch

It should give us a better clue which sysfs file is causing the oops.

			Pekka

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
