From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: [PATCH] fixes warning of missing initializers for *.poll_revents
Date: Mon, 19 Apr 2004 16:44:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040419204442.GQ29645@zewt.org>
References: <20040419202638.GA18386@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040419202638.GA18386@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 19, 2004 at 10:26:38PM +0200, Martin Langer wrote:
> This bunch of patches fixes compiler warnings like these one:
> pcm_multi.c:646: warning: missing initializer
> pcm_multi.c:646: warning: (near initialization for
> snd_pcm_multi_ops.poll_revpcm_shm.c:589: warning: missing initializer  for
> snd_pcm_multi_ops.poll_revents')
> 
> But perhaps more interesting values than NULL are prefered.... Please review 
> before applying it.

gcc 2.95.4 and 3.0.4ive this warning, but 3.2.3 and 3.3.3 do not (with -Wall
-W, at least).  I think a large point of using this C99 syntax is to only
initialize what you want, and not clutter the code with lots of redundant
NULL initialization.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
