From: Wolfgang Hesseler <wolf1122@gmx.net>
Subject: Re: Callback after a specified number of samples
Date: Mon, 30 Sep 2002 16:17:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D979F1F.5EDC@gmx.net>
References: <20020929195903.6404gmx1@mx024-rz3.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis <pbd@op.net> wrote

> >Hello,
> >is it possible to get a callback after a specified number
> >of samples (e.g. 4000) are played?
> >I'd like to refill the buffer then and need the exact
> >number to synchronize audio and video.
> 
> you can get this to a limited extent by setting the software parameter
> "avail_min" with snd_pcm_sw_params_set_avail_min(). it controls the
> number of frames of data/space that has to be available for a task
> sleeping on a read/write of the PCM stream to be woken up.
> 
> however, it won't do what you want, because the resolution is limited
> to the interrupt frequency of the audio card, and for just about every
> interface out there, this is almost always a power of 2 value. 

Is this an Alsa design or a hardware limitation?

> thus,
> you could set avail_min to 4000, but you be will woken only when the
> actual value is 4096, not 4000. why? because the ALSA driver has no
> way of knowing when the value is 4000 - it can only know when the
> interrupt comes in.
> 
> the only way around this is to use an alternate, higher-frequency
> interrupt source, such as the RTC (real time clock), but this
> is invariably power-of-2 also, and worse, doesn't run in sync
> with audio or video. if you could find a suitable source, you just
> check the current frames/space available every interrupt, and move on
> from there. i don't know of any suitable interrupt sources.
> 
> to put it another way, your approach is wrong :) syncing audio and
> video needs to be done differently. audio has a much higher frame
> rate, so use that as the basic time source, and simply redraw the
> screen at suitable intervals (preferably the vertical refresh
> interval), using the current audio "time" as a guide to what to draw.

You think of polling snd_pcm_avail_update and drawing the picture when
the calculated number of samples have been played?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
