From: Martin Pietryka <martin.pietryka@streamunlimited.com>
Subject: Hot to properly output DSD silence pattern
	before/after playback?
Date: Wed, 21 Oct 2015 15:46:33 +0200
Message-ID: <56279739.6050409@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp4.bon.at (bsmtp4.bon.at [195.3.86.186])
 by alsa0.perex.cz (Postfix) with ESMTP id BF27B260692
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 15:46:33 +0200 (CEST)
Received: from [10.1.14.177] (vpn.streamunlimited.com [91.114.0.140])
 by bsmtp4.bon.at (Postfix) with ESMTPSA id 3ngtQd4L8rz5tlT
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 15:46:33 +0200 (CEST)
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

Hello Guys,

I have already asked the question last week, but the thing got a bit 
more complicated.

So we need to achieve the following when playing back DSD audio:

1.) Start outputting the DSD silence pattern (0x69) for ~40ms
2.) After ~10ms unset a mute GPIO
3.) Start outputting DSD data after silence is over

and after DSD playback is finished a similar procedure:

1.) Start outputting the DSD silence pattern (0x69) for ~40ms
2.) After ~10ms set a mute GPIO
3.) (let silence run out)

In addition to that, we also have the need to toggle the mute GPIO from 
an appropriate place at an appropriate time, the timing does not have to 
be exact but we need to be sure that the actual hardware already started 
outputting the silence samples.

We have figured out three possibilities where to add the silence:
1.) Inside our application:
     We are using GStreamer and for various reasons we currently can't 
do it here without a significant effort.

2.) Inside alsa-lib:
     The idea here is to inject a snd_pcm_writei() call on the first 
call of snd_pcm_writei() and inside snd_pcm_drain(). This is really 
ugly, but doable, I already have a simple proof of concept working. But 
here I think the GPIO stuff will get really complicated.

3.) Inside the kernel:
     Modify the soc driver to output the silence pattern before and 
after playback.

So what do you guys think would be the best approach to this problem, 
are there any other possibilities?

I would imagine someone has had to do something similar before, but I 
couldn't find anything with Google, so if you know something regarding 
this, please let me know.

Thanks,

Martin
