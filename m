From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dealing with under runs?
Date: Fri, 20 Jan 2006 09:03:55 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601200902460.9036@tm8103.perex-int.cz>
References: <20060119174600.GT19398@stusta.de> <1137694944.32195.1.camel@mindpipe>
 <Pine.LNX.4.61.0601191828330.9960@holly>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C463153
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 09:03:56 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601191828330.9960@holly>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Raggett <dsr@w3.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Jan 2006, Dave Raggett wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Excuse what are probably dumb questions from a newbie to writing
> ALSA applications.
> 
> I am trying to figure out how to deal with preparing for play
> back and recovering from underruns in a network application that downloads
> audio as part of an HTTP response. I am using the asynchronous call back
> mechanism.
> 
> When the audio data is already available when I set up the
> audio interface all goes well. If there is a delay then I am
> having problems. This happens when the HTTP headers for the
> response are in one packet and the audio data for the start
> of the HTTP body are in another. I currently initialize the
> ALSA PCM interface when the HTTP response headers have been
> parsed and the content type has been determined.
> 
>  Initializing audio playback:
> 
> a) snd_pcm_open
> b) set_hwparams
> c) set_swparams
> d) snd_async_add_pcm_handler
> e) snd_pcm_writei with audio data
> 
> If no audio data is available in step (e) I call snd_pcm_start to ensure that
> the callback will be regularly invoked and therefore able to transfer data
> from the network to the PCM interface. I use snd_pcm_avail_update to check for
> the available space in the PCM buffer and substitute silence (170 samples @
> 8Khz) if no audio data is available. If an underrun does occur (presumably the
> cpu was too busy to attend to the call back in sufficient time) I then use the
> xrun_recovery routine to try to recover.
> 
> Unfortunately, I then get:
> 
> ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params:
> params->avail_min problem for start_threshold
> speechproxy: pcm.c:2094: snd_pcm_wait: Assertion `err == 1' failed.
> Aborted

Try upgrade. This check has been recently removed.

> Any ideas?
> 
> p.s. is there a routine for mapping the pcm state into a string
> for use with printf?  That would be handy for debugging.

snd_pcm_state_name(state)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
