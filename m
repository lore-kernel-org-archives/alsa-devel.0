From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Vendor support in Alsa Drivers
Date: Thu, 12 Jun 2008 09:19:46 +0200
Message-ID: <4850CE12.9080908@ladisch.de>
References: <484E4E24.1060509@libera.cc> <s5h4p802ahz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 28ECC24953
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 09:19:50 +0200 (CEST)
In-Reply-To: <s5h4p802ahz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Emmanuel Kasper <emmanuel@libera.cc>
List-Id: alsa-devel@alsa-project.org

> Emmanuel Kasper wrote:
> > We will reference only devices which work with a free driver, so no
> > nvidia binary thingie or atheros HAL.  Based on the information
> > found on the alsa wiki we plan to reference the following sound
> > devices:
> >
> > M-Audio Audiophile 24/96 (  snd-ice1712 driver )
> > Terratec AUREON 5.1
> > M-Audio Fast Track usb
> > Hercules Muse Pocket LT
> > Ion TTUSB usb turnable ( these 4 working with snd-usb-driver )

Why only those?  All drivers in the ALSA tree are free.

Takashi Iwai wrote:
> I don't know about Ion.  Possibly Clemens had any contact?

No, all my drivers have been written with already-public datasheets or
using reverse engineering.


Regards,
Clemens
