From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Unresolved symbol in snd-cs4231-lib, CVS and Linux
 2.4.29
Date: Sun, 13 Mar 2005 10:02:11 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503131001100.1755@pnote.perex-int.cz>
References: <20050312193818.3343.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050312193818.3343.qmail@web52901.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Mar 2005, Chris Rankin wrote:

> Hi,
> 
> I have just recompiled my ALSA drivers from CVS, and found this error:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.29/kernel/drivers/sound/snd-cs4231-lib.o
> depmod:         snd_card_set_generic_pm_callback
> 
> I was compiling the snd-sscape driver: does this driver need to set the CONFIG_SND_GENERIC_PM
> #define in the configure script?

Do 'make cvsclean' in the alsa-driver directory and try again...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
