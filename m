From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to keep track of the amount of queued samples?
Date: Fri, 23 Dec 2016 21:51:47 +0100
Message-ID: <5D716C69-7795-45E9-8A0B-ABF7007D10D7@ladisch.de>
References: <CAG=22kdFAAoxn3HkOwuiayT36SRv21z6Mtz0WNGK8YDKwVdmXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C995265AF3
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 21:51:50 +0100 (CET)
In-Reply-To: <CAG=22kdFAAoxn3HkOwuiayT36SRv21z6Mtz0WNGK8YDKwVdmXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Deinhard <jan.deinhard@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jan Deinhard wrote:
>I would like to understand the following quote which I copied from
>https://www.kernel.org/doc/Documentation/sound/alsa/timestamping.txt
>
>"The ALSA API provides two basic pieces of information, avail and delay,
>which combined with the trigger and current system timestamps allow for
>applications to keep track of the 'fullness' of the ring buffer and the
>amount of queued samples."

The trigger/current timestamps are not related to the buffer/queue.
They are useful only to relate the audio stream position to the
system time.

>What exactly is meant by "current system timestamp"? Is it provied by ALSA
>(htstamp?) or should I use clock_gettime(CLOCK_MONOTONIC,
>&system_time); to get that timestamp?

They are the same. ALSA returns it to prevent your process from being
interrupted between measuring the two clocks.


Regards,
Clemens
