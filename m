From: Jordi Torres <clubmajo@yahoo.es>
Subject: Re: [FFADO-devel] Clicking issues with the output of
	an Onyx Blackbird
Date: Thu, 13 Oct 2016 10:44:36 +0200
Message-ID: <CACF1cz+wRmDQVN6aDsFpPndSyAygwgHaQHyjxu0hcjh3vx+Txw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 178EC265654
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 10:44:57 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id x79so11518121lff.2
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 01:44:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> (CCed to alsa-devel)
I sent this issue to alsa mailist 6 days ago but I supouse that hit
the spam filter. Even I published an alsa-info
http://www.alsa-project.org/db/?f=cb6745b6d0acdb5d9375096ec8dc008f6ff49cd7

When I read the wiki about reporting bugs, I understood that kernel
related bugs goes to bugzilla.kernel.org and user-land bugs goes to
the devel mail-list. So I supouse that I should sent this issue to the
bugzilla as it's considered a kernel bug

> Well, could I request you to gather information of packet sequence?

Here is the trace of packets:
https://drive.google.com/file/d/0Bz44Dr5G2FeJSXBHMzc5WTFmOWs/view?usp=sharing

The trace includes the opening of alsa device and playing a sine wave
for 30 seconds

My linux box has two firewire ports I don't know the details about the
host controller but could be feasible sniff the connection between the
other computer with official drivers and the DAW? Could that be
useful?

PD: Resent due to using the wrong sender address
