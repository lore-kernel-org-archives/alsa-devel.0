From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Tue, 19 Feb 2002 08:15:56 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202190812250.535-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202190354560.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002, Kai Vehmanen wrote:

> I think we can close this problem at least for now. The cause for the
> garbled audio problem was found from JACK's side.
>
> I'm still a bit puzzled why I didn't get xruns in the test case quoted
> below, but until I can reproduce the problem, there's not much to discuss
> about. But for the readers of alsa-devel archives, if you are having xrun
> detection problems with ALSA mmap pcm API, do post a message about it. :)

You posted this sw params on alsa-devel a few days ago:

sw_params:

tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1024
xfer_align: 1024
start_threshold: 4294967295
stop_threshold: 4294967295
silence_threshold: 0
silence_size: 0
boundary: 1073741824
--cut--

As you can see, the stop_threshold is set to UMAX_INT. In case when
stop_threshold is above ring buffer size, then it means for drivers: I
don't care about xruns, don't report them. The stop threshold must be
equal to ring buffer size to get xruns when no more frames are in ring
buffer.

> On Thu, 14 Feb 2002, Kai Vehmanen wrote:
>
> > - no xruns are detected even though after the timeout
> >   alsa_driver_wait() took 56.4msec which is more than
> >   period_size * number_of_periods (1024*2/44100*1000=46msec);
> >   in other words there should have been an xrun

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
