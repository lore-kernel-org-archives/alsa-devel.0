From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Device creation order
Date: Fri, 03 Apr 2009 09:38:30 +0200
Message-ID: <49D5BCF6.1020407@ladisch.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6B7EE10380A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 09:38:26 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Unfortunately, driver may use more complex scenarios like:
> 
> - some hardware requires additional firmware - in this case devices
>    might be created, but they are not useable until firmware is loaded

This is only true for drivers that load firmware with a hwdep device
instead of using request_firmware().  Is there any driver that has not
yet been converted?  *grep*  ... except usx2y?

> - dynamic device creation at runtime - for example we have an
>    experimental HDA driver configuration code which might change
>    the arrangement of PCM devices on request from the user space
> 
> I would suggest to wait awhile with some small timeout (0.5 sec?) for all 
> devices to get the usual static arrangement working and handle extra
> dynamic cases, too.

The current implementation of the ALSA framework guarantees that the
control device file is that latest one to be created for all the devices
created at initialization.  Any devices created later depend on some
userspace action, so a small timeout won't help in this case.

In other words:
1) When the control device file has been created, all other devices
   (that are created during sound card initialization) are available.
2) When some device file for a specific sound card is created after the
   card's control device, the sound card configuration has changed.


Best regards,
Clemens
