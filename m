From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_writei not returning (?!?)
Date: Tue, 6 Apr 2004 12:15:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404061213230.3153@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0404060944170.17488-100000@studcom.urz.uni-halle.de>
 <01d901c41bb6$988aaf40$0100a8c0@burpxp> <Pine.LNX.4.58.0404061114560.3153@pnote.perex-int.cz>
 <021d01c41bbd$b0a8fc10$0100a8c0@burpxp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <021d01c41bbd$b0a8fc10$0100a8c0@burpxp>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tom Browne <tbrowne@tbrowne.demon.co.uk>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Apr 2004, Tom Browne wrote:

> Jaroslav Kysela wrote:
> >>  alsa_buffer_size = snd_pcm_hw_params_get_buffer_size(params);
> >>  err = snd_pcm_hw_params_set_period_time_near(handle, params,
> >> alsa_period_time, &dir);
> >>  alsa_period_size = snd_pcm_hw_params_get_period_size(params, &dir);
> >> ...
> >>  err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
> >> alsa_buffer_size-1)
> > It's not correct and it was never correct, but the pcm.c was buggy,
> > too. Look to the latest version.
> 
> Running a file compare, I see only one line of significant difference
> between the version in 0.9rc2 and 1.0.4 pcm.c...
> 
>  err = snd_pcm_sw_params_set_start_threshold(handle, swparams, (buffer_size
> / period_size) * period_size);
> 
> Which gives threshold = 6552 from buffer=6553, period=3276... exactly the
> same value as the code I was already using gives!  What else am I missing
> from the garish red and yellow blocks of WinDiff?

Then it really appears like a bug. Could you add snd_pcm_dump() call just 
before the block occurs?

> Why does changing to mmap writes make the blocking problem go away?  And as
> I said, the problem only has been made to occur at 88.2 and 96K sampling
> rates...

mmap does never block

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
