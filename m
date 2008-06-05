From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH - ASIHPI 1/8] Common init files for HPI
Date: Thu, 05 Jun 2008 16:34:25 +1200
Message-ID: <200806051634.25259.linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id F39032459E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:34:19 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z00M563D3IK20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:34:17 +1200 (NZST)
In-reply-to: <1212638821-2779-1-git-send-email-linux@audioscience.com>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

this patchset updates ALSA to our current 3.10.00 release.
Matching firmware is here, please use it to update alsa-firmware
http://audioscience.com/internet/download/firmware/dspbins31000.zip

One thing I haven't figured out how to get git to include a patch for deletion 
of a file? Anyway, current repo hpimod.c is replaced with hpioctl.c (you 
could consider this a rename then update)

I have restructured code a bit so that asihpi.c is the "master" module file, 
that calls utility functions in hpioctl.c for setting up HPI, and handling 
hpi ioctl via hwdep.


regards

Eliot
