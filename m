From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] US-122L Driver, v0
Date: Thu, 8 Nov 2007 17:42:28 +0100
Message-ID: <200711081742.28575.fzu@wemgehoertderstaat.de>
References: <200711071641.28551.fzu@wemgehoertderstaat.de>
	<200711081337.05417.fzu@wemgehoertderstaat.de>
	<1194538491.3947.1220263479@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id B188A24680
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 17:42:31 +0100 (CET)
In-Reply-To: <1194538491.3947.1220263479@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 8. November 2007 schrieb Clemens Ladisch:
> 
> I'm using the 8-microframes alignment because ehci-hcd configures the
> controller to interrupt at most every 1 ms.  It has a module option to
> change this, but as long as snd-usb-audio cannot detect a lower setting,
> it would not make sense to allow shorter periods.

For an 1ms interrupt alignment ehci-hcd must be loaded with non-default
parameters.
In ehci-hcd.c as of 2.6.23:

/* Initial IRQ latency:  faster than hw default */
static int log2_irq_thresh = 0;		// 0 to 6
module_param (log2_irq_thresh, int, S_IRUGO);
MODULE_PARM_DESC (log2_irq_thresh, "log2 IRQ latency, 1-64 microframes");

That makes a default IRQ latency of 1/8ms. This is also what I see here:
The us122l driver works with 64frames/period 2 periods at 96kHz sample rate.
Thats about 1400 interupts/s. Wouldn't be possible with 1ms alignment.

kind regards,
      Karsten
