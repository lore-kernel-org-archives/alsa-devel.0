From: "Ki'Sak" <kisak42@gmail.com>
Subject: Re: CA0110 analog mic capture flatline
Date: Wed, 10 Jul 2013 12:45:35 -0400
Message-ID: <CAL=yMgWgEeK2ktxH2PLUD4Oo40wgwTPG-584d3DcX99DS8kyWA@mail.gmail.com>
References: <CAL=yMgVtrL0ZoSAp-=7kChv9vXkKDrALv+fgHAcP655km6WX+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 19D9B2656E6
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 18:45:38 +0200 (CEST)
Received: by mail-we0-f173.google.com with SMTP id x54so6059833wes.18
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 09:45:35 -0700 (PDT)
In-Reply-To: <CAL=yMgVtrL0ZoSAp-=7kChv9vXkKDrALv+fgHAcP655km6WX+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Having received no response in 30 days and with the bug tracker down, I do
not know how to proceed with troubleshooting this issue.

I would like to send out the original email for posterity:

I have recently acquired a ca0110 card and discovered to my dismay that the
analog capture feed does not work. Upon further research, there has been a
regression somewhere between September 2009 and June 2012. The most recent
report I could find of analog capture working is at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/63352/comments/93 .

I am a Gentoo Linux user running 3.8.13 / alsa 1.0.26. The device works
fine for playback. While ugly, here is my alsa-info:
http://www.alsa-project.org/db/?f=cccb2d835cbbe90aaca143e6518c93d17109f720.
The overall layout is JACK + alsa loopback device with an independent
voice chat. The ca0110 is not touched by JACK.

This issue has been reported to the wrong people at
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1093498 and
http://forums.opensuse.org/english/get-technical-help-here/multimedia/477002-problem-microphone-opensuse-11-3-a.html,
so it is not limited to my system.


On Tue, Jun 25, 2013 at 1:11 PM, Ki'Sak <kisak42@gmail.com> wrote:

> Good day alsa-devel,
>
> I have a "Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG" which I have
> been unable to capture any content from the analog mic jack. I am a Gentoo
> Linux user with the 3.8.13 kernel / alsa 1.0.26. This issue has been filed
> with the wrong devs over at ubuntu's bugtracker and opensuse's forum. Also,
> I found a report that analog capture was working on this card as recently
> as September 2009.
>
> Thank you for your time,
> Ki'Sak
>
> Note: I have already tried to report this issue, this is a resend without
> urls due to 2 weeks without a response or it reaching the mailing list.
>
