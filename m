From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] via82xx.c #2
Date: Sun, 8 Sep 2002 14:17:31 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209081411260.32191-100000@portland.hansa.lan>
References: <Pine.LNX.4.44.0209081937330.1191-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0209081937330.1191-200000@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Rui Sousa <rui.sousa@laposte.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, Rui!

> I realized the CVS driver after Jul 31 (sg buffer implementation) was
> already broken when using a fragment size smaller than PAGE_SIZE. The 
> attached patch fixes this. I now have CVS driver from 8/27/2002 working 
> (last commit before the merge), but mainline of today is still broken.

Great!  This fixes my problem with Via 686A as well.

I was going to look into this problem today, and you saved me this
beautiful Sunday for something else.  My Via 686A is now playing in your
honor :-)

Takashi, please apply those two patches.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
