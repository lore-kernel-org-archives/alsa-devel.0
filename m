From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: UAC2 defaults to max sampling rate
Date: Wed, 23 May 2012 11:18:10 +0200
Message-ID: <4FBCAB52.8030904@ladisch.de>
References: <4FBC98FC.6000200@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C58EE103F95
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 11:18:11 +0200 (CEST)
In-Reply-To: <4FBC98FC.6000200@freemail.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: adelias <adelias@freemail.gr>
Cc: alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

adelias wrote:
> I'm running ALSA 1.0.23 and kernel 2.6.37 on ARM. The UAC2 audio device
> is the XMOS reference board.
>
> This is what I'm observing. As soon as the XMOS board is plugged in to
> the USB port, the display on my DAC indicates that is has locked at
> 192kHz which is the maximum sampling rate supported by the XMOS.

This is an as-yet unfixed bug in the driver.
(The usb_set_interface call in snd_usb_add_endpoint is completely
superfluous.)


Regards,
Clemens
