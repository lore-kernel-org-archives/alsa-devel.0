From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 17:26:18 +0200
Message-ID: <7c5010d60909030826k122fa855t153458431cd18909@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de> <s5heiqoqfh4.wl%tiwai@suse.de>
	<7c5010d60909030723l44055b5au84a487d78ef6252f@mail.gmail.com>
	<s5hbplsqeye.wl%tiwai@suse.de>
	<7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
	<7c5010d60909030803h1c354c79ob774683d764ea062@mail.gmail.com>
	<s5h4orkqd22.wl%tiwai@suse.de>
	<7c5010d60909030812k5f865622i5cddcd978788c338@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DF5D1038A2
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 17:26:21 +0200 (CEST)
Received: by bwz25 with SMTP id 25so10207bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 08:26:19 -0700 (PDT)
In-Reply-To: <7c5010d60909030812k5f865622i5cddcd978788c338@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 5:12 PM, Giovanni
Maruzzelli<gmaruzz.lists@gmail.com> wrote:
>
> I'll do it and report
>

I put hrtimer=0

I put the printk immediately after the spin_unlock, just before
return, this is a some second run (gave me bad behavior, as before,
maybe worst):

Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837395
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91837398
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91837398
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=80, jiffies=91837400
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=80, jiffies=91837400
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837448
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91837523
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91837576
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91837576
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91837582
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91837583
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91837583
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837651
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=16, jiffies=91837652
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91837655
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91837655
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=96, jiffies=91837657
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=96, jiffies=91837657
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837704
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91837779
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91837832
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91837832
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91837838
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91837838
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91837846
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91837846
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837907
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837907
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91837911
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91837911
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91837915
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91837915
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91837960
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838035
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838088
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838088
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91838094
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91838094
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91838102
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91838102
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838163
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838163
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91838167
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91838167
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91838170
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91838170
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838216
Sep  3 17:20:20 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838291
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838344
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838344
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91838350
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91838350
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2256, jiffies=91838357
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2256, jiffies=91838357
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838419
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838419

Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91838422
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91838422
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91838426
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91838426
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838472
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838547
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838600
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838600
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91838607
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91838607
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91838614
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91838614
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838675
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838675
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91838679
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91838679
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91838683
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91838683
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838728
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838803
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838856
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91838856
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91838863
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91838863
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2256, jiffies=91838869
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91838870
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91838870
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838931
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838931
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91838935
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91838935
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91838938
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91838938
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91838984
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839059
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839112
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839112
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91839118
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91839119
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91839126
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91839126
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839187
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839187
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91839191
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91839191
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839194
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839194
Sep  3 17:20:21 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839240
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839315
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839368
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839368
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91839374
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91839375
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91839382
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91839382
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839443

Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839443
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91839447
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91839447
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839450
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839450
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839496
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839571
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839624
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839624
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91839630
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2144, jiffies=91839630
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2256, jiffies=91839637
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2256, jiffies=91839637
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839699
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839699
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91839702
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91839702
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839706
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839706
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839752
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839827
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839880
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91839880
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91839888
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91839888
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91839896
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91839896
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839955
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91839955
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91839959
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91839959
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839962
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91839962
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840008
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840083
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840136
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840136
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91840144
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91840144
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91840151
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91840151
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840211
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840211
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91840215
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91840215
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91840218
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91840218
Sep  3 17:20:22 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840264
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840339
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840392
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840392
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91840399
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91840399
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91840407
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91840407
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840467

Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840467
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91840471
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91840471
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91840474
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91840474
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840520
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840595
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840648
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840648
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91840655
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91840655
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91840663
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91840663
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840723
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840723
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91840727
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91840727
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91840731
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91840731
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840776
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840851
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840904
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91840904
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91840911
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91840911
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91840920
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91840920
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840979
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91840979
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91840982
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91840982
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91840986
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91840986
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841032
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841107
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841160
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841160
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841167
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841167
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91841174
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91841174
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841235
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841235
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91841239
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91841239
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91841242
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91841243
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91841243
Sep  3 17:20:23 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841288
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841363
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841416
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841416
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841423
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841423
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91841431
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91841431

Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841491
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841491
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91841495
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91841495
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91841498
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91841498
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841544
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841619
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841672
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841672
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841679
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841679
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91841687
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91841688
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91841688
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841747
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841747
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91841751
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91841751
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91841754
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91841755
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91841755
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91841800
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841875
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841928
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91841928
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841935
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91841935
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91841943
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91841943
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842003
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842003
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91842007
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91842007
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91842010
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91842010
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842056
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842131
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842184
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842184
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91842191
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91842191
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91842198
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91842198
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842259
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842259
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91842262
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91842262
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91842266
Sep  3 17:20:24 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91842266
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842312
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842387
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842440
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842440
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91842448
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91842448

Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91842456
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91842456
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842515
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842515
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91842519
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91842519
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91842523
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91842523
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842568
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842643
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842696
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842696
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91842704
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91842704
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91842711
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91842711
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842771
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842771
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91842775
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91842775
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91842778
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91842778
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91842824
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842899
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842952
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91842952
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91842959
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91842959
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91842966
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2272, jiffies=91842966
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843027
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843027
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91843031
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91843031
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843034
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843034
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843080
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843155
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843208
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843208
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91843215
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91843215
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91843223
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91843224
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91843224
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843283
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843283
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91843287
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91843287
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843290
Sep  3 17:20:25 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843290
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843336
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843411
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843464
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843464
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91843471

Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2160, jiffies=91843471
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91843479
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91843479
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843539
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843539
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91843542
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91843542
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843546
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843546
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843592
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843667
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843720
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843720
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91843728
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91843728
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91843736
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91843736
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843795
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843795
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91843798
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91843799
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843802
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91843802
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91843848
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843923
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843976
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91843976
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91843984
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91843984
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2288, jiffies=91843991
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91843992
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91843992
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91844051
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91844051
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=48, jiffies=91844054
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91844055
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91844058
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91844059
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=128, jiffies=91844059
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91844104
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91844179
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91844232
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91844232
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91844240
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2176, jiffies=91844240
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91844248
Sep  3 17:20:26 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2304, jiffies=91844248
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91844307
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91844307
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91844311
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=64, jiffies=91844311
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91844314
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=112, jiffies=91844314
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=0, jiffies=91844360
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91844435
Sep  3 17:20:27 localhost kernel: giovanni line: 291, dpcm->frac_pos /
HZ=2048, jiffies=91844488
