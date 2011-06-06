From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] snd-usb-audio with multiple audio functions
Date: Mon, 06 Jun 2011 13:44:01 +0200
Message-ID: <4DECBD81.4090007@ladisch.de>
References: <4DEC787C.3050805@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 39BBD243B2
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 13:42:10 +0200 (CEST)
In-Reply-To: <4DEC787C.3050805@yahoo.de>
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
> +		if (usb_chip[i] &&
> +			(usb_chip[i]->dev == dev) &&
> +			(usb_chip[i]->ctrl_intf) &&
> +			(usb_chip[i]->ctrl_intf->desc.bInterfaceNumber == ifnum)) {

Many audio devices with multiple vendor-specific interfaces do not have
a control interface.  This code would split them into multiple cards.


Regards,
Clemens
