From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - Intervals v2 1/1] interval: Interpret (x
 x+1] correctly and return x+1
Date: Wed, 24 Oct 2018 12:15:29 +0200
Message-ID: <003f31d0-01a5-126d-fcda-1c8ca67ad9aa@perex.cz>
References: <1539862404-21955-1-git-send-email-twischer@de.adit-jv.com>
 <s5hbm7rv4wf.wl-tiwai@suse.de>
 <81531fd0-2173-c274-5279-a48fdfdf5121@de.adit-jv.com>
 <s5hr2gntmt0.wl-tiwai@suse.de>
 <4fb00512-47f2-4a1f-b434-ccec896355e9@de.adit-jv.com>
 <s5h36t3ti74.wl-tiwai@suse.de>
 <c376a304-a683-d0aa-30b9-df65f9884644@de.adit-jv.com>
 <s5hftx3qdzf.wl-tiwai@suse.de>
 <811d3dc0-775b-6d71-9aed-b25f53f3ab81@de.adit-jv.com>
 <s5hva5rq0wi.wl-tiwai@suse.de>
 <47609653-dbb6-b00b-e533-134f3e196d8f@de.adit-jv.com>
 <s5hk1m7pyy7.wl-tiwai@suse.de>
 <a20849a5-925b-4258-c12f-dcdc503ce2e9@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 874992675B1
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 12:15:33 +0200 (CEST)
In-Reply-To: <a20849a5-925b-4258-c12f-dcdc503ce2e9@de.adit-jv.com>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

Dne 24.10.2018 v 10:05 Timo Wischer napsal(a):
> On 10/24/18 09:48, Takashi Iwai wrote:
>> If it can be reproduced with the loopback driver, it makes easier to
>> debug.  But you modified something?  Then it has to be clarified at
>> first; i.e. let others reproduce your problem.  Otherwise we have no
>> merit to debug it in our side :)
> 
> Okay. Sorry for the inconvenience.

I am working on a regression which was caused with your
9bb985c382bab8c3bf83c0d23f50195288d3cf9f change:


http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=9bb985c382bab8c3bf83c0d23f50195288d3cf9f

Regression bug: https://bugzilla.redhat.com/show_bug.cgi?id=1640602

This change reordered/corrected intervals and I can confirm that
snd_interval_single() and snd_interval_value() functions must be updated
otherwise refining fails with some parameters.

Reproducer:

~/.asoundrc:

  pcm.aloop44100 {
    type rate
    slave.pcm hw:Loopback
    slave.rate 44100
  }

$ LD_PRELOAD=./src/.libs/libasound.so.2.0.0 aplay -Daloop44100 -c2  -r
44100 -fS16_LE --period-time=62500 --buffer-size=11025  -v -d 1 /dev/zero

This command works with 9bb985c382bab8c3bf83c0d23f50195288d3cf9f
reverted and with your new patch applied. It does not work only with
9bb985c382bab8c3bf83c0d23f50195288d3cf9f.

I applied your patch to alsa-lib repo:

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=b420056604f06117c967b65d43d01536c5ffcbc9

Thanks for your work.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
