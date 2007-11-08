From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] US-122L Driver, v0
Date: Thu, 08 Nov 2007 17:14:51 +0100
Message-ID: <1194538491.3947.1220263479@webmail.messagingengine.com>
References: <200711071641.28551.fzu@wemgehoertderstaat.de>
	<200711071955.16686.fzu@wemgehoertderstaat.de>
	<1194506689.14959.1220188671@webmail.messagingengine.com>
	<200711081337.05417.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BA907248EA
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 17:14:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200711081337.05417.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> snd-usb-audio uses number_of_packets equalling multiples of 8 currently
> when transfering over USB 2.0, no?
> If so, with above patch that "multiples of 8"-thing could go away and
> snd-usb-audio could achieve up to 8 times less userspace-activation-jitter
> in low latency setups like 128 frames/period, 2 periods.

I'm using the 8-microframes alignment because ehci-hcd configures the
controller to interrupt at most every 1 ms.  It has a module option to
change this, but as long as snd-usb-audio cannot detect a lower setting,
it would not make sense to allow shorter periods.


Regards,
Clemens
