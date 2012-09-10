From: Timur Tabi <timur@freescale.com>
Subject: Re: Need help with failed driver initialization
Date: Mon, 10 Sep 2012 15:47:54 -0500
Message-ID: <504E51FA.5020504@freescale.com>
References: <504E0F91.4040907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BAFE26036C
 for <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 22:48:10 +0200 (CEST)
Received: from mail201-co1 (localhost [127.0.0.1])	by
 mail201-co1-R.bigfish.com (Postfix) with ESMTP id D04D8A80185	for
 <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 20:48:08 +0000 (UTC)
Received: from CO1EHSMHS001.bigfish.com (unknown [10.243.78.228])	by
 mail201-co1.bigfish.com (Postfix) with ESMTP id 458B9440045	for
 <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 20:48:06 +0000 (UTC)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q8AKlsQk031644	for
 <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 13:47:57 -0700
In-Reply-To: <504E0F91.4040907@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> It appears that support for deferred probing isn't working for me.  I
> turned on debug printks (and added a few of my own to my drivers), and
> here's the log:

So it appears that platform_device_alloc("soc-audio", -1) no longer works
for me.  When I replace that code with a call to snd_soc_register_card(),
my driver works again.

I noticed that a lot of drivers still use platform_device_alloc(), so I
don't know if this problem specific to my drivers, or everyone else is
broken but they don't know it yet.  Either way, I'll post a patch soon.

-- 
Timur Tabi
Linux kernel developer at Freescale
