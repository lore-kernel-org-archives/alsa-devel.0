From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] snd-usb-audio with multiple audio functions
Date: Mon, 06 Jun 2011 17:47:04 +0200
Message-ID: <4DECF678.4090808@ladisch.de>
References: <4DEC787C.3050805@yahoo.de> <4DECBD81.4090007@ladisch.de>
	<4DECC12F.60101@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 832362433D
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 17:45:11 +0200 (CEST)
In-Reply-To: <4DECC12F.60101@yahoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rolf Meeser <rolfm_9dq@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rolf Meeser wrote:
> On 06/06/2011 01:44 PM, Clemens Ladisch wrote:
> > Many audio devices with multiple vendor-specific interfaces do not have
> > a control interface.  This code would split them into multiple cards.
> 
> Breaking existing setups would indeed be bad.
> Are that cards with audio interfaces not following the Audio Class spec?

Yes.

> What would be the easiest way to identify them, so we could assign a new
> card index only in case of a compliant card?

Non-compliant devices don't have a control interface.

In theory, the USB core probes a device's interfaces in order, so the
control interface usually is probed first.  However, I'm not sure if
this is really true for all devices.  It's probably safest to check
explicitly if the device has any interface marked as audio control 1/2.


Regards,
Clemens
