From: Leonardo Gabrielli <l.gabrielli@univpm.it>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 16:40:52 +0100
Message-ID: <5332F504.3020307@univpm.it>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it> <53328F4C.8030205@ti.com>
 <5332A1C9.3070802@univpm.it> <5332CD38.3070700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 08EBD265013
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 16:40:59 +0100 (CET)
Received: by mail-ee0-f47.google.com with SMTP id b15so1793289eek.6
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 08:40:58 -0700 (PDT)
In-Reply-To: <5332CD38.3070700@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Peter,
thank you for your suggestions.
For the moment I will keep with the following settings, which provide 
satisfying latency and CPU usage:

-r 44100, -p64, with sDMA threshold=320 as per your suggestions, and CPU 
governor set to performance (1GHz).
This way I can have 16ms in-out latency, with 15% CPU, no glitches and 
XRUNs (9% in jack, and 6% is the connection of system:{capture|playback} 
ports.

uname -a
Linux debian-BB3 3.13.3-armv7-x10 #1 SMP Sat Feb 15 01:03:40 UTC 2014 
armv7l GNU/Linux

In case I will need a lower latency I will try the USB soundcard 
suggested by Edgar.

Leonardo

On 26/03/2014 13:51, Peter Ujfalusi wrote:
> I know this is working in realtime systems like in DSPs and non linux systems...
