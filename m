From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Buffer size/periods (Layla3G)
Date: Wed, 19 Mar 2008 00:15:20 +0000
Message-ID: <20080319001520.033708d1.pochini@shiny.it>
References: <alpine.BSO.1.00.0803161126500.28063@metheny.ijneb.com>
	<20080316221239.ae934fe4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id CA1EA1038A3
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 00:13:09 +0100 (CET)
In-Reply-To: <20080316221239.ae934fe4.pochini@shiny.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@alsa-project.org, Mark Hills <mark@pogo.org.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, 16 Mar 2008 22:12:39 +0000
Giuliano Pochini <pochini@shiny.it> wrote:

> > Also, there seem to be failures at certain buffer sizes:
> >
> >    $ ./test_buffers "hw:Layla3G,0,2" 429
> >    buffer_size=18912 period_size=96
> >
> >    $ ./test_buffers "hw:Layla3G,0,2" 430
> >    set_buffer_time_near: Invalid argument
> >
> >    $ ./test_buffers "hw:Layla3G,0,2" 431
> >    buffer_size=19008 period_size=96
> 
> This shouldn't happen. I'll give it a look.

Still no luck on this issue. ioctl() called from pmc_hw.c::hw_refine_call()
fails. I'll look at the kernel part tomorrow.


--
Giuliano.
