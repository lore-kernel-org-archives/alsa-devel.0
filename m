From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa-firmware licensing
Date: Mon, 07 Jan 2008 11:41:21 +0100
Message-ID: <1199702481.16243.1229842463@webmail.messagingengine.com>
References: <477F9103.9010304@timj.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E5CA524882
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 11:41:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <477F9103.9010304@timj.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Jackson <lists@timj.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tim Jackson wrote:
> b) More worryingly, the Emagic EMI 2|6 firmware appears to be under a 
> "license" which prohibits ANY redistribution. Quoting from 
> emi_26_62/license.txt (my emphasis):
> 
> "The firmware contained herein is Copyright (c) 1999-2002 Emagic
> as an unpublished work. This notice does not imply unrestricted
> or public access to this firmware which is a trade secret of Emagic,
> and which ***may not be reproduced, used, sold or transferred to
> any third party without Emagic's written consent.***"

The emi firmware files are copies of linux/drivers/usb/misc/emi26_fw.h
and emi62_fw_*.h.  emi26_fw.h contains three copies of this "license",
but only the first one contains this paragraph which is missing in
license.txt:

| Permission is hereby granted for the distribution of this firmware 
| image as part of a Linux or other Open Source operating system kernel 
| in text or binary form as required. 

I've added this paragraph to license.txt.

> Does the ALSA project have special authorisation ("written consent") to 
> distribute this?

Well, I'd guess the alsa-firmware package is part of Linux.

Please note that the emi26 and emi62 drivers still use the in-kernel
copies of their firmware images; the files in alsa-firmware are as yet
unused.

> Does anyone have a contact at Emagic (which seems to have been 
> bought by Apple) to discuss relaxing the firmware conditions slightly?

Emagic helped writing the emi26 driver, but these devices were
discontinued shortly after Apple bought Emagic.  AFAIK nobody now at
Apple knows, or cares.


Regards,
Clemens
