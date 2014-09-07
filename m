From: "Pierre C" <lists@peufeu.com>
Subject: Re: USB Implicit Feedback
Date: Sun, 07 Sep 2014 15:30:40 +0200
Message-ID: <op.xltjteeleorkce@apollo13>
References: <op.xlq6q9vfeorkce@apollo13> <540AF652.8080501@zonque.org>
 <op.xls10oxteorkce@apollo13> <540C420D.6000202@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo68.mail-out.ovh.net (6.mo68.mail-out.ovh.net [46.105.63.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 93F5F264F53
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 15:30:42 +0200 (CEST)
Received: from mail138.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo68.mail-out.ovh.net (Postfix) with SMTP id 2B9F6FF9FE3
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 15:30:42 +0200 (CEST)
In-Reply-To: <540C420D.6000202@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


> Explicit feedback is much more common than anything else, and I haven't
> yet seen a standard compliant device with implicit feedback in the wild.
> And more common means more test coverage :)

OK. This whole implicit feedback thing seems like a good idea but it  
smells bad.

> It's been a while since I looked into this, but when I implemented the
> code in the first place, I had no standard compliant device to test
> with, so I had to force the driver into implicit mode with a quirk.

Somehow I don't feel like debugging my USB code and ALSA at the same time,  
while checking both sides against a standard that doesn't exist. Given the  
complete absence of clear explanation of how it should work in the USB  
specs, even if the thing ends up working, there will be no guarantee it  
would be "compliant" to anything...

> But as I said - if explicit feedback mode already works for you, I'd
> stick with it.

I'm going to stick to this advice !... Thanks.
