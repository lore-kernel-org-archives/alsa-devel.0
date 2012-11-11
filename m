From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Races in alsa-lib with threads
Date: Sun, 11 Nov 2012 17:35:10 +0100
Message-ID: <509FD3BE.7090504@perex.cz>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EDFD4261719
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 17:35:11 +0100 (CET)
In-Reply-To: <s5hbof5ef7s.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, tpiepho@gmail.com
List-Id: alsa-devel@alsa-project.org

Date 10.11.2012 14:53, Takashi Iwai wrote:
> At Fri, 9 Nov 2012 18:03:25 -0800,
> Trent Piepho wrote:
>>
>> We've found a race with alsa-lib functions are called from multiple
>> threads.  I was under the impression that alsa-lib was supposed to be
>> thread safe.  Is this not the case and all alsa calls should be done
>> one from thread or protected by a mutex?
> 
> Yes.  alsa-lib isn't thread-safe.

The alsa-lib is designed to be thread safe but the calls for one handle
(PCM, control, rawmidi etc.) should be serialized using mutexes in apps.
Or basically, it's assumed that one thread will maintain one handle.

This should be documented somewhere.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
