From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: underruns and POLLERR when copying audio frames
Date: Wed, 21 Jul 2010 09:07:24 +0200
Message-ID: <4C469CAC.3030202@ladisch.de>
References: <4C4581D9.8020309@gmail.com> <4C45A77B.4070802@ladisch.de>
	<4C462827.10105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2806D24484
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 09:07:25 +0200 (CEST)
In-Reply-To: <4C462827.10105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stefan Schoenleitner wrote:
> Clemens Ladisch wrote:
> > How do you synchronize the clocks of both devices?
> 
> I don't.  [...]
> I guess if clock drift gets too high, I will get xruns as well ?

Yes.

> > Why would mmap be more ideal?
> 
> I though that it would be possible to use mmapping to "connect" sound
> devices together in a way that read/write operations in between are no
> longer necessary.

Indeed.

> But as mmapping just seems to work for files, I no longer think it is
> possible.

Some optimization is possible even when only one device supports mmap:
When you want to copy from the hardware device to the plugin, you could
call the plugin's snd_pcm_writei with an address in the sound card's
buffer as the source.

> > To avoid overruns in the capture device, use a bigger buffer, which will
> > _not_ increase latency.
> 
> Can you explain to me why a bigger capture buffer will not introduce
> latency ?
> IMHO if there is a large capture buffer, then the sound-card will need
> to capture until the buffer is filled.
> Once this is the case, the application can start to read from the
> capture device.

The application can read from the capture buffer at any time.  When
using a blocking snd_pcm_read* call, it gets woken up at the end of each
period, if avail_min is not larger than the period size.

> It seems that at least one of my devices only supports a small avail_min
> setting.

avail_min can be as large as the buffer size.


Regards,
Clemens
