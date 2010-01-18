From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Mon, 18 Jan 2010 18:32:02 +0000
Message-ID: <hj29f0$v5d$1@ger.gmane.org>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id DF76B103802
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 19:32:26 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NWwOm-0005CT-So
	for alsa-devel@alsa-project.org; Mon, 18 Jan 2010 19:32:24 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 19:32:24 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 19:32:24 +0100
In-Reply-To: <alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
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

Hi Jaroslav,

'Twas brillig, and Jaroslav Kysela at 07/01/10 14:59 did gyre and gimble:
> The improved and more clean fix in now in my tree:
> 
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1250932e48d3b698415b1f04775433cf1da688d6
> 
> Note that you should apply these 4 patches (in reverse order):
> 
> 4: ALSA: pcm_lib - optimize wake_up() calls for PCM I/O
> 3: ALSA: pcm_lib - cleanup & merge hw_ptr update functions
> 2: ALSA: pcm_lib - add possibility to log last 10 DMA ring buffer positions
> 1: ALSA: pcm_lib.c - convert second xrun_debug() parameter to use defines
> 
> Patch #3 should definitely fix problems with large avail or delay values 
> reported in PA. I finally figured the culprit (and decide to cleanup all
> relevant code rather do just another workaround). In other words, new 
> hw_ptr pointer should never be less than previous one now.


Just wanted to ask about the status of this.

We included the fixes in Mandriva cooker kernel for wider testing but
some users are seeing issues.

These four *seem* to be OK, but after also adding the "something must be
really wrong" commit
(http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=7b3a177b0d4f92b3431b8dca777313a07533a710)
folks started getting some errors.

We also added the jiffies fix commit
(http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=ed69c6a8eef679f2783848ed624897a937a434ac)
but that didn't seem to help.

This is handled in our bug report here:
https://qa.mandriva.com/show_bug.cgi?id=57010

For reference relating to comment 12:
2.6.32.3-1mnb: First introduced the above 4 fixes.
2.6.32.3-2mnb: included 7b3a177
2.6.32.4-0.rc1.1mnb: included ed69c6a

Is there something more that needs done?

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
