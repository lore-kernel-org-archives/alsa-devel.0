From: Brent Weatherall <brentweatherall@gmail.com>
Subject: Possible message repeat
Date: Wed, 13 Jun 2012 07:13:45 -0700
Message-ID: <CAAo96ZB8WUuFyNm-GcLubh+uJ2v99-U_7uXFEtHBi638E=vWhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 407B12456F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 16:13:46 +0200 (CEST)
Received: by yenr13 with SMTP id r13so494454yen.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 07:13:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

Hello.  I sent this message previously before I solidified my membership to
the list and it seems my message never posted.  Here it is again.
 My apologies if did go through and I missed it.

I am new to audio development in Linux.  I have worked with user space
development with respect to UVC code and I have worked with specifying an
XU in UVC.  I wrote a user space driver/application to talk to a device
supporting the UVC XU in Linux.  I am trying to specify an extension to the
UAC specification and then write a user space driver/application to use the
extension when a device that supports it is available in Linux.  Pretty
much the same situation as I have already done with UVC XU.  Windows and
Mac code will follow, but right now I am only concerned with Linux.

Can anyone assist me with the best path forward for writing user space code
to use the XU I am going to define?  Meaning generically speaking how to
use UAC XU controls in ALSA.  I was looking for code samples that use the
audio.h header file interface, but after a day and a half I am coming to
conclusion that only kernel space uses audio.h and that I will need to go
through ALSA to accomplish my task.  Again, this will be user space code I
want distribute easily, with minimal dependencies.  Our code will be
apache licensed afterwards if possible, just like our UVC code was.  So any
work I do should be freely available to the community afterwards. **EDIT
FROM PREVIOUS MESSAGE**  After more searching, it appears that any XU
controls would be processed through usbmixer.c, but I don't see how to use
the code in usbmixer from user space.  And so far I can't tell what source
usbmixer resides in.  I downloaded the alsa-lib source in Fedora, but I
don't see that file.  Is this a Linux kernel file?  So far I am having lots
of trouble finding anything useful regarding audio XUs in Linux.  My
apologies if this should be simple.  Thank you in advance for
any assistance.

Best Regards,

Brent
