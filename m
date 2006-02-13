From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: prealloc/buffer time limit?
Date: Mon, 13 Feb 2006 18:16:19 +0000
Message-ID: <ad2655cb0602131016t12db33dh@mail.gmail.com>
References: <43ED016D.9030301@request.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43ED016D.9030301@request.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ron Cococcia <ron.cococcia@request.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/02/06, Ron Cococcia <ron.cococcia@request.com> wrote:
> Hello,
>
> Recently I've been playing around with buffering in ALSA to reduce the
> number of underruns I observe when playing audio under heavy system
> load.  The playback device has 64k allocated by default, and I upped it
> to 128k (echo 128 > /proc/asound/card0/pcm0p/sub0/prealloc).  I observed
> a significant reduction in underruns with this change.  The buffer time
> went from 371519 to 743038 (using snd_pcm_hw_params_set_buffer_time_near
> to 5000000 (not .5 sec, but 5 sec)).  I am assuming that the value is
> updated to give the actual available buffer time after snd_pcm_hw_params
> has complete (please inform me if I am wrong!!).
>
> I then tried to up it to 256, and it didn't work (prealloc remained at
> 128).  I went into the driver for the sound device (intel8x0), and
> noticed the buffer_max being set to 128.  I modified the max values to
> 512k (overkill, but I want to experiment a little), recompiled,
> installed, etc.
>
> When I tried to increase it to 256, prealloc reports 256 successfully
> (same for 512).  The buffer time did not increase, however.  I am
> looking to be able to increase the buffer time a little further.  I have
> been poking through code (at a snail's pace unfortunately) to see if I
> can find some other place where this value is limited (driver, lib,
> etc).  Either prealloc reports the value and doesn't actually have a
> larger buffer, or some other buffer time limit is in place that I
> haven't been able to find yet.
>
> Is there some other place I can check to increase the buffer time (in
> particular, if I increase the prealloc size).
>
> TIA,
> Ron
>

You are most likely running up against the hardware limitations of the
sound card.
If the hardware DMA pointer is only X bits long, it won't matter how
big you make the buffer, the sound card will not be able to use it.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
