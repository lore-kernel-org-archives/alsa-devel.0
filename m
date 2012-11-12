From: Rob Krakora <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Mon, 12 Nov 2012 19:40:42 +0000 (UTC)
Message-ID: <loom.20121112T203721-204@post.gmane.org>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de> <509FD3BE.7090504@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C07C265065
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 20:44:56 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TXzwO-0004OG-EP
 for alsa-devel@alsa-project.org; Mon, 12 Nov 2012 20:45:04 +0100
Received: from messagenetcommunicationsystems.com
 ([messagenetcommunicationsystems.com])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 20:45:04 +0100
Received: from B42341 by messagenetcommunicationsystems.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 20:45:04 +0100
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

Jaroslav Kysela <perex <at> perex.cz> writes:

> 
> Date 10.11.2012 14:53, Takashi Iwai wrote:
> > At Fri, 9 Nov 2012 18:03:25 -0800,
> > Trent Piepho wrote:
> >>
> >> We've found a race with alsa-lib functions are called from multiple
> >> threads.  I was under the impression that alsa-lib was supposed to be
> >> thread safe.  Is this not the case and all alsa calls should be done
> >> one from thread or protected by a mutex?
> > 
> > Yes.  alsa-lib isn't thread-safe.
> 
> The alsa-lib is designed to be thread safe but the calls for one handle
> (PCM, control, rawmidi etc.) should be serialized using mutexes in apps.
> Or basically, it's assumed that one thread will maintain one handle.
> 
> This should be documented somewhere.
> 
> 					Jaroslav
> 

Hi Jaroslav,

Would you be able to point me the the ALSA documentation that indicates the
stipulations on handle usage using multiple threads?  I cannot find it.

Best Regards,

Rob Krakora
