From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: amixer: convert percentage into db wrongly
Date: Thu, 8 Mar 2012 17:30:02 +0100
Message-ID: <20120308163001.GA2991@samweis.home.lxtec.de>
References: <20120308123632.GA8920@adam-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
	[83.223.95.204]) by alsa0.perex.cz (Postfix) with ESMTP id 6051A24427
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 17:30:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120308123632.GA8920@adam-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Lee <adam8157@gmail.com>, 663090@bugs.debian.org
Cc: alsa-devel@alsa-project.org, control@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

severity 663090 normal
forwarded 663090 alsa-devel@alsa-project.org
thanks


* Adam Lee <adam8157@gmail.com> [2012-03-08 20:36 +0800]:

> Package: alsa-utils
> Version: 1.0.25-1
> Severity: important
> 
> 
> db is not linear, but amixer believe it is.
> 
> "amixer get Master" says "Limits: Playback 0 - 74", then everytime I run
> "amixer -q sset Master 10%-", there is 8db dec.
> 
> For example, at first Master is 100% and 0db, both alsamixer and amixer
> think it is, and after I run "amixer -q sset Master 10%-", both
> alsamixer and amixer says Master is -8.00db, but alsamixer says it is
> 72%, amixer says it is 89%.
> 
> alsamixer is right, amixer calc and set wrongly.
> 
> Several months ago, they both right, and I upgraded, and amixer messed
> up. Please fix it. Thank you.
> 
> FYI, my hardware is:
> "HDA-Intel" "Conexant CX20585" "HDA:14f15069,17aa214c,00100302 HDA:14f12c06,17aa2122,00100000" "0x17aa" "0x215e"
> 
> 
> -- System Information:
> Debian Release: wheezy/sid
>   APT prefers unstable
>   APT policy: (500, 'unstable')
> Architecture: amd64 (x86_64)
> 
> Kernel: Linux 3.2.0-1-amd64 (SMP w/4 CPU cores)
> Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
> Shell: /bin/sh linked to /bin/dash
> 
> Versions of packages alsa-utils depends on:
> ii  dialog             1.1-20120215-1
> ii  libasound2         1.0.25-2
> ii  libc6              2.13-27
> ii  libncursesw5       5.9-4
> ii  libsamplerate0     0.1.8-3
> ii  libtinfo5          5.9-4
> ii  linux-sound-base   1.0.23+dfsg-4
> ii  lsb-base           3.2+Debian29
> ii  module-init-tools  6-1
> ii  whiptail           0.52.14-8
> 
> Versions of packages alsa-utils recommends:
> ii  alsa-base  1.0.23+dfsg-4
> ii  pciutils   1:3.1.8-2
> 
> alsa-utils suggests no packages.
> 
> -- no debconf information
> 
> 
> 
> _______________________________________________
> Pkg-alsa-devel mailing list
> Pkg-alsa-devel@lists.alioth.debian.org
> http://lists.alioth.debian.org/cgi-bin/mailman/listinfo/pkg-alsa-devel
> 

-- 
  The path to source is always uphill!
                                -unknown-
