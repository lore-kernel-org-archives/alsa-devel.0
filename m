From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sound update causes artsd to fail/abort initialization
Date: Mon, 4 Aug 2003 15:28:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308041523570.27139-100000@pnote.perex-int.cz>
References: <5.2.1.1.2.20030804142302.01975a80@wen-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA29351
	for <alsa-devel@alsa-project.org>; Mon, 4 Aug 2003 15:29:57 +0200
In-Reply-To: <5.2.1.1.2.20030804142302.01975a80@wen-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mike Galbraith <efault@gmx.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Aug 2003, Mike Galbraith wrote:

> Greetings,
> 
> While testing 2.6.0-test2-mm3-1, I ran into a problem with artsd failing 
> during X/KDE startup, leaving an error message "cpu overload, 
> aborting".  It takes about 20 seconds to fail, and after X finally does 
> come up, all seems well with the exception of artsd being AWOL.  (I don't 
> know what artsd has to do with sound, but whatever it is, it doesn't seem 
> to be terribly important, because xmms seems to work fine without 
> it)  After the initial failure, dropping back to the shell and restarting 
> X/KDE _usually_ results in artsd starting just fine, though once in a while 
> I'll get the same hang and failure that I always get the first time around.
> 
> Using the "brute-ignorance" method (pick something at random, patch -R it), 
> I narrowed it down a little.  Exactly what I reverted is attached for 
> reference.  Box is a piii/500 with an onboard ymf-740c, and I'm using oss 
> emulation.

Could you try, if any of bellow commands will work with the new code?

echo "artsd 0 0 no-silence" > /proc/asound/card0/pcm0p/oss
echo "artsd 0 0 whole-frag" > /proc/asound/card0/pcm0p/oss
echo "artsd 0 0 no-silence whole-frag" > /proc/asound/card0/pcm0p/oss

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
