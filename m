From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_writei not returning (?!?)
Date: Tue, 6 Apr 2004 11:15:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404061114560.3153@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0404060944170.17488-100000@studcom.urz.uni-halle.de>
 <01d901c41bb6$988aaf40$0100a8c0@burpxp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <01d901c41bb6$988aaf40$0100a8c0@burpxp>
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

> Clemens Ladisch wrote:
> >> state: PREPARED
> > The pcm isn't (yet) running.
> >
> >> avail       : 5
> > And the buffer is almost full.  snd_pcm_writei blocks because it
> > cannot write more data to the buffer, probably because the transfer
> > threshold is too high.
> 
> ?!  See below...
> 
> > How do you start the pcm?  If you're using the start threshold, it may
> > be too big, too.
> 
> The code is based on alsa-lib/test/pcm.c using the poll method, so if you
> look at that, you'll see how most of the parameters are set in my code.  I
> had to change to alsa_buffer_size-1 after upgrading to ALSA 0.9rc6 (I was
> using rc2, if memory serves) otherwise it never started playing... it seems
> something had changed in alsa-lib around this time.
> 
>  alsa_buffer_size = snd_pcm_hw_params_get_buffer_size(params);
>  err = snd_pcm_hw_params_set_period_time_near(handle, params,
> alsa_period_time, &dir);
>  alsa_period_size = snd_pcm_hw_params_get_period_size(params, &dir);
> ...
>  err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
> alsa_buffer_size-1)

It's not correct and it was never correct, but the pcm.c was buggy, too.
Look to the latest version.

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
