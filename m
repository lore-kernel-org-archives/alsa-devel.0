From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Since kernel-2.6.32,
 alsactl fails to restore defaults
Date: Sun, 14 Feb 2010 19:20:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002141912260.28127@eeebox2.perex-int.cz>
References: <1266156307.23964.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D0B6B243FE
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 19:20:15 +0100 (CET)
In-Reply-To: <1266156307.23964.3.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 14 Feb 2010, Pacho Ramos wrote:

> I originally reported this issue downstream to:
> http://bugs.gentoo.org/show_bug.cgi?id=299362
>
> Later to kernel:
> http://bugzilla.kernel.org/show_bug.cgi?id=15107
>
> And they told me that this is an alsactl issue, since it's not exiting
> with 0 when it notices that the device doesn't need special quirks:
> # alsactl -f /var/lib/alsa/asound.state restore
> Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
> "0x1415"
> Hardware is initialized using a guess method
> # echo $?
> 157

I agree, this value is bogus. I just fixed the code to return exit code 
99 as described in init/00main:

http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=69c6bead434e7a4a546ab1300413312994b93e35

> What could I do? Thanks for helping me, if you need more information,
> simply ask me for it :-)

There are two ways to fix this issue for your distro:

1) modify the script which calls alsactl and add a check for code 99
    (it may ignore this exit code) - assuming that patch above is applied
2) change init/00main - EXIT="99" line to EXIT="0"

But from your gentoo bug, I guess that your system don't save the last 
soundcard state to /var/lib/alsa/asound.state correctly - it's looks like 
a bug in the init scripts for your distro.

Or it might be totaly different issue - could you send me your 
/var/lib/alsa/asound.state file and file test.state generated using 
'alsactl -f test.state store' command?

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
