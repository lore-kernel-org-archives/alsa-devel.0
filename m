From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Possible message repeat
Date: Wed, 13 Jun 2012 16:48:50 +0200
Message-ID: <4FD8A852.1080502@ladisch.de>
References: <CAAo96ZB8WUuFyNm-GcLubh+uJ2v99-U_7uXFEtHBi638E=vWhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 41B0810454B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 16:48:54 +0200 (CEST)
In-Reply-To: <CAAo96ZB8WUuFyNm-GcLubh+uJ2v99-U_7uXFEtHBi638E=vWhw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brent Weatherall <brentweatherall@gmail.com>
Cc: alsa-devel@alsa-project.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

Brent Weatherall wrote:
> I am trying to specify an extension to the UAC specification and then
> write a user space driver/application to use the extension when
> a device that supports it is available in Linux.
>
> Can anyone assist me with the best path forward for writing user space code
> to use the XU I am going to define?  Meaning generically speaking how to
> use UAC XU controls in ALSA.

XU controls cannot be used generically.  The driver must be extended to
create the vendor-specific controls of this particular device; or the
driver could get a function to allow userspace to add such controls.

> it appears that any XU controls would be processed through usbmixer.c,
> but I don't see how to use the code in usbmixer from user space.

That code creates mixer controls.

> And so far I can't tell what source usbmixer resides in.

sound/usb/mixer.c in the kernel source, although such extensions
probably belong into mixer_quirks.c.


Regards,
Clemens
