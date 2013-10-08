From: Bruce <abruceperson@gmail.com>
Subject: Re: Can't get capturing from RME Hammerfall MADI card
 to work: sound loops & silcence
Date: Tue, 08 Oct 2013 14:59:46 +1100
Message-ID: <52538332.3070501@gmail.com>
References: <CANYi0v7OD_AFC9-jFeH4MGLZQGsPX91S5NdjqDsmZ_9pOR0hPg@mail.gmail.com>
 <CAGqxWvJQPFd_v_iN0eyVG1qCCUxeYpcOP0YU961Gn2JGdN3RgA@mail.gmail.com>
 <5245370C.5060408@ladisch.de> <52453824.9070308@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AAAA2652BD
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 05:59:59 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id y10so8048021pdj.39
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2013 20:59:58 -0700 (PDT)
In-Reply-To: <52453824.9070308@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/09/2013 5:47 PM, Florian Faber wrote:
> Clemens,
>
>>> Similar issues here, but can add it all seems to work absolutely fine with
>>> alsa 1.0.15, but fails with 1.0.18+.
>> This sound like some change in the driver introduced a bug.
> the driver works fine with versions up to 1.0.27. I have the card
> running on a daily base with current kernel versions.

Hi Flo (or driver developers),

I cannot get our card to work with alsa 1.0.27 (or 1.0.18), but it does 
work fine with 1.0.15. I'm trying to work out what could be different 
from my setup to yours. I have tried different PCs, different Linux 
distributions and two different HDSP cards.
I'm using a HDSPe MADI Rev1.1 loaded with the latest firmware. Is yours 
the same ?

May I send you a particular application to attempt running on your 
system with 1.0.27 and see if it works ?

*Note* I can use all parts of 1.0.27 (eg, lib, alsamixer, aplay) 
/except/ for the Hammerfall driver (remains at 1.0.15) and it still 
works for me. I cannot install the new driver under an older kernel due 
to incompatibilities, but trying 1.0.18 or 1.0.27 (including later 
driver) with a newer kernel fails.

I thought if I could somehow get the 1.0.15 hammerfall driver working 
with a new kernel (help ??) I could then somehow step through the 
subsequent changes made to the driver one by one till it breaks. This 
approach could take some considerable time, so any pointers as to how to 
do this would be much appreciated !  I do not profess to know much about 
alsa driver development, or how to even access the (svn ?) revision 
steps, but this might be the only way to work out what is happening here.

Cheers,
Bruce

PS: I will also ask the Hammerfall Linux forum, but that seems a bit 
inactive now.


>
>
> Flo


-- 
Cheers,
Bruce
