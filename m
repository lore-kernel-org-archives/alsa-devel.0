From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb: refine delay information with
 USB	frame counter
Date: Thu, 25 Aug 2011 09:54:14 +0200
Message-ID: <4E55FFA6.90506@ladisch.de>
References: <1314221197-23719-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 37A98247EE
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 09:54:15 +0200 (CEST)
In-Reply-To: <1314221197-23719-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> This patch relies on the USB frame counter ...

> +	if (frame_diff < 0)
> +		frame_diff += 1024; /* handle 10-bit wrap-around */

After reading through some HCD source files, I deduced the following
wrap-arounds:

EHCI: 8-10 bits (default 9)
FHCI: 11 bits
IMX21: 16 bits
ISP1760: 10 bits
OHCI: 16 bits
OXU210HP: 10 bits
R8A66597: 10 bits
SL811: 5 bits(!?)
UHCI: 32 bits
xHCI: ?

So which hardware did you test this on?  :-)

As long as there isn't an API that tells us about the valid range of the
frame counter, we should probably mask off all except the lowest few bits.


Regards,
Clemens
