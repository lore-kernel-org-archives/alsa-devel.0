From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: .hw_free() while audio is running ??
Date: Tue, 10 Aug 2004 11:14:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810111427.7815ec73.pochini@shiny.it>
References: <20040808172946.43212219.pochini@shiny.it>
	<Pine.LNX.4.58.0408082235380.1771@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408082235380.1771@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Aug 2004 22:39:57 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> > The call sequence in the logs is:
> >
> > pcm_trigger (start)	- of two synced ss's
> > pcm_hw_free (playback ss)
> > Crash, nothing more in the logs :(
> >
> > trigger(stop) wasn't called before hw_free.
>
> You have an SMP machine? The hw_free is protected with the 
> runtime->status->state checking, but the code is not protected with 
> spinlock, so I suspect trouble here.

Yes, this is a dual processor, but I booted with maxcpus=1 and preempt is
not enabled.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
