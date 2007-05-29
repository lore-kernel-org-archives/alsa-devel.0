From: Rossco <r.maclachlan@strath.ac.uk>
Subject: Re: ICE1724 alsa driver
Date: Tue, 29 May 2007 10:37:41 +0000 (UTC)
Message-ID: <loom.20070529T122337-464@post.gmane.org>
References: <loom.20070523T194915-68@post.gmane.org>
	<10237.25773-11092-1347170241-1180342098@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A31842432E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 12:37:54 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hsz5K-0001ti-Ho
	for alsa-devel@alsa-project.org; Tue, 29 May 2007 12:37:50 +0200
Received: from notrouble.cc.strath.ac.uk ([130.159.248.222])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 12:37:50 +0200
Received: from r.maclachlan by notrouble.cc.strath.ac.uk with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 12:37:50 +0200
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
List-Id: alsa-devel@alsa-project.org



<dustin <at> seznam.cz> writes:

> 
> Hi Ross,
> 
> I apologize for a delayed  reply. Joint work on adding support to your card
sounds certainly interesting to
> me, it's just the current time pressure and a work on another card I would
like to finish first. One or two
> weeks I hope.
> 
> Regards,
> 
> Pavel.

Hi Pavel,

No worries on the delayed response, just glad to hear that support can be added.
I will continue to read through alsa documentation and try to get as far as I
can on my own over the next few weeks and then will give you an update on my
progress at this stage.

I suspect it will not be possible to use the complete aureon driver. The
hitpoint (and av710) uses a combination of the 6 channel vt1616 codec (ac-link)
and the 2 channel wolfson WM8728 (I2S) to achieve the 8 channels. The aureon
uses the 8 channel wm8770 which is all I2s. You may be able to advise that
despite the differences in chip the control of the envy24ht-s remains the same?
But as far as I can see the envy chip has different modes to make use of
ac-link, i2s or a mix of both.

Hopefully the cs8415 is hooked up in exactly the same way on both cards and
therefore this code will be reuseable. 

Of course I would be glad to hear from anyone who has experience in adapting
ALSA drivers in the way that is required here. The resultant driver will most
likely add spdif input functionality to the more readily available maddog
entertainer 7.1 under linux (unless someone can confirm that this is already
working).

Cheers,

Ross
