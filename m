From: Giridhara  <giridharakn@gmail.com>
Subject: Re:
	=?utf-8?q?How_to_interrupt_snd=5Fpcm=5Fwritei_in_blo?=
	=?utf-8?q?cking_mode=3F?=
Date: Fri, 20 Dec 2013 10:58:16 +0000 (UTC)
Message-ID: <loom.20131220T115337-922@post.gmane.org>
References: <20050629180540.GA12922@brailcom.cz>
 <Pine.HPX.4.33n.0506301140550.15584-100000@studcom.urz.uni-halle.de>
 <s5h8y0s59vh.wl%tiwai@suse.de> <20050630184228.GA3755@brailcom.cz>
 <s5hacl74pvs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D52812654CC
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 12:05:13 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Vtxt9-00012y-6M
 for alsa-devel@alsa-project.org; Fri, 20 Dec 2013 12:05:03 +0100
Received: from 19963142252.honeywell.com ([199.63.142.252])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 12:05:03 +0100
Received: from giridharakn by 19963142252.honeywell.com with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 12:05:03 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai <tiwai <at> suse.de> writes:

> 
> At Thu, 30 Jun 2005 20:42:28 +0200,
> Hynek Hanke wrote:
> > 
> > > > Hynek Hanke wrote:
> > > > > I'm running it in two separate threads. One does all the
preparations and calls
> > > > > snd_pcm_writei() in blocking mode. The other one then decides it
wants to stop
> > > > > playing, so it calls snd_pcm_drop(). This causes the device to
switch from
> > > > > state RUNNING to state SETUP, but the snd_pcm_writei() hangs
forever and never
> > > > > returns. Why is this so?
> > > Well, but pcm_lib.c::snd_pcm_lib_write1() should check the state SETUP
> > > and break the loop immediately.  Ditto for snd_pcm_lib_read1().
> > > The quick hack is below.  Please give a shot.
> > 
> > I tried to apply the patch to the 2.6.11 kernel but after
> > compilation/instalation, there is no difference. It still hangs.
Logfiles say
> > it was in the state RUNNING just before snd_pcm_drop() was called and
got into
> > state SETUP immediatelly after. The logfile from the other thread shows
> > snd_pcm_writei() never returns (not even after the sound would surely be
> > completed).
> 
> Hmm, then still something is missing.  I'll check on it later.
> 
> > So, what can I do? Do I really have to use the non-blocking mode or is this
> > supposed to work (if I take care about all the other thread related issues
> > myself)? My colleague is reporting it's working for him under some different
> > configuration.
> 
> The non-blocking mode and poll() should work (hopefully :)
> If not, let me know.
> 
> > Can I enable some debugging messages or something to help you to see what's
> > wrong?
> 
> Check the code flow in snd_pcm_lib_write1().  You can see the places
> my patch tried to fix.  Basically, the thread should be woken up and
> get out of the loop.  But according to your report, it didn't work as
> expected by some reason...
> 
> Takashi
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> 


Hello Takashi,
We have the same problem. 
snd_pcm_writei blocks when we switch between playback and record
continuously for several times. 

Is this issue is fixed in any kernel versions.
I am running kernel version 2.6.31
Alsa version 1.0.18

is it a issue of buffers we allocate using 
snd_pcm_hw_params_set_period_size_near

whats the way to calculate this value and how should be the ideal value. 

I appreciate any help/suggestions in this regard.

Thanks and Regards,
Giri 
