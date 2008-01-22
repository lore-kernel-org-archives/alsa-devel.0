From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: how do you people debug ALSA?
Date: Tue, 22 Jan 2008 09:45:29 +0100
Message-ID: <1200991529.25807.1232559973@webmail.messagingengine.com>
References: <012120082025.22241.4794FFC1000089D6000056E122243651029B0A02D2089B9A019C04040A0DBF050C079D0E960E03@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 04FA424A8A
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 10:08:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <012120082025.22241.4794FFC1000089D6000056E122243651029B0A02D2089B9A019C04040A0DBF050C079D0E960E03@att.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: mazarick@bellsouth.net, alsa-devel@alsa-project.org
Cc: wavepro-driver-developers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

mazarick@bellsouth.net wrote:
> It would be fine to say "vi is the development environment,

Actually, I'm using vim.

> and we sprinkle the code with printk statements and take them out when
> the soup's done".

When using snd_printd() or snd_printdd(), one doesn't need to take them
out afterwards. :)

> 1.   Do you regularly use the "alsasound" kernel function during
> development so you can take the driver in and out of the kernel?

I regularly (un)load the modules that I'm changing.  In most cases I
don't use the script that came with my distribution because I don't want
to (un)load all the other sound drivers, too.

> 3.   Are there tools that are almost always used when writing a sound
> card driver like gdb, ddd, etc?

These debuggers don't work with kernel code.

> 4.   Since it's easy to do, is an interface into the proc file system
> useful from the start?

Yes.  Most drivers have some proc file that dumps the current register
contents.  It's always helpful to be able to check what your code did to
the chip.

> 1.  We've having difficulty getting the Altera PLD to load.

This code in uart_gl824_program_pld looks very suspicious:

        //YUCK: This stops us from actually doing it.
        if( uart_io_port != NULL ){
                return(0);
        }

> 2.  Should the 'load the Altera' function be part of the alsa driver,
> part of alsa firmware, or should we just load it up when the computer
> boots (not in alsa)?

Doing it in the driver is easiest (otherwise you would have to write
another kernel module) and ensures that it's actually done before using
the driver.


HTH
Clemens
