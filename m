From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: intel8x0.c
Date: Tue, 30 Mar 2004 19:28:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403301927530.23263@pnote.perex-int.cz>
References: <20040330172002.20748.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040330172002.20748.qmail@web25102.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Mar 2004, Brian Furey wrote:

> 
> Right Jaroslav,
>    that means i would modify intel8x0.c to include a
> call to 
> snd_pcm_hw_params_get_period_size() or
> snd_pcm_hw_params_get_period_time() in the appropriate
> place. Write the values returned say to a text file.
> Recompile the ALsa driver and re-insert it into the
> kernel.Start my application and check contents of text
> file.
> Am I right in saying this?

I'm talking about application not the driver.
Why you need to modify driver?

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
