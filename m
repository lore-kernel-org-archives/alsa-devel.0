From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [PATCH] configure prob with MDK82 kernel
Date: Wed, 24 Apr 2002 20:54:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2it6h3p1m.fsf@vador.mandrakesoft.com>
References: <Pine.LNX.4.44.0204241426320.17011-200000@volamar.theswamp.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0204241426320.17011-200000@volamar.theswamp.priv> (Tom
 Prado's message of "Wed, 24 Apr 2002 14:35:44 -0400 (EDT)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tom Prado <tprado@charter.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tom Prado <tprado@charter.net> writes:

> I had a problem running configure against the Linux Mandrake 8.2 UP
> kernel.  It would fail when trying to determine the kernel version.
> This patch for rc1 adds the needed includes so that linux/rhconfig.h
> can be found when configure checks for the kernel version.

use a 2.4.18-10mdk kernel and above: we've updated alsa from 0.5 upto
0.9 in 10mdk.
note that this is a cooker kernel, not a mdk8.2 release kernel.
-- 
"il a ete brule au 28e degre" (the naheulbeuk witch)
"c curieux, gcc fonctionne" (gwenole)
