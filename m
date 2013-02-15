From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: emi62 (may be slightly off-topic)
Date: Fri, 15 Feb 2013 11:14:46 -0500
Message-ID: <CACrD=+-aXYKoLdrMw+xOzqhyY9mdpDzLfMTB-06CHYiBqEQOxw@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
 <4D821A18.30407@ladisch.de>
 <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
 <4D894196.4040002@gmail.com>
 <1360657074.2790.71.camel@chello084112006029.chello.at>
 <s5hboblr611.wl%tiwai@suse.de>
 <CACrD=+8-kHTX0AVW5KLHG73mDp4+eccz4LqanpOzNGeCRZ+hRA@mail.gmail.com>
 <CACrD=+9P6Gj51HMRb-rdZeoQ7yjzpu2J=pkq9eNj-ZH8HGAe+A@mail.gmail.com>
 <s5hmwv5imqy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 044B22616B9
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 17:14:46 +0100 (CET)
Received: by mail-lb0-f173.google.com with SMTP id gf7so2718058lbb.4
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 08:14:46 -0800 (PST)
In-Reply-To: <s5hmwv5imqy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Karl Grill <kgrill@chello.at>
List-Id: alsa-devel@alsa-project.org

> Do you still have the patch for async load?

Oh yes.  I should check it against 3.7

And for the record, it's a complete new loader, one module for both
eMagic boxes,  so the patch consists of removing several files and
adding new ones.

> The fix patch on the blog
> entry isn't that.

Correct. There were other [minor] problems in the old loader, but
without fixing the deadlock, it's all sort of moot.  Also, the 6|2
loader is currently trying to use firmware for some other device--
it's not 6|2 firmware.  if you do succeed in loading what's currently
shipping, the device simply crashes.

So, I came to the conclusion a few years ago i was the last person
using eMagic boxes (though people since then have sent me mail for the
driver, so I know that's not quite true).

Monty
