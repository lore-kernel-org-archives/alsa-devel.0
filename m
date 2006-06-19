From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: IO streams sync
Date: Mon, 19 Jun 2006 20:05:39 +0100
Message-ID: <4496F583.5060701@superbug.co.uk>
References: <mailman.3908.1150727591.2958.alsa-devel@lists.sourceforge.net>
	<4496CE0A.2000109@openstudionetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4496CE0A.2000109@openstudionetworks.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alejandro <alejandro@openstudionetworks.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

alejandro wrote:
> Hello,
> 
> Is there any document describing the ALSA components and functions?
> Particularly the link between audio I/O and timers, in order to frame 
> accurate sync multiple audio cards and video.
> 
> Thank you,
> 

Alejandro,

This is achieved using the snd_pcm_delay() function call.
It gives you a measure of the number of samples between the current
write pointer and the codec output.
I.e. If you call snd_pcm_writei() now, it will be snd_pcm_delay() sample
frames duration until the sample reach the speakers.
So, from that you can accurately predict the exact time that a
particular sample will reach the speakers, and therefore keep video in
sync with it.
This method is used in xine  (http://xinehq.de)
See the audio_out.c loop.

One then combines this with a resampler (as xine does), to adjust for
clock speed differences between sound cards and the system timer, so
this prevents sync drift.

James
