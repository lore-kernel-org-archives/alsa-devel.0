From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: _mmap_playback_avail() short
Date: Tue, 29 Nov 2011 16:21:51 +0100
Message-ID: <4ED4F88F.1080504@ladisch.de>
References: <201110311738.52213.gineera@aspect135.co.uk>
	<201111251510.27592.gineera@aspect135.co.uk>
	<4ED3F955.4090904@ladisch.de>
	<201111291407.50367.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 65193103A8F
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 16:21:02 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CC9DA20998
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 10:20:59 -0500 (EST)
In-Reply-To: <201111291407.50367.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> On Monday 28 November 2011 21:12, Clemens Ladisch wrote:
> > As a workaround, try snd_pcm_hw_params_set_periods_integer().
>
> Integer period for the pcm is actually already being set.

Strange; there's a bug somewhere ...

> Can you also explain how the non-integer period *size* is handled?

There are no non-integer period sizes.

> In the test case, dmix is set to 48000 with period 1024.  So at 44100 the
> rate conversion means the corresponding period size is 940.8.  I am not
> sure how that gets handled.  From the params dump giving period as (940 941)
> I had anticipated that a mixture of 4 * 941 and one 940 period would occur.
> However, what I see is that at a period boundary there is always just 940
> avail_frames - is that correct?

Have a look in /proc/asound/cardX/pcm0p/sub0/hw_params.

> How does that get converted to the 1024 frames at 48000?  Will there be
> irregular timing?

The rate plugin uses the proportion of the two period sizes for rate
conversion.  In your example, 940 samples are always converted into 1024
samples; the actual sample rate is 48000/1024*940 = 44062.5.


Regards,
Clemens
