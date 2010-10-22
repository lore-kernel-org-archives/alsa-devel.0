From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SoC Atmel SSC stereo problem
Date: Fri, 22 Oct 2010 18:11:57 +0200
Message-ID: <4CC1B7CD.3030703@ladisch.de>
References: <4CC1AB01.3020603@fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 99A19103863
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 18:10:07 +0200 (CEST)
In-Reply-To: <4CC1AB01.3020603@fh-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Ziegler wrote:
> I have some trouble with stereo audio through the atmal ssc interface
> based on at91-ssc.c.

(Merged into atmel_ssc_dai.c since about one year ago.)

> Unfortunately left and right channels were swapped periodically.
> 
> In my environment the codec supplies the BLCK and LRC clocks and
> the SSC is configured to transmit one sample on both edges of the LRC clock.
> But I guess the audio frames will always start with a frame of the left channel
> while the LRC clock is in an undefined state.

Indeed.

> How does normally the audio driver detect when a left and when a right channel
> frame should be send and with which it should start ?

The driver cannot do anything about this; the hardware must be told
to start transmitting at the falling edge.

If possible.

Is there a reason why the codec supplies LRC?


Regards,
Clemens
