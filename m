From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] Sample program for hwdep interface
Date: Sat, 21 Dec 2013 20:41:23 +1030
Message-ID: <20131221101123.GA17855@marvin.atrad.com.au>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
 <52B45837.2080804@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id E370D262632
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 11:11:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52B45837.2080804@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: jwoithe@just42.net, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

[CC list trimmed to include just the lists]

On Fri, Dec 20, 2013 at 11:46:15PM +0900, Takashi Sakamoto wrote:
> This is how to use hwdep interface for firewire devices.
> I hope FFADO developers read this.
> 
> With hwdep interface, the program in user land can do:
> 1.get firewire node infomation
> 2.get notification when starting/stopping kernel streaming
> 3.lock/unlock kernel streaming

1 could be useful.  2 and 3, while not essential, are nice to have.

> For jackd with FFADO backend, it's better to lock kernel streaming in 
> advance. Then snd-bebob/snd-fireworks can't interrupt FFADO streaming.

If someone is using a kernel which has the streaming drivers for these
devices there would be no reason at all for that person to run FFADO's
streaming driver.  They would just use the ALSA jackd backend and be done
with it.  So rather than having FFADO mess around with this locking I think
it would be better in the long run for FFADO to determine whether there's
kernel streaming support for the device in question and refuse to run if
there is.

> And with snd-fireworks, the program can do:
> 4.transmit command of EFW transaction
> 5.receive response of EFW transaction
> 
> 4/5 is my complete solution for ticket #360.
> Make echo audiofire 8 and audiofire 12 work with recent firmwares
> http://subversion.ffado.org/ticket/360

I thought this ticket was more or less resolved.  How exactly does this
program deal with ticket #360?  This ticket requires fixes within FFADO's
mixer/control code (or so I thought).  Or is this program simply
demonstrating what FFADO must do?

Thanks for your ongoing work with these devices.

Regards
  jonathan
