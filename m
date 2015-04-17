From: Heikki Lindholm <holin@iki.fi>
Subject: Re: RME MADIFX mainline inclusion
Date: Fri, 17 Apr 2015 23:56:00 +0300
Message-ID: <55317360.2020003@iki.fi>
References: <5522B34B.3090404@drcomp.erfurt.thur.de>
 <s5hd23g9rx4.wl-tiwai@suse.de> <5523BA14.3050904@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vs17.mail.saunalahti.fi (vs17.mail.saunalahti.fi
 [62.142.117.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D4A27260673
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 22:56:13 +0200 (CEST)
In-Reply-To: <5523BA14.3050904@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: alsa-devel@alsa-project.org, nonus@gmx.net, Takashi Iwai <tiwai@suse.de>, marcinp@uw.edu, Michael.Hentschel@eei.uni-erlangen.de, holeungsing@gmail.com, Moritz.Fiser@joanneum.at, mtzuking@netvigator.com, zmoelnig@umlaeute.mur.at
List-Id: alsa-devel@alsa-project.org

7.4.2015 14.05, Adrian Knoth kirjoitti:
> On 04/07/15 12:03, Takashi Iwai wrote:
>
>>> Code is here:
>>>
>>> https://github.com/adiknoth/madifx/commits/tokernel
>>>
> [..]
>>> In its current state, can I send you three patches (Kconfig, madifx.h,
>>> madifx.c) that add said driver to sound/pci/rme9652?
>> Well, I really want some testers whether the merged code actually
>> works.
>
> The standalone code (above driver) works, I know a couple of people
> using it.
>
> Let me CC a few I've found - maybe they can test a merged version or at
> least testify that what they're using atm actually works.

We have been using the madifx driver since mid-2013 in production 
environment and it has served well. Up to now our system has been 
running with a driver snapshot from July 2013 on ubuntustudio 13.04 
(kernel 3.8 iirc). We just upgraded to ubuntustudio 14.04 and madifx 
driver from Adrian's tokernel branch (ubuntu vidid kernel 3.19.0). So 
far, it appears to work just as well.

So, +1 for mainlining the driver. We can also test the actual patchset, 
when submitted.

Regards,
Heikki Lindholm
