From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: buffer producer/consumer sync
Date: Tue, 9 Mar 2004 10:53:57 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403091050010.3966@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F2906A@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F2906A@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Mar 2004, Gupta, Kshitij wrote:

> > Can someone comment on this and guide a little bit to solve this problem.

Yes, on ARM platform you might have problem with MMU / cache coherency, 
because appl_ptr and hw_ptr are mmaped to user space. I observed this 
behaviour on SA11xx platform, too.

Russell King already notified us about this problem. See the mail archive 
for the proper fix of the midlevel code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
