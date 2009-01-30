From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Edirol UA-20 in advanced mode
Date: Fri, 30 Jan 2009 14:10:13 +0100
Message-ID: <4982FC35.3090601@ladisch.de>
References: <ed82be370901291008h57b88039s950f64e5d228150b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id F40912438F
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 14:10:18 +0100 (CET)
In-Reply-To: <ed82be370901291008h57b88039s950f64e5d228150b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nick83ola <nick83ola@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

nick83ola wrote:
> I have an old edirol UA-20 that not work with advanced driver, or perhaps I
> see it, i can send midi in and out from it but audio don't work.
> ...
> damnick@damnick-nb:~$ dmesg|tail
> [ 1287.914930] cannot submit datapipe for urb 0, error -90: internal error

This is a bug in the USB audio driver; it uses packets that are too big
for the device (the code for the AUDIO_FIXED_ENDPOINT quirk doesn't look
at wMaxPacketSize).  I'll need to change the driver.


Best regards,
Clemens
