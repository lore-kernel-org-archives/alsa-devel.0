From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: making aoss able to wrap fopen() calls
Date: Thu, 5 Feb 2004 17:49:57 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402051748390.1864@pnote.perex-int.cz>
References: <200402051727.25712.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA01603
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 17:49:37 +0100
In-Reply-To: <200402051727.25712.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Feb 2004, Peter Kirk wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hey,
> 
> During a thread on alsa-user I was told that aoss does not wrap fopen() calls. 
> Since I am trying to dmix/dnsoop/asym some oss applications, I am trying to 
> find a way around this restriction.
> 
> Could you point me to a good idea of implementing this ? On irc I was 
> discussing doing a libc wrapper that replaces the fopen calls with some 
> substitute (that aoss can handle), but I'm not sure if its the way to go. 
> 
> Please tell me how it can be achieved.

The whole libaoss is based on glibc wrappers (open, close, ioctl, write, 
read, mmap) so follow this rule ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
