From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Sun, 5 Jan 2003 15:30:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301051528350.500-100000@pnote.perex-int.cz>
References: <20030104235836.GN28177@altus.drgw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030104235836.GN28177@altus.drgw.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 4 Jan 2003, Troy Benjegerdes wrote:

> > 
> > We have command-line ac3dec in our alsa-tools package.
> > 
> 
> current cvs doesn't compile.
> 
> output.c: In function `output_open':
> output.c:146: warning: passing arg 3 of 
> `snd_pcm_hw_params_set_period_time_near' makes integer from pointer 
> without a cast
> output.c:154: warning: passing arg 3 of 
> `snd_pcm_hw_params_set_period_time_near' makes integer from pointer 
> without a cast
> output.c:43: warning: unused variable `rate'
> 
> 
> I'm not sure how to fix line 145.. does the rate it got set to get 
> returned in the return value??

You don't use the current CVS sources. I have first *period_time_near
call on line 147.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
