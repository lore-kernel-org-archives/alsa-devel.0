From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: loading firmware to the codec not successful
Date: Wed, 31 Aug 2011 22:16:17 +0200
Message-ID: <4E5E9691.3040607@ladisch.de>
References: <CAODvfaHquCrfCdb8ypCcii4UE5vKRzX=_iVhUp-nvNWRCM5YOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 671A5244A4
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 22:16:41 +0200 (CEST)
In-Reply-To: <CAODvfaHquCrfCdb8ypCcii4UE5vKRzX=_iVhUp-nvNWRCM5YOw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Appalayagari Sreedhar <sreecha01@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Appalayagari Sreedhar wrote:
> "usr/lib/firmware" it is not working

AFAIK this should be /lib/firmware.

123456789012345678901234567890123456789012345678901234567890123456789012
Please not that firmware loading will not work during booting before the
file systems are mounted (i.e., if the driver is not compiled as
a module).  In that case, you have to put the firmware image into the
kernel, too (see CONFIG_FIRMWARE_IN_KERNEL or CONFIG_EXTRA_FIRMWARE).


Regards,
Clemens
