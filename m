From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Thu, 7 Apr 2016 22:10:41 +0200
Message-ID: <20160407201041.GB26683@mail.zuhause>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause>
 <s5hpou5a0g0.wl-tiwai@suse.de>
 <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-1.mx.upcmail.net
 (vie01a-dmta-pe02-1.mx.upcmail.net [62.179.121.157])
 by alsa0.perex.cz (Postfix) with ESMTP id CD8A12619D0
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 22:10:43 +0200 (CEST)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aoGGJ-0005ZY-Ik
 for alsa-devel@alsa-project.org; Thu, 07 Apr 2016 22:10:43 +0200
Content-Disposition: inline
In-Reply-To: <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2016 at 03:23:01PM -0400, Adam Goode wrote:
> Have you heard any objections?
> 
> Also, would you plan to do a 1.1.2 release soon after accepting this, to
> get this functionality out quickly?

Distributions already start to pick 1.1.1 up:
https://build.opensuse.org/request/show/382608
https://build.opensuse.org/request/show/382611

I would object merging that patch, if there is no immediate patched 1.1.2 release available, 
as otherwise 1.1.1 with a different API will get used by the mass. 

Regards,
Martin
