From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Assert error
Date: Sun, 23 May 2004 19:44:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405231941520.2139@pnote.perex-int.cz>
References: <20040523235035.48c8c3cf.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040523235035.48c8c3cf.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 23 May 2004, Erik de Castro Lopo wrote:

> Hi all,
> 
> I'm getting an assert error:
> 
>     ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params: params->avail_min 
>          problem for start_threshold
>     sndfile-play: pcm.c:2084: snd_pcm_wait: Assertion `err == 1' failed.
> 
> Surely it would be better to fail a little more gracefully than this.

The assert has nothing to do with the start_threshold problem. Can you
list the plugin chain? - snd_pcm_dump() - and perhaps, upgrade to latest 
ALSA code (I have mentioned assert on line 2094).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
