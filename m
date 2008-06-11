From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH - ASIHPI 1/8] Common init files for HPI
Date: Thu, 12 Jun 2008 11:22:31 +1200
Message-ID: <48505E37.1050704@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<200806051634.25259.linux@audioscience.com>
	<s5hprqu6edw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B8CD24350
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 01:23:28 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K2B008N1NLMQL50@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 12 Jun 2008 11:22:40 +1200 (NZST)
In-reply-to: <s5hprqu6edw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 05 Jun 2008 16:34:25 +1200,
> Eliot Blennerhassett wrote:
>> I have restructured code a bit so that asihpi.c is the "master" module file, 
>> that calls utility functions in hpioctl.c for setting up HPI, and handling 
>> hpi ioctl via hwdep.
> 
> This looks good!  Let's continue to reshape a bit for merging to the
> upstream.

Thanks Takashi.

What sort of reshape do you have in mind?  *me* Holds breath...
