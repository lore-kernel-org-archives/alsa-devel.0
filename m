From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH] Support Rane SL 1 (aka. Serato Scratch
 Live) interface
Date: Sun, 2 Sep 2007 23:41:36 +0100 (BST)
Message-ID: <alpine.BSO.0.9999.0709022322160.2845@metheny.ijneb.com>
References: <alpine.BSO.0.9999.0709021447440.32425@metheny.ijneb.com>
	<46DAD72D.7020007@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 12246243B2
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 00:41:38 +0200 (CEST)
In-Reply-To: <46DAD72D.7020007@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LCID Fire <lcid-fire@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2 Sep 2007, LCID Fire wrote:

> There should already be a quirks entry present using
> USB_DEVICE(0x13e5, 0x0001),
> 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
> 	{
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 	}
>
> At least for my device this is working...

Sorry, I did not notice that, as it happened off-list.

But the above quirk does not allow the full capability (eg. mixer) to be 
used? I shall submit a new patch which updates it.

Mark
