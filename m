From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Full duplex questions.
Date: Sun, 28 Mar 2004 10:13:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403281007020.1828@pnote.perex-int.cz>
References: <4065E0DB.9050003@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA12012
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2004 11:13:14 +0200
In-Reply-To: <4065E0DB.9050003@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 27 Mar 2004, James Courtier-Dutton wrote:

> I want a sound card to work in full duplex.
> I also want the in and out directions in sample sync.
> I.E. The playback period size is 160. I have my code polling, so that it 
> is executed once every 160 samples.
> How do I ensure that each time my code executed, there will be at least 
> 160 samples ready to be captured?
> 
> Is there some way to link the starting of playback and capture so that 
> they start at exactly the same time. So, each time i play 160 samples, I 
> will have 160 samples ready to capture. If there are only 159 samples 
> ready to be captured, my application will fail.

1) set avail_min to 160 (sw_params)
2) set start_threshold to boundary (sw_params) to disable automatic start
3) link streams (snd_pcm_link)
4) prepare playback (write some data)
5) start manually both streams (snd_pcm_start), note when streams are 
   linked, this command should be called only once, the second stream
   will be started automatically
6) wait for one period to be processed, if any stream is behind the other, 
   correct avail_min for the "master" stream and wait again

The reasons for which the playback and capture pointers might differ are:

1) two clock sources (two different cards)
2) bus/card FIFO issues

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
