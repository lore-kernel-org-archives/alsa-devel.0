From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems running latencytest: "error setting freq
 1024"
Date: Wed, 24 Mar 2004 09:17:12 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403240916440.1860@pnote.perex-int.cz>
References: <20040323205352.GA3246@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA16490
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 09:18:21 +0100
In-Reply-To: <20040323205352.GA3246@fliwatut.scifi>
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

On Tue, 23 Mar 2004, Frank Barknecht wrote:

> Hallo,
> 
> I'd like to test my system's 2.6.4 latency using Takashi's
> http://www.alsa-project.org/~iwai/latencytest-0.5.2.tar.gz
> suite. 
> 
> Building and installing so far went fine, I can run all the tests but
> no output is created. But I get a spurious error message which could be
> the reason for this. If I run "measure" by hand as it is called by
> "run_tests" like this: 
> $ measure -p ./out/x11.png -o ./out/x11.out -c 0 -f 1024 -n 2 -t 2
> I get this error message: "error setting freq 1024"

Frequency should be equal or greater than 5000Hz.

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
