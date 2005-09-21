From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Date: Wed, 21 Sep 2005 09:31:09 +0100
Message-ID: <20050921083109.GA27254@infradead.org>
References: <200509190639.j8J6dIM4007948@localhost.localdomain> <20050920152830.7ef6733b.akpm@osdl.org> <47f5dce305092017031a2ba375@mail.gmail.com> <20050920172309.626db866.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050920172309.626db866.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: jayakumar.alsa@gmail.com, perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2005 at 05:23:09PM -0700, Andrew Morton wrote:
> > I'm not sure what to do. I'd be happy to take them out. But I woudn't
> > mind leaving them in if that's what alsa convention is.
> 
> I'd be inclined to stick with the alsa style.  That's just an fyi if you
> plan on working in other places.

I'd _really_ prefer to fix all of alsa.  Alsa is so full of wrappers
and multiple names for the same thing that's it's almost impossibly
for a normal kernel developer to fix anythign in there.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
