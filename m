From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsaloop problems; ALSA streaming tutorial (resend)
Date: Wed, 24 Oct 2018 16:06:45 +0200
Message-ID: <57796bd0-5212-81bf-5053-e3585a484f46@perex.cz>
References: <20181024080118.hwlaato642zpagfc@ofb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id B444D2675BB
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 16:06:50 +0200 (CEST)
In-Reply-To: <20181024080118.hwlaato642zpagfc@ofb.net>
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
To: frederik@ofb.net, mark@xwax.org
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 24.10.2018 v 10:01 frederik@ofb.net napsal(a):
> Dear Mark (cc'ing ALSA-user, ALSA-devel)
> 
> Thank you for your tutorial
> 
> http://www.pogo.org.uk/~mark/trx/streaming-desktop-audio.html
> 
> I found it helpful and clearly-written (although missing a "}" brace
> and I think it should be "-P" instead of "-p"...).
> 
> I got as far as trying the 'alsaloop' example. It seems very finicky,
> sometimes I am able to play a test.wav cleanly through the loopback
> device, and sometimes there are a lot of crackles and I get errors
> like
> 
>     playback hw:0: change avail_min=2968
>     playback hw:0: change avail_min=2972
>     playback hw:0: change avail_min=2976
>     underrun for playback hw:0
>       last write before 9.8370ms, queued 10.0000ms/0.0000ms -> missing -0.1630ms
>       expected 10.0000ms, processing 0.1910ms, max missing 0.0443ms
>       last wake 0.0350ms, last check 0.0350ms, avail_min 32.0000ms
>       max buf 40.0000ms, pfilled 0.0000ms, cfilled 10.0000ms
>       job started before 0.0110ms

Could you retest with the latest? I tried to fix the avail_min issue here:

http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=8bc1bc53d0a8b3797337bddd30cd345ba1049817

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
