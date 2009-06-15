From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Timing of linked devices
Date: Mon, 15 Jun 2009 15:31:58 +0200
Message-ID: <4A364D4E.3020908@ladisch.de>
References: <49237.65.105.226.50.1244847123.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 473A42445F
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 15:32:04 +0200 (CEST)
In-Reply-To: <49237.65.105.226.50.1244847123.squirrel@master.museresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: louis@museresearch.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

louis@museresearch.com wrote:
> I am developing an application which opens both inputs and outputs for
> digital and s/pdif (so, 4 devices).  The sync IDs all match.  However,
> under certain conditions, I am receiving partial buffers from the input. 
> So, I have a few questions:
> 
> Does linking input and output devices, from a programmer's perspective,
> mean that input is ready at precisely the same time that the device is
> ready to output a buffer?

No; linking just means that ALSA tries to start the streams at the same
time.  If the sync IDs match, the hardware actually supports this.

> Or, does it only mean that the ins and outs will be synchronized for
> each given buffer?

Not even that.  Linking streams does not guarantee that they run at the
same speed.

If two streams are handled by the same DMA controller and are using the
same clock, they should be perfectly synchronous.  In the case of S/PDIF
recording, the clock is determined by the sending device, so it is
likely to be different from the other stream.

> And, in the case that I am doing a non-blocking read (pcm_read) from a
> buffer which is not yet ready, should I receive an outdated buffer, a
> blank buffer, or one which has both partially new and partially old data?

You get no data and error code -EAGAIN.


HTH
Clemens
