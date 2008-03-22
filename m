From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Buffer size/periods (Layla3G)
Date: Sat, 22 Mar 2008 22:17:18 +0000
Message-ID: <20080322221718.0b24de11.pochini@shiny.it>
References: <alpine.BSO.1.00.0803161126500.28063@metheny.ijneb.com>
	<20080316221239.ae934fe4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-OUT05A.alice.it (smtp-OUT05A.alice.it [85.33.3.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 93690103879
	for <alsa-devel@alsa-project.org>; Sat, 22 Mar 2008 22:14:51 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: Mark Hills <mark@pogo.org.uk>
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

It seems that ALSA can't manage to find a working hwparams combo. The card
has the following constraints:

buffer size:	64-32768 frames
period size:	multiple of 32 frames
periods:	2-220

It happens that ALSA restricts the allowable buffer size range to
18976-18976 which is very close to the requested 430ms. This is bad because
the biggest multiple of 32 divisor of 18976 is 32. 18976/32 = 593 > maximum
number of periods. return -EINVAL.

BUFFER_TIME = (430294 430295) -> (430294 430295)
Rule 8 [e20b3944]: RATE = [44100 44100] -> [44100 44100]
Rule 15 [e20b38d0]: BUFFER_SIZE = [18976 32768] -> [18976 18976]
Rule 17 [e20b38d0]: BUFFER_BYTES = [151808 262144] -> [151808 151808]
Rule 19 [e20b3944]: BUFFER_TIME = (430294 430295) -> (430294 430295)

Note that if you change the order of the hw_params_*() calls the problem
goes away. It might show up again for some other values though.

I don't know how to fix it. Any clue ??


--
Giuliano.
