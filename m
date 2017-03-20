From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: dmix, snd_pcm_drain(), SND_PCM_NONBLOCK - bug?
Date: Mon, 20 Mar 2017 08:44:00 +0100
Message-ID: <4b0c4e94-d3be-9645-e559-d236b8d57bc4@perex.cz>
References: <20170316122336.GA7038@swift.blarg.de>
 <1558c56b-cf47-38cb-2c69-241113074672@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6F3266CC6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 08:44:02 +0100 (CET)
In-Reply-To: <1558c56b-cf47-38cb-2c69-241113074672@perex.cz>
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
Cc: Max Kellermann <max@duempel.org>
List-Id: alsa-devel@alsa-project.org

Dne 20.3.2017 v 08:39 Jaroslav Kysela napsal(a):
> Dne 16.3.2017 v 13:23 Max Kellermann napsal(a):
>> Hi,
>>
>> I have received a bug report for the Music Player Daemon which
>> complains about a freezing MPD process, after I switched MPD's ALSA
>> output to non-blocking mode:
>>
>>  https://bugs.musicpd.org/view.php?id=4662
>>
>> This happens when snd_pcm_drain() is used on a dmix PCM which is in
>> SND_PCM_NONBLOCK mode.  snd_pcm_drain() will be called repeatedly,
>> because ALSA's file descriptor is always ready.
>>
>> According to my research, the bug is in __snd_pcm_dmix_drain().  This
>> function always returns -EAGAIN when SND_PCM_NONBLOCK is set:
>>
>>   if (pcm->mode & SND_PCM_NONBLOCK)
>>         return -EAGAIN;
>>
>> This comes very early in the function, before any other relevant
>> checks.  It can never finish that way, and calling it again at any
>> time will never do anything.  Thus, snd_pcm_drain() appears to be
>> broken in non-blocking mode.
> 
> Could you test
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=fdc898d41135b26772d0fffe07e9eb0de6597125
> ? There should be a loop with -EAGAIN, but this loop should end when
> then samples and drained.

Oops. I used wrong handle to check the state. Use commit
http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=e4377b16454f3b7b222613a571bf4244ebd28e56
, too.

http://git.alsa-project.org/?p=alsa-lib.git;a=summary

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
