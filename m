From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 08:47:04 +0200
Message-ID: <4E4A1268.9030003@ladisch.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A008D.60907@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 5A4EA2454C
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 08:47:09 +0200 (CEST)
In-Reply-To: <4E4A008D.60907@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> On 08/15/2011 10:31 PM, Pierre-Louis Bossart wrote:
> > - Increasing the number of packets/urbs solves my power issue but not the
> > synchronization issue. If I reduce the number of urbs to reduce the
> > interrupt rate, then the accuracy of the hw_pointer is decreased big time
> > and it becomes difficult to synchronize with video.
> 
> I think the same thing is a problem for quite a few other devices as
> well

Yes; sometimes, the period interrupt is the only information from which
the driver can derive the position.

> I wonder if we need some kind of "pointer granularity" variable
> to be exported through the ALSA API?

This is certainly possible, and by putting it into the hw_params, it
would be possible to model any dependencies between granularity and
period size.  However, this isn't quite at the top of my steadily-growing
ToDo list.

> a call to hw_pointer could return hw_pointer and time,

After calling snd_pcm_status(), you have snd_pcm_status_get_avail() and
snd_pcm_status_get_(h)tstamp().

> and then PulseAudio etc could use that for extrapolation

IIRC PA does exactly this if it detects that the pointer values don't
increase smoothly.


Regards,
Clemens
