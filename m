From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Gitcompile for Kernel 3.2?
Date: Mon, 6 Aug 2012 14:43:35 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F345181D0540@CRETE.nmmu.ac.za>
References: <35FE09CFAB387A4BA7ACDDED49F345181D00D8@CRETE.nmmu.ac.za>
 <s5h3940mpcd.wl%tiwai@suse.de>
 <35FE09CFAB387A4BA7ACDDED49F345181D0496@CRETE.nmmu.ac.za>,
 <s5hpq74jij3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CB8D265D87
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 16:14:12 +0200 (CEST)
In-Reply-To: <s5hpq74jij3.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Well, it depends on the error you got...

Yes of course, sorry.  When I:

mark@ubuntustudio:~/workspace/alsa-driver-build$ ALSAKERNELDIR=/usr/src/linux-lowlatency-3.2.0 ./gitcompile --with-moddir=updates

I get:

cp ../../alsa-kernel/include/core.h .
patch -p0 -i core.patch core.h
patching file core.h
Hunk #1 succeeded at 104 (offset -1 lines).
[snip]
Hunk #7 FAILED at 449.
1 out of 7 hunks FAILED -- saving rejects to file core.h.rej
make[3]: *** [core.h] Error 1
make[3]: Leaving directory `/home/mark/workspace/alsa-driver-build/include/sound'
make[2]: *** [prepare] Error 2
make[2]: Leaving directory `/home/mark/workspace/alsa-driver-build/include/sound'
make[1]: *** [prepare] Error 2
make[1]: Leaving directory `/home/mark/workspace/alsa-driver-build/include'
make: *** [dep] Error 1

So this is my attempt to build against the 3.2.0-lowlatency kernel.  I'll try tonight (at home) against the vanilla 3.2 kernel.

________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
