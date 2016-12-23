From: Jan Deinhard <jan.deinhard@gmail.com>
Subject: How to keep track of the amount of queued samples?
Date: Fri, 23 Dec 2016 15:16:04 +0100
Message-ID: <CAG=22kdFAAoxn3HkOwuiayT36SRv21z6Mtz0WNGK8YDKwVdmXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E4BD266998
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 15:16:06 +0100 (CET)
Received: by mail-qk0-f171.google.com with SMTP id u25so133945771qki.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 06:16:06 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to understand the following quote which I copied from
https://www.kernel.org/doc/Documentation/sound/alsa/timestamping.txt

"The ALSA API provides two basic pieces of information, avail and delay,
which combined with the trigger and current system timestamps allow for
applications to keep track of the 'fullness' of the ring buffer and the
amount of queued samples."

Querying avail and delay is straight forward. But I have no idea how to use
these values in combination with trigger_htstamp and the current system
timestamp to calculate the fullness of the ring buffer.

Can someone provide some insight?

What exactly is meant by "current system timestamp"? Is it provied by ALSA
(htstamp?) or should I use clock_gettime(CLOCK_MONOTONIC, &system_time); to
get that timestamp?

Thanks,
Jan
