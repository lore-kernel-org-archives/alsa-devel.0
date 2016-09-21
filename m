From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Gadget audio not working
Date: Wed, 21 Sep 2016 09:06:40 +0200
Message-ID: <22f487e7-3997-d434-216f-4f016ceb66d3@ladisch.de>
References: <CAES_P+9tg-Jgf3buOJwo1pGKX4USvoo6Fx_AEygMGiGaKVTeXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B31392665C1
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 09:06:41 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id 0A639F5201C9
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 09:06:40 +0200 (CEST)
In-Reply-To: <CAES_P+9tg-Jgf3buOJwo1pGKX4USvoo6Fx_AEygMGiGaKVTeXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

noman pouigt wrote:
> I am trying to use my device as a sound card and enabled
> CONFIG_USB_AUDIO.

That configuration is for the host driver, not for the gadget driver.

> I could get my device to be detected as a sound card

Then you have correctly enabled CONFIG_USB_F_UAC1.

> However I don't know what kind
> of device node should be added in the machine file?

As far as I can see, none.
See Documentation/usb/gadget-testing.txt.


Regards,
Clemens
