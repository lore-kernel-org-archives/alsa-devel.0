From: Troy Benjegerdes <hozer@hozed.org>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Sat, 4 Jan 2003 17:58:36 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030104235836.GN28177@altus.drgw.net>
References: <20030103042233.GK28177@altus.drgw.net> <Pine.LNX.4.33.0301031054130.500-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301031054130.500-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 
> We have command-line ac3dec in our alsa-tools package.
> 

current cvs doesn't compile.

output.c: In function `output_open':
output.c:146: warning: passing arg 3 of 
`snd_pcm_hw_params_set_period_time_near' makes integer from pointer 
without a cast
output.c:154: warning: passing arg 3 of 
`snd_pcm_hw_params_set_period_time_near' makes integer from pointer 
without a cast
output.c:43: warning: unused variable `rate'


I'm not sure how to fix line 145.. does the rate it got set to get 
returned in the return value??

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
