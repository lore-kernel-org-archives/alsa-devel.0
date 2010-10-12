From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Tue, 12 Oct 2010 09:18:31 +0200
Message-ID: <20101012071831.GA7159@buzzloop.caiaq.de>
References: <4CA60C5B.6010809@ladisch.de> <4CA86E1A.30405@showlabor.de>
	<4CAAD212.9090805@ladisch.de> <4CAC804A.8040806@showlabor.de>
	<4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de> <4CAEB9AC.1060208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E104F24466
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 09:18:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CAEB9AC.1060208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 08, 2010 at 08:26:52AM +0200, Clemens Ladisch wrote:
> Felix Homann wrote:
> > @Daniel:
> > You asked for the output of lsusb. Are you thinking of modifying the
> > UA-101 driver yourself? Or something more generic?
> 
> I guess he wanted to look for UAC2 descriptors (which this device does
> not have).

Actually, I wanted to check whether the device marks the inbound
(capture) endpoint as isochronous with implicit data feedback usage.
Which it doesn't either.

> When (if) the driver has UAC2 implicit feedback support, it's easy to
> add a simple quirk that makes the FTU work.  (In that case, the UA-101
> driver can be merged back, too.)

I wonder if we can always fall back to implicit feedback in case a
playback substream does not have a syncpipe and does not have its
fill_max bit set.

Felix, can you add a

  printk(KERN_WARNING "%s() is_playback %d fill_max %d syncpipe %d\n",
  	 __func__, is_playback, subs->fill_max, subs->syncpipe);

at the end of set_format() in pcm.c and send us the output?

I have an untested patch ready which should add support for implicit
feedback, but I'm uncertain about the condition when to activate this
mode.


Daniel
