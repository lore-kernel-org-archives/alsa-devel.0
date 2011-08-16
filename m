From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 12:19:42 -0500
Message-ID: <12273.0475770824$1313515198@news.gmane.org>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de>
	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
	<4E4A9644.3020507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B7AD245BA
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 19:19:45 +0200 (CEST)
In-Reply-To: <4E4A9644.3020507@ladisch.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>, 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> > What is this USB frame counter and what would to enable its use, at
> > least for playback where there is scope for lots of power
> > optimizations.
> 
> USB timing is defined by frames, of which there are about 1000 per
> second.  The audio driver schedules one packet to be sent/received for
> each frame.  Multiple packets are grouped in a URB (USB request
> buffer);
> the controller raises an interrupt when the last packet of the URB has
> been completed.
> 
> By reading the current frame number, the driver could deduce how many
> packets (and therefore, how many samples) have been processed by the
> controller.


Thanks Clemens, this is valuable information.
If this frame number was used to update the delay field with more accuracy,
I'd be able to use a larger number of packets while allowing for precise a/v
sync. Removing the memcpys, etc, are probably a second-degree optimization.
I agree it'd make the code more complex. 
Any idea on how this frame number can be read, I can try to prototype this
if this is supported by the USB core?
-Pierre
