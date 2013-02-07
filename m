From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Thu, 7 Feb 2013 21:49:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302072139480.1138@xoschi>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi> <5112B969.50905@ladisch.de>
 <5112BB1C.8090105@gmail.com>
 <CAFz=ag4aVMoEcYiZ4BKbqAoN7PuwvrhDa-162183JdsdYhDK_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 660732652FB
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 21:49:55 +0100 (CET)
Received: by mail-bk0-f42.google.com with SMTP id jk7so1365861bkc.15
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2013 12:49:55 -0800 (PST)
In-Reply-To: <CAFz=ag4aVMoEcYiZ4BKbqAoN7PuwvrhDa-162183JdsdYhDK_w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Felix,

On Thu, 7 Feb 2013, Felix Homann wrote:

> Hi Daniel, Hi Eldad.
> 
> 2013/2/6 Daniel Mack <zonque@gmail.com>
>       I'll look for the FTU and re-try this with Eldad's latest additions once
>       I find some time.
> 
> 
> I'll probably find some time later next week. I haven't followed thoroughly what Eldad did for the C400/C600 but wanted to play around with the FTU anyway (if I
> remember correctly there was a patch dropping the first n implicit feedback packets on the C400 that might possibly be of benefit for the FTUs as well).

I only added C400 - but I hope the asymmetry-related patches will save 
time with the C600.

Do you get different latency every time you start up a stream on the 
FTU? That's the reason for the skip_packet quirk for the C400.

> @Eldad Have your latest additions already made it into Takashi's tree or where can I find them?

Yes and they are all merged upstream by now. But they are mostly 
small things and specific to the C400.

Cheers,
Eldad
