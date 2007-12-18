From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi driver -> kernel
Date: Wed, 19 Dec 2007 11:13:25 +1300
Message-ID: <47684605.9050705@audioscience.com>
References: <200709051300.35503.linux@audioscience.com>
	<s5hzm01tn8w.wl%tiwai@suse.de> <47141823.4000307@audioscience.com>
	<s5hbqaqrppa.wl%tiwai@suse.de> <47397615.4000201@audioscience.com>
	<475886C3.9070301@audioscience.com> <s5hve71dzqx.wl%tiwai@suse.de>
	<47671166.2050405@audioscience.com> <s5hlk7sxisi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id CE96224557
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 23:13:30 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JT900AJRN2FL200@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 19 Dec 2007 11:13:29 +1300 (NZDT)
In-reply-to: <s5hlk7sxisi.wl%tiwai@suse.de>
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
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>> - Global variables should have some unique prefix.  The kernel code is
>>>   monolithc C, so they are really global and has no name space.
>> Did you have a list?
>> There are a few function names that don't start with HPI.
> 
> Err, sorry, I meant global variables *and functions*.

BTW is there any way to not export functions/variables that are used
only inside the kernel module? (but used between object files that make
up the module so cannot be made static)

I.e. if the module was compiled as one huge sourcefile, almost
everything could be static.

regards

Eliot
