From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: intel8x0.c
Date: Tue, 30 Mar 2004 17:41:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403301736120.1835@pnote.perex-int.cz>
References: <20040330145655.64254.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040330145655.64254.qmail@web25102.mail.ukl.yahoo.com>
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
> Hi all,
>   I have an intel810 onboard soundcard.I am using the
> alsa driver with a VoIP session.
>   The intel8x0.c file has a minimum period byte size
> of 32 bytes with the minimum no. of periods being
> 1.The min and max rate is set to 48k. 
> 
> How can I find out what actual(runtime) size period
> the alsa driver is dealing with? 

After the snd_pcm_hw_params() call, the given hardware parameter
container will have the chosen period size or 
snd_pcm_hw_params_current() creates the current hw_params
container.

Then use snd_pcm_hw_params_get_period_size() or
snd_pcm_hw_params_get_period_time().

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
