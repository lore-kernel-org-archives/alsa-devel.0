From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems with a PCM driver
Date: Sun, 31 Aug 2003 09:04:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308310903500.3486-100000@pnote.perex-int.cz>
References: <200308301956.52235.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA03567
	for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2003 09:47:16 +0200
In-Reply-To: <200308301956.52235.adrian@mcmen.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 30 Aug 2003, Adrian McMenamin wrote:

> I am writing a PCM driver for the AICA device on the Sega Dreamcast for a 
> 2.6.0-testX kernel.
> 
> The driver is far from complete, but I am having various problems when I test 
> bits of it...
> 
> A simple write of a file gives me this...
> 
> /dev/snd # cat /test.txt > pcmC0D0p
> ALSA sound/sh/aica.c:165: In snd_aica_playback_open
> ALSA sound/sh/aica.c:80: Disabling AICA device
> ALSA sound/sh/aica.c:66: Enabling AICA device
> cat: write: File descriptor in bad state

Use the aplay utility. The native devices need a special initialization 
using ioctl.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
