From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: New Guy Here...
Date: Fri, 08 Feb 2008 08:59:29 +0100
Message-ID: <47AC0BE1.2070909@ladisch.de>
References: <47ABC502.3080808@gmail.com>	<1202439768.3719.404.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
	<47ABC93D.3020009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D34D2103803
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 08:57:38 +0100 (CET)
In-Reply-To: <47ABC93D.3020009@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Minko Minkov <msm028@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Minko Minkov wrote:
> Well, for playback it works great. This thing has awesome sound. It
> would only accept S24_3LE format and 96000KHz rate. I thought you get
> that rate only with the advanced switch on. Mine is off.

AFAIK these switches only have effect after you've re-plugged the
device.

> Also acrecord -l does not list the device as recording device.

This device does not support full duplex at 96 kHz.  The switches and
their valid combinations should be documented in the manual.


Regards,
Clemens
