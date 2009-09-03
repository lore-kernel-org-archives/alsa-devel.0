From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 19:06:57 +0200
Message-ID: <7c5010d60909031006r21fb8a0bw70ffa42dce1f7667@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5hbplsqeye.wl%tiwai@suse.de>
	<7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
	<7c5010d60909030803h1c354c79ob774683d764ea062@mail.gmail.com>
	<s5h4orkqd22.wl%tiwai@suse.de>
	<7c5010d60909030812k5f865622i5cddcd978788c338@mail.gmail.com>
	<7c5010d60909030826k122fa855t153458431cd18909@mail.gmail.com>
	<s5h1vmoqc71.wl%tiwai@suse.de>
	<7c5010d60909030835n2d62756cr1e29de479b7a9d97@mail.gmail.com>
	<s5hws4gox1l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id D46EC24386
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 19:06:58 +0200 (CEST)
Received: by fxm3 with SMTP id 3so96119fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 10:06:57 -0700 (PDT)
In-Reply-To: <s5hws4gox1l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 5:41 PM, Takashi Iwai<tiwai@suse.de> wrote:
> Try the patch below.  It just converts the calculation base to msec
> instead of HZ.
>
> The enhancement to max 128 subdevices should be easy.  Isn't it suffice
> to define MAX_PCM_SUBSTREAMS to 128?

yes, definetly. I made other "enhancements" to let it works without
too much load

I tested the patch, with no joy...

