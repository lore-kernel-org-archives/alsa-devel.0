From: Rolf Meeser <rolfm_9dq@yahoo.de>
Subject: Fwd: Re: [PATCH] snd-usb-audio with multiple audio
	functions
Date: Mon, 06 Jun 2011 17:04:11 +0200
Message-ID: <4DECEC6B.10208@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com
	(nm30-vm0.bullet.mail.bf1.yahoo.com [98.139.213.126])
	by alsa0.perex.cz (Postfix) with SMTP id 504BB244FD
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 17:04:14 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On 06/06/2011 01:44 PM, Clemens Ladisch wrote:

>  Rolf Meeser wrote:
>>  +		if (usb_chip[i]&&
>>  +			(usb_chip[i]->dev == dev)&&
>>  +			(usb_chip[i]->ctrl_intf)&&
>>  +			(usb_chip[i]->ctrl_intf->desc.bInterfaceNumber == ifnum)) {
>  Many audio devices with multiple vendor-specific interfaces do not have
>  a control interface.  This code would split them into multiple cards.
>
>
>  Regards,
>  Clemens
>

Breaking existing setups would indeed be bad!

Can you see an easy way to identify such cards here? Then we could assign a new
card index only in case of a class compliant card, where this is desirable.

Regards,
Rolf
