From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CS5530 on Geode GX1 won't work
Date: Wed, 16 Jul 2008 10:43:26 +0200
Message-ID: <487DB4AE.4070901@ladisch.de>
References: <200807152315.23490.georg.brand@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 7C8CD243B4
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 10:43:28 +0200 (CEST)
In-Reply-To: <200807152315.23490.georg.brand@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: georg <georg.brand@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

georg wrote:
> root@tux:~# aplay foo.wav
> aplay: main:546: audio open error: Device or resource busy
> ...
> root@tux:~# lsof | grep -i pcmC0D0p

It's possible that the device has been opened with OSS (i.e., /dev/dsp*)
or that somebody has opened the capture device (SB doesn't do full
duplex).  Is there anything in /dev/ that is being used?


Regards,
Clemens
