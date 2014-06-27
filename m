From: =?UTF-8?B?6rmA7J2A7Z2s?= <exeriment@gmail.com>
Subject: infinity wait in snd_pcm_wait_nocheck
Date: Fri, 27 Jun 2014 11:40:42 +0900
Message-ID: <CAKHxhgoO40+uSt+_xC6bQM0HubeZ_ngOM=7-aBHZiqtdMC=pbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f195.google.com (mail-ob0-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C6983261ADC
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 04:40:43 +0200 (CEST)
Received: by mail-ob0-f195.google.com with SMTP id va2so1288101obc.2
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 19:40:42 -0700 (PDT)
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

My system plays and captures short streams using by dmix device after boot.
But that system sometimes go infinity wait state when stream plays.
I use alsa-lib-1.0.24.1. but v1.0.27 and 1.0.28 also occur same err.
So I have below questions.
- What event that poll (in snd_pcm_wait_nocheck) wait?
I know snd_pcm_wait function is for wait PCM ready. But I want to know
details.
- How can I avoid that problem?
I changed timeout(in snd_pcm_wait) from -1 to 100. But system go infinity
loop.

And I attach status and params when this problem occurred.
- status
state: RUNNING
owner_pid   : 1213
trigger_time: 5.285075511
tstamp      : 5.333190511
delay       : -832
avail       : 17216
avail_max   : 17216
-----
hw_ptr      : 832
appl_ptr    : 0
- hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 16384
- sw_params
tstamp_mode: ENABLE
period_step: 1
avail_min: 1024
start_threshold: 1
stop_threshold: 1073741824
silence_threshold: 0
silence_size: 1073741824
boundary: 1073741824

Please reply about it.
Thanks.

-----
Eunhee Kim