This is the result of the printk, updated to reflect the new function
results (eg: is not /HZ but /1000, only the text is old (btw, in this
case HZ would be 1000)):

Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97652536
Sep  3 18:57:15 localhost kernel: klogd 1.4.1, ---------- state change
----------
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97652537
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97652537
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97652539
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97652539
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97652588
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97652664
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97652716
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97652717
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97652723
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97652723
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97652792
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97652793
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97652795
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97652795
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97652797
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97652797
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97652844
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97652920
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97652972
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97652973
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97652979
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97652979
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97652986
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97652986
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653048
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97653049
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653052
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653052
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97653056
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97653056
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653100
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653176
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653228
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97653229
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97653235
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97653235
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97653242
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97653242
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653304
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97653305
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653308
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653308
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97653312
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97653312
Sep  3 18:57:15 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653356
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653432
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653484
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97653485
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97653491
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97653491
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2256, jiffies=97653497
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2256, jiffies=97653497

Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653560
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97653561
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653564
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653564
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97653567
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97653567
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653612
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653688
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653740
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97653741
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97653748
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97653748
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97653754
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97653754
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653816
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97653817
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653820
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97653820
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97653824
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97653824
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97653868
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653944
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97653996
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97653997
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97654004
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97654004
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97654010
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97654010
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654072
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97654073
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654076
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654076
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654080
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654080
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654124
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654200
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654252
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97654253
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97654259
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97654259
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97654266
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97654266
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654328
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97654329
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654332
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654332
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654336
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654336
Sep  3 18:57:16 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654380
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654456
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654508
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97654509
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97654515
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97654515

Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97654522
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2272, jiffies=97654522
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654584
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97654585
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654588
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654588
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654592
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654592
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654636
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654712
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654764
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97654765
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97654771
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2160, jiffies=97654771
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2256, jiffies=97654777
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2256, jiffies=97654777
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654840
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97654841
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654844
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97654844
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654848
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97654848
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97654892
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97654968
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655020
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97655021
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655028
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655028
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655036
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655036
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655096
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97655097
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655100
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655100
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97655104
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97655104
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655148
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655224
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655276
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97655277
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655284
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655284
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655292
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655292
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655352
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97655353
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655356
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655356
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97655359
Sep  3 18:57:17 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97655359
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655404
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655480
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655532

Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97655533
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655540
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655540
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655548
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655548
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655608
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97655609
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655612
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655612
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97655616
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97655616
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655660
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655736
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655788
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97655789
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655796
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97655796
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655804
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97655804
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655864
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97655865
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655868
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97655868
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97655872
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97655872
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97655916
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97655992
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656044
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97656045
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656052
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656052
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97656059
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97656059
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656120
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97656121
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656124
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656124
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97656127
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97656127
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656172
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656248
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656300
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97656301
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656308
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656308
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97656315
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97656315
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656376
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97656377
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656380
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656380
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97656384
Sep  3 18:57:18 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97656384
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656428

Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656504
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656556
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97656557
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656564
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656564
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97656571
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97656571
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656632
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97656633
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656636
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656636
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97656639
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97656640
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97656640
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656684
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656760
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97656812
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97656813
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656820
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97656820
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97656828
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97656828
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656888
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97656889
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656892
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97656892
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97656896
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97656896
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97656940
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657016
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657068
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97657069
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657076
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657076
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97657084
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97657084
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657144
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97657145
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657148
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657148
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97657152
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97657152
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657196
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657272
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657324
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97657325
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657332
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657332
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97657339
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97657339
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657400
Sep  3 18:57:19 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97657401
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657404
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657404

Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97657407
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97657407
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657452
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657528
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657580
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97657581
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657588
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657588
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97657596
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97657596
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657656
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97657657
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657660
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657660
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97657664
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97657664
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657708
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657784
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97657836
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97657837
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657844
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97657844
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97657851
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97657851
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657912
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97657913
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657916
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97657916
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97657920
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97657920
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97657964
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658040
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658092
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97658093
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97658100
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97658100
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97658107
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97658107
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658168
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97658169
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658172
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658172
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658176
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658176
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658220
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658296
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658348
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97658349
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97658356
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97658356
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97658364
Sep  3 18:57:20 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97658364
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658424
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97658425

Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658428
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658428
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658432
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658432
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658476
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658552
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658604
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97658605
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97658612
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97658612
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97658619
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97658619
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658680
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97658681
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658684
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658684
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658688
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658688
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658732
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658808
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97658860
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97658861
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2208, jiffies=97658870
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2208, jiffies=97658870
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2320, jiffies=97658877
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2320, jiffies=97658877
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658936
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97658937
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658940
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97658940
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658944
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97658944
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97658988
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659064
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659116
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97659117
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2192, jiffies=97659125
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2192, jiffies=97659125
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97659132
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97659132
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659192
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97659193
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659196
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659196
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97659199
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97659200
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97659200
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659244
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659320
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659372
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97659373
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97659380
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97659380
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97659388
Sep  3 18:57:21 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97659388

Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659448
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97659449
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659452
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659452
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97659456
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97659456
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659500
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659576
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659628
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97659629
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97659636
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97659636
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97659644
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2304, jiffies=97659644
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659704
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97659705
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659708
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659708
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97659712
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=128, jiffies=97659712
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659756
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659832
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97659884
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97659885
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97659892
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2176, jiffies=97659892
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97659899
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2288, jiffies=97659899
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97659960
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97659961
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659964
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=64, jiffies=97659964
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97659967
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=112, jiffies=97659967
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97660012
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97660088
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97660140
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2064, jiffies=97660141
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97660216
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97660217
Sep  3 18:57:22 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97660344
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97661518
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97661521
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97661521
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97661523
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97661523
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97661646
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97661774
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97661774
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97661777
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97661777
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97661779
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97661779
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97661902
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662030

Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662030
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97662033
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97662033
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97662035
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97662035
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97662158
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662286
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662286
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97662289
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=48, jiffies=97662289
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97662291
Sep  3 18:57:24 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=80, jiffies=97662291
Sep  3 18:57:25 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97662414
Sep  3 18:57:25 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662542
Sep  3 18:57:25 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662542
Sep  3 18:57:25 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=16, jiffies=97662543
Sep  3 18:57:25 localhost last message repeated 3 times
Sep  3 18:57:25 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=2048, jiffies=97662670
Sep  3 18:57:25 localhost kernel: giovanni line: 292, dpcm->frac_pos /
HZ=0, jiffies=97662798
