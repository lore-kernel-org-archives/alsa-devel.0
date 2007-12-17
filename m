From: Hans-Christian Egtvedt <hcegtvedt@atmel.no>
Subject: Re: Is the mixer interface in the kernel
	protect	against concurrent access?
Date: Mon, 17 Dec 2007 17:07:56 +0100
Message-ID: <1197907676.1365.43.camel@localhost.localdomain>
References: <1197900817.1365.38.camel@localhost.localdomain>
	<Pine.LNX.4.61.0712171641070.14817@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 3405F10386D
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 17:08:39 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0712171641070.14817@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-12-17 at 16:43 +0100, Jaroslav Kysela wrote:
> On Mon, 17 Dec 2007, Hans-Christian Egtvedt wrote: 
> > I am solving a locking bug in the at73c213 SPI sound driver, and
> > wondered if the mixer API is protected against concurrent access in
> > ALSA? Or should I implement a mutex to protect my hardware against
> > concurrent access?
> 
> Control r/w callbacks are protected with a semaphore - 
> card->controls_rwsem . See sound/core/control.c for more details. Anyway, 
> you need to protect your registers with spinlocks (if required of 
> course).
> 

Thanks for the feedback. I settled upon a mutex since the SPI driver can
not use spinlocks due to a might sleepy spi_sync function call.

-- 
Mvh
Hans-Christian Egtvedt
