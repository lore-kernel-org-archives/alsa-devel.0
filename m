From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Request for help CM109 on arm board
Date: Tue, 07 Feb 2012 22:21:53 +0000
Message-ID: <1328653313.889.15.camel@jonspc>
References: <1328630452.28163.11.camel@jonspc>
	<1328646929.31394.11.camel@jonspc>  <4F319B47.2080703@ladisch.de>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BC78103D00
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 23:21:54 +0100 (CET)
In-Reply-To: <4F319B47.2080703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-02-07 at 22:44 +0100, Clemens Ladisch wrote:
> Jonathan Andrews wrote:
> > ALSA lib timer.c:189:(snd_timer_open_noupdate) Unknown timer hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0
> 
> > ARM # cat /usr/share/alsa/alsa.conf
> > ...
> 
> You have deleted alsa-lib's basic device definitions.  Device-specific
> definitions are supposed to go into /usr/share/alsa/cards/.  Your
> definitions look as if they are supposed to go into /etc/asound.conf.
> 
Thanks for the reply.  I've failed to create the basic device
definitions..
 
I have alsa-lib-1.0.25 cross compiled from source, the libs are
installed and alsa-utils-1.0.25 has been built against it.

The snag is alsaconf seems broken (fails to exec) and as I don't have an
ldd that works with arm i'm a bit bust, everything else in alsa-utils
seems to at least execute ....

Do I need to split the config across files, I only want one device on
this board and i'm limited in space. I have kernel+kernel modules
+busybox+some libs+alsautils partially working and i'm out of flash..

I figured as I need only one device on one board that will never change
I could hand code it, is it a requirement to split the config. This is
destined to be a single task machine.

Thanks,
Jon
