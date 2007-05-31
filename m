From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Native Instruments - Audio Kontrol 1 -
 snd_usb_caiaq module
Date: Thu, 31 May 2007 08:39:30 +0200
Message-ID: <1180593570.28319.1192666947@webmail.messagingengine.com>
References: <465AE933.60605@gmx.net>
	<1180424951.19802.1192252459@webmail.messagingengine.com>
	<s5hr6ozzigh.wl%tiwai@suse.de> <465E0AD2.70309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 6FD9524573
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 08:39:31 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8C7C222B360
	for <alsa-devel@alsa-project.org>; Thu, 31 May 2007 02:39:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <465E0AD2.70309@gmx.net>
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
List-Id: alsa-devel@alsa-project.org

Alex Pintilie wrote:
> # make install-modules
> rm -f /lib/modules/2.6.20.3-ubuntu1/misc/snd*.*o 
> ...
> Then "make" continues to work with /lib/modules/2.6.20.3-ubuntu1/ as 
> destination directory. The problem is, I don't know where this directory 
> comes from, I never saw it before nor did I install any packages with 
> that number. My installed kernels are 2.6.20-16-generic  
> 2.6.20-16-lowlatency.

The configure scripts checks the following directories to find the
kernel source:
1) the directory specified with --with-kernel=...
2) /lib/modules/`uname -r`/source
3) /lib/modules/`uname -r`/build
4) /usr/src/linux

What is the output of "uname -r"?


Regards,
Clemens
