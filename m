From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems running latencytest: "error setting freq
 1024"
Date: Wed, 24 Mar 2004 09:20:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403240919210.1860@pnote.perex-int.cz>
References: <20040323205352.GA3246@fliwatut.scifi>
 <Pine.LNX.4.58.0403240916440.1860@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA16562
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 09:21:20 +0100
In-Reply-To: <Pine.LNX.4.58.0403240916440.1860@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Mar 2004, Jaroslav Kysela wrote:

> > $ measure -p ./out/x11.png -o ./out/x11.out -c 0 -f 1024 -n 2 -t 2
> > I get this error message: "error setting freq 1024"
> 
> Frequency should be equal or greater than 5000Hz.

Sorry, it appears to be the rtc frequency, of course. I was referring to
the PCM rate.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
