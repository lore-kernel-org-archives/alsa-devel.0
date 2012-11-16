From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: snd_pcm_wait function (really snd_pcm_draiin)
Date: Fri, 16 Nov 2012 20:10:38 +0100
Message-ID: <50A68FAE.9010505@canonical.com>
References: <50A0A3FE.4090901@tele2.nl>	<50A0A709.1050307@ladisch.de>	<CA+7tXihDCpmvVpPCErz5WrZ8BtZTB+orp=W77dgXwwFsaX9eeQ@mail.gmail.com>	<CAHU0+dQvuNAY8U735GY2n_kA2F3+1ooobKRrtOt2KTwSBF12dg@mail.gmail.com>	<CA+7tXihLxEsMFBhx5gnXUMbCyTD+tfAWQGYLxavC3YUNMb0JfQ@mail.gmail.com>
 <CAHU0+dTL=rc6gMc49cWiUL3rL2_92myqYrReCUbK3hVy4BB=DA@mail.gmail.com>
 <50A6695B.6080202@tele2.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 43D4126171E
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 20:10:41 +0100 (CET)
In-Reply-To: <50A6695B.6080202@tele2.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Enno Fennema <ennofennema@tele2.nl>
Cc: Daniel Sanz <daniellsanz2@gmail.com>, Trent Piepho <tpiepho@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/16/2012 05:27 PM, Enno Fennema wrote:
> On 11/16/12 11:41, Daniel Sanz wrote:
>> Thanks, Trent, I've been playing a bit with snd_pcm_drain,
>> snd_pcm_writei, blocking mode, non-blocking mode, etc. but even if I
>> ...
>
> I wanted to play a short sound and release the pcm. It works with a
> non-block drain as Clemens suggested.
>
> I noticed using gettimeofday() around drain() that it takes a bit over 2
> seconds. Rather long for a sound that only takes 0.1 sec.

That is a known pulseaudio problem; which we also noted on PulseConf a 
few weeks ago. I want to do something about it but it is not on the top 
of my priority list right now.

Are the rest of you trying with PulseAudio as well? Maybe it could be 
worth also trying the direct plughw path do see if the behaviour is 
different.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
