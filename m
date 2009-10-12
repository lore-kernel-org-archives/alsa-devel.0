From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] [snd-usb-audio] Add match for JMTek USB
	sound	card
Date: Mon, 12 Oct 2009 08:46:26 +0200
Message-ID: <4AD2D0C2.40307@ladisch.de>
References: <1255173329-20485-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5F8CE2455E
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 08:46:57 +0200 (CEST)
In-Reply-To: <1255173329-20485-1-git-send-email-lkundrak@v3.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Lubomir Rintel wrote:
> Entry for JMTek LLC., SSS USB Headphone Set in the quirk table.

Please add an explaination why this entry is needed.  At first glance,
this entry seems to describe a class-compliant device that should not
need a quirk.

> +/* JMTek, LLC. SSS USB Headphone Set */
> +{
> +	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
> +		       USB_DEVICE_ID_MATCH_DEV_CLASS |
> +		       USB_DEVICE_ID_MATCH_INT_CLASS |
> +		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
> +	.idVendor = 0x0c76,
> +	.idProduct = 0x1605,
> +	.bDeviceClass = USB_CLASS_PER_INTERFACE,
> +	.bInterfaceClass = USB_CLASS_AUDIO,
> +	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
> +},


Best regards,
Clemens
